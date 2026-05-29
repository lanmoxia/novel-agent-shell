[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter(Position = 0)]
    [string]$ProjectName
)

$ErrorActionPreference = "Continue"

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$ProjectsDir = Join-Path $RootDir "projects"
$Errors = 0
$Warnings = 0

function Show-Usage {
    Write-Output "Usage: powershell -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1 [project-name]"
}

function Add-ErrorMessage {
    param([string]$Message)
    Write-Error "[validate-project-state] $Message"
    $script:Errors++
}

function Add-WarningMessage {
    param([string]$Message)
    Write-Warning "[validate-project-state] $Message"
    $script:Warnings++
}

function Test-TemplateProjectName {
    param([string]$Name)
    return $Name -eq "_template" -or $Name -eq "_template-edu-shortdrama"
}

function Get-StateBool {
    param(
        [object]$State,
        [string]$Name
    )
    if ($null -eq $State.PSObject.Properties[$Name]) {
        return $null
    }
    return [bool]$State.$Name
}

function Get-ConfirmedArtifact {
    param(
        [object]$State,
        [string]$Name
    )
    if ($null -eq $State.confirmedArtifacts -or $null -eq $State.confirmedArtifacts.PSObject.Properties[$Name]) {
        return $null
    }
    return [bool]$State.confirmedArtifacts.$Name
}

function Require-ConfirmedFile {
    param(
        [string]$Project,
        [string]$ProjectDir,
        [object]$State,
        [string]$Key,
        [string]$RelativePath
    )
    $Confirmed = Get-ConfirmedArtifact -State $State -Name $Key
    if ($Confirmed -eq $true) {
        $Target = Join-Path $ProjectDir $RelativePath
        if (-not (Test-Path -LiteralPath $Target -PathType Leaf)) {
            Add-ErrorMessage -Message ($Project + ": confirmedArtifacts." + $Key + " is true but " + $RelativePath + " is missing.")
        }
    }
}

function Require-Gate {
    param(
        [string]$Project,
        [object]$State,
        [string]$Key,
        [int]$Phase
    )
    $Confirmed = Get-ConfirmedArtifact -State $State -Name $Key
    if ($Confirmed -ne $true) {
        Add-ErrorMessage -Message ($Project + ": phase " + $Phase + " requires confirmedArtifacts." + $Key + " to be true.")
    }
}

function Get-ChapterCount {
    param([string]$ProjectDir)
    $ScriptsDir = Join-Path $ProjectDir "scripts"
    if (-not (Test-Path -LiteralPath $ScriptsDir -PathType Container)) {
        return 0
    }
    return @(Get-ChildItem -LiteralPath $ScriptsDir -File -Filter "*.md" | Where-Object { $_.Name -ne "SCRIPT-STATUS.md" }).Count
}

function Test-TextContainsCodepoints {
    param(
        [string]$Text,
        [int[]]$Codepoints
    )
    if ($null -eq $Text) {
        return $false
    }
    $Chars = foreach ($Codepoint in $Codepoints) {
        [char]$Codepoint
    }
    $Needle = -join $Chars
    return $Text.Contains($Needle)
}

function New-TextFromCodepoints {
    param([int[]]$Codepoints)
    $Chars = foreach ($Codepoint in $Codepoints) {
        [char]$Codepoint
    }
    return -join $Chars
}

function Test-ProjectState {
    param([string]$Project)

    $ProjectDir = Join-Path $ProjectsDir $Project
    $StatePath = Join-Path $ProjectDir "PROJECT-STATE.json"
    $RunLog = Join-Path $ProjectDir "RUN-LOG.md"

    if (-not (Test-Path -LiteralPath $ProjectDir -PathType Container)) {
        Add-ErrorMessage -Message ($Project + ": missing project directory.")
        return
    }
    if (-not (Test-Path -LiteralPath $StatePath -PathType Leaf)) {
        Add-ErrorMessage -Message ($Project + ": missing PROJECT-STATE.json. Run scripts/migrate-project first.")
        return
    }
    if (-not (Test-Path -LiteralPath $RunLog -PathType Leaf)) {
        Add-WarningMessage -Message ($Project + ": missing RUN-LOG.md; recovery will not have a next-step trail.")
    }

    try {
        $State = Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json is not valid JSON.")
        return
    }

    if ($null -ne $State.PSObject.Properties["projectType"] -and $State.projectType -eq "edu-shortdrama") {
        Write-Output ("[validate-project-state] [info] " + $Project + ": edu-shortdrama state skipped from legacy recovery validation; handled by validate-edu-shortdrama-project.")
        return
    }

    if ([string]::IsNullOrWhiteSpace([string]$State.project)) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json missing project.")
    } elseif ($State.project -ne $Project) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json project is '" + $State.project + "'.")
    }

    $Phase = $null
    if ($null -eq $State.PSObject.Properties["phase"] -or -not [int]::TryParse([string]$State.phase, [ref]$Phase) -or $Phase -lt 0 -or $Phase -gt 8) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json phase must be an integer from 0 to 8.")
        $Phase = -1
    }

    if ([string]::IsNullOrWhiteSpace([string]$State.status)) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json missing status.")
    }

    $Locked = Get-StateBool -State $State -Name "locked"
    if ($null -eq $Locked) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json locked must be true or false.")
    }

    $ArtifactMap = [ordered]@{
        projectMd = "PROJECT.md"
        genreSkillLock = "GENRE-SKILL-LOCK.md"
        storySpec = "specs\STORY-SPEC.md"
        endingLock = "planning\ENDING-LOCK.md"
        outline = "outlines\OUTLINE.md"
        reverseOutline = "planning\REVERSE-OUTLINE.md"
        finalReview = "reviews\final-review.md"
        revisionLog = "revisions\revision-log.md"
        finalScript = "locked\FINAL-SCRIPT.md"
    }
    foreach ($Entry in $ArtifactMap.GetEnumerator()) {
        Require-ConfirmedFile -Project $Project -ProjectDir $ProjectDir -State $State -Key $Entry.Key -RelativePath $Entry.Value
    }

    if ($Phase -ge 1) {
        Require-Gate -Project $Project -State $State -Key "projectMd" -Phase $Phase
    }
    if ($Phase -ge 2) {
        Require-Gate -Project $Project -State $State -Key "genreSkillLock" -Phase $Phase
        $LockFile = Join-Path $ProjectDir "GENRE-SKILL-LOCK.md"
        $LockText = if (Test-Path -LiteralPath $LockFile -PathType Leaf) { Get-Content -LiteralPath $LockFile -Raw -Encoding UTF8 } else { "" }
        if (-not (Test-TextContainsCodepoints -Text $LockText -Codepoints @(0x72B6, 0x6001, 0xFF1A, 0x5DF2, 0x9501, 0x5B9A))) {
            Add-WarningMessage -Message ($Project + ": phase " + $Phase + " expects GENRE-SKILL-LOCK.md to say 状态：已锁定.")
        }
    }
    if ($Phase -ge 3) {
        Require-Gate -Project $Project -State $State -Key "storySpec" -Phase $Phase
        Require-Gate -Project $Project -State $State -Key "endingLock" -Phase $Phase
    }
    if ($Phase -ge 4) {
        Require-Gate -Project $Project -State $State -Key "outline" -Phase $Phase
        Require-Gate -Project $Project -State $State -Key "reverseOutline" -Phase $Phase
    }
    if ($Phase -ge 5 -and (Get-ChapterCount -ProjectDir $ProjectDir) -eq 0) {
        Add-ErrorMessage -Message ($Project + ": phase " + $Phase + " requires at least one script/chapter file under scripts/.")
    }
    if ($Phase -ge 6) {
        Require-Gate -Project $Project -State $State -Key "finalReview" -Phase $Phase
    }
    if ($Phase -ge 7) {
        Require-Gate -Project $Project -State $State -Key "finalScript" -Phase $Phase
        if ($Locked -ne $true) {
            Add-ErrorMessage -Message ($Project + ": phase " + $Phase + " requires PROJECT-STATE.json locked to be true.")
        }
    }

    $FinalScript = Join-Path $ProjectDir "locked\FINAL-SCRIPT.md"
    if ((Test-Path -LiteralPath $FinalScript -PathType Leaf) -and $Locked -ne $true) {
        Add-WarningMessage -Message ($Project + ": locked/FINAL-SCRIPT.md exists but PROJECT-STATE.json locked is not true.")
    }
    if ($Locked -eq $true -and -not (Test-Path -LiteralPath $FinalScript -PathType Leaf)) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json locked is true but locked/FINAL-SCRIPT.md is missing.")
    }
    if ($State.status -eq "locked" -and $Locked -ne $true) {
        Add-ErrorMessage -Message ($Project + ": status is locked but locked is not true.")
    }

    if (Test-Path -LiteralPath $RunLog -PathType Leaf) {
        $RunLogLines = Get-Content -LiteralPath $RunLog -Encoding UTF8
        $NextPrefix = "- " + (New-TextFromCodepoints -Codepoints @(0x4E0B, 0x4E00, 0x6B65, 0xFF1A))
        $PhasePrefix = "- " + (New-TextFromCodepoints -Codepoints @(0x5F53, 0x524D, 0x9636, 0x6BB5, 0xFF1A)) + "Phase "
        $HasNext = ($RunLogLines | Where-Object { $_.StartsWith($NextPrefix) }).Count -gt 0
        if (-not $HasNext) {
            Add-WarningMessage -Message ($Project + ": RUN-LOG.md has no next-step entry.")
        }
        if ($Phase -ge 0) {
            $LastPhaseLine = $RunLogLines | Where-Object { $_.StartsWith($PhasePrefix) } | Select-Object -Last 1
            if ($LastPhaseLine -and $LastPhaseLine -notlike "*Phase $Phase*") {
                Add-WarningMessage -Message ($Project + ": latest RUN-LOG phase does not match PROJECT-STATE.json phase " + $Phase + ".")
            }
        }
    }

    Write-Output ("[validate-project-state] [info] " + $Project + ": phase " + $Phase + ", status " + $State.status + ", locked " + $Locked + ".")
}

if ($ProjectName -in @("-h", "--help", "/?")) {
    Show-Usage
    exit 0
}

if (-not (Test-Path -LiteralPath $ProjectsDir -PathType Container)) {
    Add-ErrorMessage "Missing projects/ directory."
    exit 1
}

if (-not [string]::IsNullOrWhiteSpace($ProjectName)) {
    if (Test-TemplateProjectName -Name $ProjectName) {
        Add-ErrorMessage -Message ("Refusing template directory as active project: " + $ProjectName)
    } elseif ($ProjectName -like "test-*" -or $ProjectName -like "*-smoke-test" -or $ProjectName.StartsWith(".") -or $ProjectName.Contains("/") -or $ProjectName.Contains("\")) {
        Add-ErrorMessage -Message ("Refusing reserved/sample/invalid project: " + $ProjectName)
    } else {
        Test-ProjectState -Project $ProjectName
    }
} else {
    $ActiveCount = 0
    Get-ChildItem -LiteralPath $ProjectsDir -Directory | ForEach-Object {
        $Name = $_.Name
        if ((Test-TemplateProjectName -Name $Name) -or $Name -like "test-*" -or $Name -like "*-smoke-test") {
            return
        }
        $ActiveCount++
        Test-ProjectState -Project $Name
    }
    if ($ActiveCount -eq 0) {
        Add-WarningMessage "No active production projects found under projects/."
    }
}

Write-Output ("[validate-project-state] Completed with " + $Errors + " error(s), " + $Warnings + " warning(s).")
if ($Errors -gt 0) {
    exit 1
}
exit 0
