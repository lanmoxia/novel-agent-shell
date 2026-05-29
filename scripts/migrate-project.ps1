[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter(Position = 0)]
    [string]$ProjectName,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"

function Show-Usage {
    Write-Output "Usage: powershell -ExecutionPolicy Bypass -File scripts/migrate-project.ps1 <project-name>"
}

if ($ProjectName -in @("-h", "--help", "/?") -or ($RemainingArgs -and $RemainingArgs[0] -in @("-h", "--help", "/?"))) {
    Show-Usage
    exit 0
}

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    Show-Usage
    exit 1
}

if ($ProjectName -eq "_template" -or $ProjectName -like "test-*" -or $ProjectName -like "*-smoke-test") {
    Write-Error "[migrate-project] Refusing reserved/sample project: $ProjectName"
}

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$ProjectsDir = Join-Path $RootDir "projects"
$TemplateDir = Join-Path $ProjectsDir "_template"
$ProjectDir = Join-Path $ProjectsDir $ProjectName

if (-not (Test-Path -LiteralPath $ProjectDir -PathType Container)) {
    Write-Error "[migrate-project] Project not found: projects/$ProjectName"
}

foreach ($Path in @(
    "planning",
    "materials",
    "drafts",
    "drafts\rewrite-candidates",
    "revisions\snapshots"
)) {
    New-Item -ItemType Directory -Path (Join-Path $ProjectDir $Path) -Force | Out-Null
}

function Copy-IfMissing {
    param([string]$RelativePath)
    $Source = Join-Path $TemplateDir $RelativePath
    $Target = Join-Path $ProjectDir $RelativePath
    if ((-not (Test-Path -LiteralPath $Target)) -and (Test-Path -LiteralPath $Source)) {
        $TargetParent = Split-Path -Parent $Target
        New-Item -ItemType Directory -Path $TargetParent -Force | Out-Null
        Copy-Item -LiteralPath $Source -Destination $Target
        Write-Output "[migrate-project] Added $RelativePath"
    }
}

foreach ($Path in @(
    "PROJECT-MEMORY.md",
    "PROJECT-STATE.json",
    "RUN-LOG.md",
    "planning\ENDING-LOCK.md",
    "planning\REVERSE-OUTLINE.md",
    "planning\FORESHADOW-LEDGER.md",
    "planning\REVEAL-SCHEDULE.md",
    "materials\README.md",
    "drafts\README.md",
    "drafts\rewrite-candidates\README.md",
    "revisions\snapshots\README.md"
)) {
    Copy-IfMissing -RelativePath $Path
}

$SnapshotReadme = Join-Path $ProjectDir "revisions\snapshots\README.md"
$RevisionLog = Join-Path $ProjectDir "revisions\revision-log.md"
if ((Test-Path -LiteralPath $RevisionLog -PathType Leaf) -and (Test-Path -LiteralPath $SnapshotReadme -PathType Leaf)) {
    $SnapshotText = Get-Content -LiteralPath $SnapshotReadme -Raw -Encoding UTF8
    if ($SnapshotText -notmatch "historical-no-snapshot: true") {
        Add-Content -LiteralPath $SnapshotReadme -Value "`nhistorical-no-snapshot: true" -Encoding UTF8
        Write-Output "[migrate-project] Marked historical no-snapshot."
    }
}

Write-Output "[migrate-project] Completed projects/$ProjectName."
