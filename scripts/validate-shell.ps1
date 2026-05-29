$ErrorActionPreference = "Continue"

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$Errors = 0
$Warnings = 0

function Add-ErrorMessage {
    param([string]$Message)
    Write-Error "[validate-shell] $Message"
    $script:Errors++
}

function Add-WarningMessage {
    param([string]$Message)
    Write-Warning "[validate-shell] $Message"
    $script:Warnings++
}

function Test-TemplateProjectName {
    param([string]$Name)
    return $Name -eq "_template" -or $Name -eq "_template-edu-shortdrama"
}

function Require-File {
    param([string]$Path)
    $FullPath = Join-Path $RootDir $Path
    if (-not (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
        Add-ErrorMessage "Missing file: $Path"
    }
}

function Require-Dir {
    param([string]$Path)
    $FullPath = Join-Path $RootDir $Path
    if (-not (Test-Path -LiteralPath $FullPath -PathType Container)) {
        Add-ErrorMessage "Missing directory: $Path"
    }
}

function Get-Frontmatter {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return @()
    }
    $Lines = Get-Content -LiteralPath $Path -Encoding UTF8
    if ($Lines.Count -eq 0 -or $Lines[0] -ne "---") {
        return @()
    }
    $Result = New-Object System.Collections.Generic.List[string]
    for ($i = 1; $i -lt $Lines.Count; $i++) {
        if ($Lines[$i] -eq "---") {
            break
        }
        $Result.Add($Lines[$i])
    }
    return $Result
}

function Test-FrontmatterField {
    param(
        [string]$Path,
        [string]$Field
    )
    $Frontmatter = Get-Frontmatter -Path $Path
    return ($Frontmatter | Where-Object { $_ -match "^$([regex]::Escape($Field)):\s*\S.*" }).Count -gt 0
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

function Test-SkillLockManifest {
    param(
        [string]$ProjectName,
        [string]$ProjectDir
    )
    $Manifest = Join-Path $ProjectDir "locked\SKILL-LOCK-MANIFEST.sha256"
    if (-not (Test-Path -LiteralPath $Manifest -PathType Leaf)) {
        Add-WarningMessage -Message ($ProjectName + ": locked/SKILL-LOCK-MANIFEST.sha256 is missing. Run scripts/update-skill-lock-manifest.")
        return
    }
    Get-Content -LiteralPath $Manifest -Encoding UTF8 | ForEach-Object {
        $Line = $_
        if ([string]::IsNullOrWhiteSpace($Line) -or $Line.StartsWith("#")) {
            return
        }
        $Parts = $Line -split "  ", 2
        if ($Parts.Count -ne 2) {
            Add-ErrorMessage -Message ($ProjectName + ": malformed skill lock manifest line: " + $Line)
            return
        }
        $ExpectedHash = $Parts[0]
        $RelativePath = $Parts[1]
        $ManifestFile = Join-Path $RootDir $RelativePath
        if (-not (Test-Path -LiteralPath $ManifestFile -PathType Leaf)) {
            Add-ErrorMessage -Message ($ProjectName + ": skill lock manifest references missing file: " + $RelativePath)
            return
        }
        $ActualHash = (Get-FileHash -LiteralPath $ManifestFile -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($ActualHash -ne $ExpectedHash) {
            Add-WarningMessage -Message ($ProjectName + ": locked genre Skill file changed after skill manifest: " + $RelativePath)
        }
    }
}

function Require-Frontmatter {
    param(
        [string]$Path,
        [string]$Label,
        [bool]$RequireVersion = $false
    )
    $FullPath = Join-Path $RootDir $Path
    if (-not (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
        Add-ErrorMessage "$Label missing: $Path"
        return
    }
    $FirstLine = Get-Content -LiteralPath $FullPath -Encoding UTF8 -TotalCount 1
    if ($FirstLine -ne "---") {
        Add-ErrorMessage "$Label must start with YAML frontmatter: $Path"
        return
    }
    if (-not (Test-FrontmatterField -Path $FullPath -Field "name")) {
        Add-ErrorMessage "$Label missing frontmatter field: name ($Path)"
    }
    if (-not (Test-FrontmatterField -Path $FullPath -Field "description")) {
        Add-ErrorMessage "$Label missing frontmatter field: description ($Path)"
    }
    if ($RequireVersion -and -not (Test-FrontmatterField -Path $FullPath -Field "version")) {
        Add-WarningMessage "$Label missing optional frontmatter field: version ($Path)"
    }
}

Write-Output "[validate-shell] Checking repository structure..."
foreach ($Dir in @("workflow", "workflow/hooks", "workflow/skills", "workflow/agents", "workflow/feedback", "workflow/theory", "workflow/execution", "workflow/modes", "docs", "docs/reports", "genre-skills", "projects/_template")) {
    Require-Dir $Dir
}
Require-Dir "workflow/feedback/proposals"
Require-File "workflow/ORCHESTRATION.md"
Require-File "workflow/feedback/proposals/TEMPLATE.md"

if (Test-Path -LiteralPath (Join-Path $RootDir ".claude") -PathType Container) {
    Add-WarningMessage ".claude/ exists. Current workflow assets should live under workflow/."
}

Write-Output "[validate-shell] Checking workflow assets..."
foreach ($Skill in @("project-intake-builder", "genre-loader", "story-spec-builder", "outline-builder", "script-writer", "script-review", "revision-fixer", "script-locker", "post-production-builder")) {
    Require-Frontmatter "workflow/skills/$Skill/SKILL.md" "workflow skill $Skill"
}
foreach ($Agent in @("structure-reviewer", "continuity-reviewer", "dialogue-reviewer", "genre-reviewer", "feedback-observer", "evolution-runner")) {
    Require-Frontmatter "workflow/agents/$Agent.md" "workflow agent $Agent"
}
foreach ($Hook in @("check-evolution.sh", "detect-feedback-signal.sh", "stage-gate.sh", "stop-gate.sh")) {
    Require-File "workflow/hooks/$Hook"
}
Require-File "scripts/update-skill-lock-manifest.sh"
Require-File "scripts/update-skill-lock-manifest.ps1"
Require-File "scripts/project-status.sh"
Require-File "scripts/project-status.ps1"
Require-File "scripts/validate-edu-shortdrama-template.ps1"
Require-File "scripts/validate-edu-shortdrama-project.ps1"
Require-File "scripts/validate-project-state.sh"
Require-File "scripts/validate-project-state.ps1"
Require-File "scripts/new-proposal.sh"
Require-File "scripts/new-proposal.ps1"

$Bash = Get-Command bash -ErrorAction SilentlyContinue
if ($Bash) {
    foreach ($Hook in @("check-evolution.sh", "detect-feedback-signal.sh", "stage-gate.sh", "stop-gate.sh")) {
        & bash -n (Join-Path $RootDir "workflow/hooks/$Hook")
        if ($LASTEXITCODE -ne 0) {
            Add-ErrorMessage "Hook syntax check failed: workflow/hooks/$Hook"
        }
    }
} else {
    Add-WarningMessage "bash not found; skipped hook syntax checks."
}

Write-Output "[validate-shell] Checking project template..."
foreach ($Path in @(
    "projects/_template/PROJECT.md",
    "projects/_template/GENRE-SKILL-LOCK.md",
    "projects/_template/PROJECT-MEMORY.md",
    "projects/_template/PROJECT-STATE.json",
    "projects/_template/RUN-LOG.md",
    "projects/_template/specs/STORY-SPEC.md",
    "projects/_template/outlines/OUTLINE.md",
    "projects/_template/scripts/SCRIPT-STATUS.md",
    "projects/_template/planning/ENDING-LOCK.md",
    "projects/_template/planning/REVERSE-OUTLINE.md",
    "projects/_template/planning/FORESHADOW-LEDGER.md",
    "projects/_template/planning/REVEAL-SCHEDULE.md"
)) {
    Require-File $Path
}
foreach ($Path in @(
    "projects/_template/reviews",
    "projects/_template/revisions",
    "projects/_template/revisions/snapshots",
    "projects/_template/locked",
    "projects/_template/planning",
    "projects/_template/materials",
    "projects/_template/drafts",
    "projects/_template/drafts/rewrite-candidates",
    "projects/_template/shotlists",
    "projects/_template/short-drama-shotlists",
    "projects/_template/seedance-prompts"
)) {
    Require-Dir $Path
}

Write-Output "[validate-shell] Checking edu shortdrama project template..."
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RootDir "scripts\validate-edu-shortdrama-template.ps1")
if ($LASTEXITCODE -ne 0) {
    Add-ErrorMessage "Edu shortdrama template validation failed."
}

Write-Output "[validate-shell] Checking active projects..."
$ProjectsDir = Join-Path $RootDir "projects"
$ActiveCount = 0
Get-ChildItem -LiteralPath $ProjectsDir -Directory | ForEach-Object {
    $Name = $_.Name
    $ProjectFullName = $_.FullName
    if (Test-TemplateProjectName -Name $Name) {
        return
    }
    if ($Name -like "test-*" -or $Name -like "*-smoke-test") {
        Write-Output ("[validate-shell] [info] " + $Name + ": sample/test project present; do not use it as a production template.")
        return
    }
    $StateFile = Join-Path $ProjectFullName "PROJECT-STATE.json"
    if (Test-Path -LiteralPath $StateFile -PathType Leaf) {
        try {
            $StateForType = Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8 | ConvertFrom-Json
            if ($StateForType.projectType -eq "edu-shortdrama") {
                Write-Output ("[validate-shell] [info] " + $Name + ": edu-shortdrama project skipped from legacy active project validation; handled by validate-edu-shortdrama-project.")
                return
            }
        } catch {
            # Keep malformed state files in legacy validation so the existing checks can report them.
        }
    }
    $ActiveCount++
    foreach ($Path in @("PROJECT.md", "PROJECT-STATE.json", "RUN-LOG.md", "GENRE-SKILL-LOCK.md", "PROJECT-MEMORY.md")) {
        if (-not (Test-Path -LiteralPath (Join-Path $ProjectFullName $Path) -PathType Leaf)) {
            Add-ErrorMessage "$Name missing $Path"
        }
    }
    foreach ($Path in @("specs", "outlines", "planning", "materials", "scripts", "drafts", "drafts\rewrite-candidates", "reviews", "revisions", "revisions\snapshots", "locked")) {
        if (-not (Test-Path -LiteralPath (Join-Path $ProjectFullName $Path) -PathType Container)) {
            Add-ErrorMessage "$Name missing $Path/"
        }
    }
    foreach ($Path in @("planning\ENDING-LOCK.md", "planning\REVERSE-OUTLINE.md", "planning\FORESHADOW-LEDGER.md", "planning\REVEAL-SCHEDULE.md")) {
        if (-not (Test-Path -LiteralPath (Join-Path $ProjectFullName $Path) -PathType Leaf)) {
            Add-ErrorMessage "$Name missing $Path"
        }
    }
    $ProjectFile = Join-Path $ProjectFullName "PROJECT.md"
    $LockFile = Join-Path $ProjectFullName "GENRE-SKILL-LOCK.md"
    $StatusFile = Join-Path $ProjectFullName "scripts\SCRIPT-STATUS.md"
    $FinalScript = Join-Path $ProjectFullName "locked\FINAL-SCRIPT.md"
    if (Test-Path -LiteralPath $LockFile -PathType Leaf) {
        $LockText = Get-Content -LiteralPath $LockFile -Raw -Encoding UTF8
        if ($LockText -match "Skill .*Phase 0.*Phase 7" -and $LockText -notmatch "Skill .*[0-9]+\.[0-9]+") {
            Add-WarningMessage -Message ($Name + ": GENRE-SKILL-LOCK.md is locked but does not record Skill version.")
        }
        $IsLocked = (Test-TextContainsCodepoints -Text $LockText -Codepoints @(0x5DF2, 0x9501, 0x5B9A))
        if ($IsLocked) {
            Test-SkillLockManifest -ProjectName $Name -ProjectDir $ProjectFullName
        }
    }
    if (Test-Path -LiteralPath $FinalScript -PathType Leaf) {
        $ProjectText = if (Test-Path -LiteralPath $ProjectFile -PathType Leaf) { Get-Content -LiteralPath $ProjectFile -Raw -Encoding UTF8 } else { "" }
        $StatusText = if (Test-Path -LiteralPath $StatusFile -PathType Leaf) { Get-Content -LiteralPath $StatusFile -Raw -Encoding UTF8 } else { "" }
        if ($StatusText -notmatch "Phase 7" -and $StatusText -notmatch "FINAL-SCRIPT") {
            Add-WarningMessage -Message ($Name + ": locked/FINAL-SCRIPT.md exists but scripts/SCRIPT-STATUS.md does not mention Phase 7 or FINAL-SCRIPT.")
        }
        if ($ProjectText -notmatch "Phase 7") {
            Add-WarningMessage -Message ($Name + ": locked/FINAL-SCRIPT.md exists but PROJECT.md does not say Phase 7.")
        }
        $FinalReview = Join-Path $ProjectFullName "reviews\final-review.md"
        if (Test-Path -LiteralPath $FinalReview -PathType Leaf) {
            $FinalReviewText = Get-Content -LiteralPath $FinalReview -Raw -Encoding UTF8
            if (-not (Test-TextContainsCodepoints -Text $FinalReviewText -Codepoints @(0x8BC4, 0x5206))) {
                Add-WarningMessage -Message ($Name + ": reviews/final-review.md does not contain a scoring section.")
            }
            $HasRewriteAdvice = $FinalReviewText.Contains("rewrite guidance") -or (Test-TextContainsCodepoints -Text $FinalReviewText -Codepoints @(0x4FEE, 0x8BA2, 0x002F, 0x91CD, 0x5199, 0x5EFA, 0x8BAE))
            if (-not $HasRewriteAdvice) {
                Add-WarningMessage -Message ($Name + ": reviews/final-review.md does not contain rewrite guidance.")
            }
        } else {
            Add-ErrorMessage -Message ($Name + ": locked/FINAL-SCRIPT.md exists but reviews/final-review.md is missing.")
        }
        $Manifest = Join-Path $_.FullName "locked\LOCK-MANIFEST.sha256"
        if (-not (Test-Path -LiteralPath $Manifest -PathType Leaf)) {
            Add-WarningMessage -Message ($Name + ": locked/FINAL-SCRIPT.md exists but locked/LOCK-MANIFEST.sha256 is missing. Run scripts/update-lock-manifest.")
        } else {
            Get-Content -LiteralPath $Manifest -Encoding UTF8 | ForEach-Object {
                $Line = $_
                if ([string]::IsNullOrWhiteSpace($Line) -or $Line.StartsWith("#")) {
                    return
                }
                $Parts = $Line -split "  ", 2
                if ($Parts.Count -ne 2) {
                    Add-ErrorMessage -Message ($Name + ": malformed lock manifest line: " + $Line)
                    return
                }
                $ExpectedHash = $Parts[0]
                $RelativePath = $Parts[1]
                $ManifestFile = Join-Path $ProjectFullName $RelativePath
                if (-not (Test-Path -LiteralPath $ManifestFile -PathType Leaf)) {
                    Add-ErrorMessage -Message ($Name + ": lock manifest references missing file: " + $RelativePath)
                    return
                }
                $ActualHash = (Get-FileHash -LiteralPath $ManifestFile -Algorithm SHA256).Hash.ToLowerInvariant()
                if ($ActualHash -ne $ExpectedHash) {
                    Add-ErrorMessage -Message ($Name + ": locked file changed after manifest: " + $RelativePath)
                }
            }
        }
    }
    $ProjectPhase = ""
    if (Test-Path -LiteralPath $ProjectFile -PathType Leaf) {
        $PhaseLine = Get-Content -LiteralPath $ProjectFile -Encoding UTF8 | Where-Object { $_ -match "Phase [0-9]" } | Select-Object -First 1
        if ($PhaseLine) {
            $ProjectPhase = $PhaseLine
        }
    }
    $ScriptCount = 0
    $ScriptsDir = Join-Path $ProjectFullName "scripts"
    if (Test-Path -LiteralPath $ScriptsDir -PathType Container) {
        $ScriptCount = @(Get-ChildItem -LiteralPath $ScriptsDir -File -Filter "*.md" | Where-Object { $_.Name -ne "SCRIPT-STATUS.md" }).Count
    }
    if ($ScriptCount -gt 0) {
        $ReverseOutline = Join-Path $ProjectFullName "planning\REVERSE-OUTLINE.md"
        if (Test-Path -LiteralPath $ReverseOutline -PathType Leaf) {
            $ReverseText = Get-Content -LiteralPath $ReverseOutline -Raw -Encoding UTF8
            $IsConfirmed = $ReverseText.Contains("confirmed") -or (Test-TextContainsCodepoints -Text $ReverseText -Codepoints @(0x5DF2, 0x786E, 0x8BA4))
            if (-not $IsConfirmed) {
                $Message = $Name
                $Message += ": scripts/ contains chapter files but planning/REVERSE-OUTLINE.md is not marked confirmed."
                Add-WarningMessage -Message $Message
            }
        }
        if (-not (Test-Path -LiteralPath (Join-Path $ProjectFullName "PROJECT-MEMORY.md") -PathType Leaf)) {
            Add-ErrorMessage -Message ($Name + ": scripts/ contains chapter files but PROJECT-MEMORY.md is missing.")
        }
    }
    foreach ($PostDir in @("shotlists", "short-drama-shotlists", "seedance-prompts")) {
        $FullPostDir = Join-Path $ProjectFullName $PostDir
        if (Test-Path -LiteralPath $FullPostDir -PathType Container) {
            $OutputCount = @(Get-ChildItem -LiteralPath $FullPostDir -File | Where-Object { $_.Name -ne "README.md" }).Count
            if ($OutputCount -gt 0) {
                if ($ProjectPhase -notmatch "Phase 8") {
                    Add-WarningMessage -Message ($Name + ": " + $PostDir + "/ contains " + $OutputCount + " non-README file(s), but PROJECT.md does not say Phase 8.")
                }
                if (-not (Test-Path -LiteralPath $FinalScript -PathType Leaf)) {
                    Add-ErrorMessage -Message ($Name + ": " + $PostDir + "/ contains output but locked/FINAL-SCRIPT.md is missing.")
                }
            }
        }
    }
}
if ($ActiveCount -eq 0) {
    Add-WarningMessage "No active production projects found under projects/."
}

Write-Output "[validate-shell] Checking project state recovery..."
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RootDir "scripts\validate-project-state.ps1")
if ($LASTEXITCODE -ne 0) {
    Add-ErrorMessage "Project state recovery validation failed."
}

Write-Output "[validate-shell] Checking edu shortdrama project instances..."
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RootDir "scripts\validate-edu-shortdrama-project.ps1")
if ($LASTEXITCODE -ne 0) {
    Add-ErrorMessage "Edu shortdrama project validation failed."
}

Write-Output "[validate-shell] Checking documentation entry points..."
foreach ($Path in @("README.md", "docs/SHELL-SPEC.md", "docs/SHELL-BOUNDARY.md", "docs/KNOWLEDGE-LAYERING.md", "docs/GENRE-SKILL-CONTRACT.md", "docs/NEXT-PRODUCTION-STEPS.md", "docs/README.md")) {
    Require-File $Path
}

Write-Output "[validate-shell] Checking genre skills..."
$GenreDir = Join-Path $RootDir "genre-skills"
Get-ChildItem -LiteralPath $GenreDir -Directory | Where-Object { -not $_.Name.StartsWith("_") } | ForEach-Object {
    Require-Frontmatter ("genre-skills/{0}/SKILL.md" -f $_.Name) "genre skill $($_.Name)" $true
}

Write-Output "[validate-shell] Completed with $Errors error(s), $Warnings warning(s)."
if ($Errors -gt 0) {
    exit 1
}
exit 0
