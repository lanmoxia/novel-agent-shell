[CmdletBinding()]
param()

$ErrorActionPreference = "Continue"

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$ProjectsDir = Join-Path $RootDir "projects"
$Errors = 0
$Warnings = 0

function Add-InfoMessage {
    param([string]$Message)
    Write-Output ("[validate-edu-shortdrama-project] [info] " + $Message)
}

function Add-WarningMessage {
    param([string]$Message)
    Write-Output ("[validate-edu-shortdrama-project] [warn] " + $Message)
    $script:Warnings++
}

function Add-ErrorMessage {
    param([string]$Message)
    [Console]::Error.WriteLine("[validate-edu-shortdrama-project] [error] " + $Message)
    $script:Errors++
}

function Test-TemplateProjectName {
    param([string]$Name)
    return $Name -eq "_template" -or $Name -eq "_template-edu-shortdrama"
}

function Test-JsonField {
    param(
        [object]$Object,
        [string]$Path
    )
    $Current = $Object
    foreach ($Part in ($Path -split "\.")) {
        if ($null -eq $Current -or $null -eq $Current.PSObject.Properties[$Part]) {
            return $false
        }
        $Current = $Current.PSObject.Properties[$Part].Value
    }
    return $true
}

function Get-JsonFieldValue {
    param(
        [object]$Object,
        [string]$Path
    )
    $Current = $Object
    foreach ($Part in ($Path -split "\.")) {
        if ($null -eq $Current -or $null -eq $Current.PSObject.Properties[$Part]) {
            return $null
        }
        $Current = $Current.PSObject.Properties[$Part].Value
    }
    return $Current
}

function Get-JsonFieldType {
    param(
        [object]$Object,
        [string]$Path
    )
    $Value = $Object
    foreach ($Part in ($Path -split "\.")) {
        if ($null -eq $Value -or $null -eq $Value.PSObject.Properties[$Part]) {
            return $null
        }
        $Value = $Value.PSObject.Properties[$Part].Value
    }
    if ($null -eq $Value) {
        return "null"
    }
    if ($Value -is [bool]) {
        return "bool"
    }
    if ($Value -is [byte] -or $Value -is [int16] -or $Value -is [int32] -or $Value -is [int64]) {
        return "int"
    }
    if ($Value -is [string]) {
        return "string"
    }
    if ($Value -is [array]) {
        return "array"
    }
    if ($Value -is [pscustomobject]) {
        return "object"
    }
    return $Value.GetType().Name
}

function New-TextFromCodepoints {
    param([int[]]$Codepoints)
    $Chars = foreach ($Codepoint in $Codepoints) {
        [char]$Codepoint
    }
    return -join $Chars
}

function Require-File {
    param(
        [string]$Project,
        [string]$ProjectDir,
        [string]$RelativePath
    )
    $Target = Join-Path $ProjectDir $RelativePath
    if (-not (Test-Path -LiteralPath $Target -PathType Leaf)) {
        Add-ErrorMessage -Message ($Project + ": missing " + $RelativePath.Replace("\", "/"))
    }
}

function Require-JsonField {
    param(
        [string]$Project,
        [object]$State,
        [string]$Field
    )
    if (-not (Test-JsonField -Object $State -Path $Field)) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json missing required field: " + $Field)
    }
}

function Require-JsonType {
    param(
        [string]$Project,
        [object]$State,
        [string]$Field,
        [string]$Expected
    )
    $Actual = Get-JsonFieldType -Object $State -Path $Field
    if ($null -eq $Actual) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json missing required field: " + $Field)
        return
    }
    if ($Actual -ne $Expected) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json field " + $Field + " must be " + $Expected + ", got " + $Actual + ".")
    }
}

function Require-JsonValue {
    param(
        [string]$Project,
        [object]$State,
        [string]$Field,
        [string]$Expected
    )
    if (-not (Test-JsonField -Object $State -Path $Field)) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json missing required field: " + $Field)
        return
    }
    $Actual = [string](Get-JsonFieldValue -Object $State -Path $Field)
    if ($Actual -ne $Expected) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json field " + $Field + " must be '" + $Expected + "', got '" + $Actual + "'.")
    }
}

function Require-ConfirmedTrue {
    param(
        [string]$Project,
        [object]$State,
        [string]$Key
    )
    $Path = "confirmedArtifacts." + $Key
    $Value = Get-JsonFieldValue -Object $State -Path $Path
    if ($Value -ne $true) {
        Add-ErrorMessage -Message ($Project + ": confirmedArtifacts." + $Key + " must be true.")
    }
}

function Require-TextAny {
    param(
        [string]$Project,
        [string]$ProjectDir,
        [string]$RelativePath,
        [string]$Label,
        [string[]]$Needles
    )
    $Target = Join-Path $ProjectDir $RelativePath
    $DisplayPath = $RelativePath.Replace("\", "/")
    if (-not (Test-Path -LiteralPath $Target -PathType Leaf)) {
        Add-ErrorMessage -Message ($Project + ": " + $DisplayPath + " missing; cannot check " + $Label + ".")
        return
    }
    $Text = Get-Content -LiteralPath $Target -Raw -Encoding UTF8
    foreach ($Needle in $Needles) {
        if ($Text.Contains($Needle)) {
            return
        }
    }
    Add-ErrorMessage -Message ($Project + ": " + $DisplayPath + " missing required semantic keyword for " + $Label + ": " + ($Needles -join " "))
}

function Get-NonReadmeFileCount {
    param([string]$Directory)
    if (-not (Test-Path -LiteralPath $Directory -PathType Container)) {
        return 0
    }
    return @(Get-ChildItem -LiteralPath $Directory -File | Where-Object { $_.Name -ne "README.md" }).Count
}

function Test-EduProject {
    param(
        [string]$Project,
        [string]$ProjectDir
    )

    Add-InfoMessage -Message ($Project + ": checking edu-shortdrama project instance.")

    foreach ($File in @(
        "PROJECT.md",
        "PROJECT-STATE.json",
        "GENRE-SKILL-LOCK.md",
        "specs/STORY-SPEC.md",
        "planning/ENDING-LOCK.md",
        "outlines/OUTLINE.md",
        "scripts/SCRIPT-STATUS.md",
        "RUN-LOG.md",
        "PROJECT-MEMORY.md"
    )) {
        Require-File -Project $Project -ProjectDir $ProjectDir -RelativePath $File
    }

    $StatePath = Join-Path $ProjectDir "PROJECT-STATE.json"
    try {
        $State = Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json is not valid JSON.")
        return
    }

    foreach ($Field in @(
        "project",
        "projectType",
        "skillId",
        "phase",
        "status",
        "locked",
        "confirmedArtifacts",
        "eduTextStatus",
        "sceneMappingStatus",
        "scriptStatus",
        "subtitleStatus",
        "shotlistStatus",
        "reviewStatus",
        "productionPackageStatus",
        "lockedArtifacts",
        "lastUpdated",
        "notes"
    )) {
        Require-JsonField -Project $Project -State $State -Field $Field
    }

    Require-JsonValue -Project $Project -State $State -Field "project" -Expected $Project
    Require-JsonValue -Project $Project -State $State -Field "projectType" -Expected "edu-shortdrama"
    Require-JsonValue -Project $Project -State $State -Field "skillId" -Expected "wenyan-skill"
    Require-JsonType -Project $Project -State $State -Field "phase" -Expected "int"
    Require-JsonType -Project $Project -State $State -Field "status" -Expected "string"
    Require-JsonType -Project $Project -State $State -Field "locked" -Expected "bool"
    Require-JsonType -Project $Project -State $State -Field "confirmedArtifacts" -Expected "object"
    Require-JsonType -Project $Project -State $State -Field "lockedArtifacts" -Expected "array"
    Require-JsonType -Project $Project -State $State -Field "notes" -Expected "array"

    $Phase = -1
    if (-not [int]::TryParse([string]$State.phase, [ref]$Phase) -or $Phase -lt 0 -or $Phase -gt 8) {
        Add-ErrorMessage -Message ($Project + ": PROJECT-STATE.json phase must be an integer from 0 to 8.")
        $Phase = -1
    }

    if ($Phase -ge 0) {
        Require-File -Project $Project -ProjectDir $ProjectDir -RelativePath "PROJECT.md"
        Require-ConfirmedTrue -Project $Project -State $State -Key "projectMd"
    }
    if ($Phase -ge 1) {
        Require-File -Project $Project -ProjectDir $ProjectDir -RelativePath "GENRE-SKILL-LOCK.md"
        Require-ConfirmedTrue -Project $Project -State $State -Key "genreSkillLock"
    }
    if ($Phase -ge 2) {
        Require-File -Project $Project -ProjectDir $ProjectDir -RelativePath "specs/STORY-SPEC.md"
        Require-File -Project $Project -ProjectDir $ProjectDir -RelativePath "planning/ENDING-LOCK.md"
        Require-ConfirmedTrue -Project $Project -State $State -Key "storySpec"
        Require-ConfirmedTrue -Project $Project -State $State -Key "endingLock"
        Require-ConfirmedTrue -Project $Project -State $State -Key "originalTextAnalysis"
    }
    if ($Phase -ge 3) {
        Require-File -Project $Project -ProjectDir $ProjectDir -RelativePath "outlines/OUTLINE.md"
        Require-ConfirmedTrue -Project $Project -State $State -Key "outline"
        Require-ConfirmedTrue -Project $Project -State $State -Key "sceneMapping"
    }
    if ($Phase -ge 4) {
        Require-File -Project $Project -ProjectDir $ProjectDir -RelativePath "scripts/SCRIPT-STATUS.md"
        Require-ConfirmedTrue -Project $Project -State $State -Key "script"
        $ScriptsDir = Join-Path $ProjectDir "scripts"
        $DraftFiles = @(Get-ChildItem -LiteralPath $ScriptsDir -File -Filter "*.md" | Where-Object { $_.Name -ne "SCRIPT-STATUS.md" })
        if (-not (Test-Path -LiteralPath (Join-Path $ScriptsDir "SMOKE-DRAFT.md") -PathType Leaf) -and $DraftFiles.Count -eq 0) {
            Add-ErrorMessage -Message ($Project + ": phase " + $Phase + " requires scripts/SMOKE-DRAFT.md or another explicit shortdrama draft file.")
        }
    }

    if ($Phase -lt 5 -and (Test-Path -LiteralPath (Join-Path $ProjectDir "reviews/final-review.md") -PathType Leaf)) {
        Add-ErrorMessage -Message ($Project + ": phase " + $Phase + " must not have reviews/final-review.md.")
    }
    if ($Phase -lt 7) {
        foreach ($File in @("locked/FINAL-SCRIPT.md", "locked/LOCK-MANIFEST.sha256", "locked/SKILL-LOCK-MANIFEST.sha256")) {
            if (Test-Path -LiteralPath (Join-Path $ProjectDir $File) -PathType Leaf) {
                Add-ErrorMessage -Message ($Project + ": phase " + $Phase + " must not have " + $File + ".")
            }
        }
    }
    if ($Phase -lt 8) {
        foreach ($PostDir in @("short-drama-shotlists", "seedance-prompts")) {
            $PostCount = Get-NonReadmeFileCount -Directory (Join-Path $ProjectDir $PostDir)
            if ($PostCount -gt 0) {
                Add-ErrorMessage -Message ($Project + ": phase " + $Phase + " must not have formal post-production files under " + $PostDir + "/.")
            }
        }
    }

    $OriginalText = New-TextFromCodepoints -Codepoints @(0x539F, 0x6587)
    $PlainTranslation = New-TextFromCodepoints -Codepoints @(0x767D, 0x8BDD)
    $TeachingObjective = New-TextFromCodepoints -Codepoints @(0x6559, 0x5B66, 0x76EE, 0x6807)
    $NonRewritableFacts = New-TextFromCodepoints -Codepoints @(0x4E0D, 0x53EF, 0x6539, 0x5199, 0x4E8B, 0x5B9E)
    $Subtitle = New-TextFromCodepoints -Codepoints @(0x5B57, 0x5E55)
    $VideoGenerationRisk = New-TextFromCodepoints -Codepoints @(0x89C6, 0x9891, 0x751F, 0x6210, 0x98CE, 0x9669)
    $VideoRisk = New-TextFromCodepoints -Codepoints @(0x89C6, 0x9891, 0x98CE, 0x9669)
    $SmokeDraft = New-TextFromCodepoints -Codepoints @(0x70DF, 0x6D4B, 0x8349, 0x6848)
    $NotFinalProduction = New-TextFromCodepoints -Codepoints @(0x4E0D, 0x662F, 0x6700, 0x7EC8, 0x751F, 0x4EA7, 0x7A3F)
    $NotFormalProduction = New-TextFromCodepoints -Codepoints @(0x4E0D, 0x4EE3, 0x8868, 0x6B63, 0x5F0F, 0x751F, 0x4EA7, 0x7A3F)

    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "specs/STORY-SPEC.md" -Label "original text" -Needles @($OriginalText)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "specs/STORY-SPEC.md" -Label "plain translation" -Needles @($PlainTranslation)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "specs/STORY-SPEC.md" -Label "teaching objectives" -Needles @($TeachingObjective)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "specs/STORY-SPEC.md" -Label "non-rewritable facts" -Needles @($NonRewritableFacts)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "outlines/OUTLINE.md" -Label "scene mapping" -Needles @("Scene")
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "outlines/OUTLINE.md" -Label "original text mapping" -Needles @($OriginalText)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "outlines/OUTLINE.md" -Label "subtitle notes" -Needles @($Subtitle)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "outlines/OUTLINE.md" -Label "video risk" -Needles @($VideoGenerationRisk, $VideoRisk)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "scripts/SCRIPT-STATUS.md" -Label "phase label" -Needles @("Phase 4")
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "scripts/SCRIPT-STATUS.md" -Label "smoke draft status" -Needles @($SmokeDraft)
    Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "scripts/SCRIPT-STATUS.md" -Label "not final production" -Needles @($NotFinalProduction, $NotFormalProduction)
    if (Test-Path -LiteralPath (Join-Path $ProjectDir "scripts/SMOKE-DRAFT.md") -PathType Leaf) {
        Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "scripts/SMOKE-DRAFT.md" -Label "smoke draft label" -Needles @($SmokeDraft)
        Require-TextAny -Project $Project -ProjectDir $ProjectDir -RelativePath "scripts/SMOKE-DRAFT.md" -Label "not final production" -Needles @($NotFinalProduction)
    }
}

if (-not (Test-Path -LiteralPath $ProjectsDir -PathType Container)) {
    Add-ErrorMessage -Message "Missing projects/ directory."
    exit 1
}

$Found = 0
Get-ChildItem -LiteralPath $ProjectsDir -Directory | ForEach-Object {
    $Name = $_.Name
    if ((Test-TemplateProjectName -Name $Name) -or $Name -like "test-*" -or $Name -like "*-smoke-test") {
        return
    }
    $StatePath = Join-Path $_.FullName "PROJECT-STATE.json"
    if (-not (Test-Path -LiteralPath $StatePath -PathType Leaf)) {
        return
    }
    try {
        $State = Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        return
    }
    if ($State.projectType -eq "edu-shortdrama") {
        $Found++
        Test-EduProject -Project $Name -ProjectDir $_.FullName
    }
}

if ($Found -eq 0) {
    Add-WarningMessage -Message "No edu-shortdrama project instances found under projects/."
}

Write-Output ("[validate-edu-shortdrama-project] Completed with " + $Errors + " error(s), " + $Warnings + " warning(s).")
if ($Errors -gt 0) {
    exit 1
}

exit 0
