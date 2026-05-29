[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter(Position = 0)]
    [string]$ProjectName,

    [switch]$Validate,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"

function Show-Usage {
    Write-Output "Usage: powershell -ExecutionPolicy Bypass -File scripts/project-status.ps1 <project-name> [-Validate]"
}

function New-TextFromCodepoints {
    param([int[]]$Codepoints)
    $Chars = foreach ($Codepoint in $Codepoints) {
        [char]$Codepoint
    }
    return -join $Chars
}

if ($ProjectName -eq "--validate") {
    $Validate = $true
    $ProjectName = if ($RemainingArgs -and $RemainingArgs.Count -gt 0) { $RemainingArgs[0] } else { "" }
}

if ([string]::IsNullOrWhiteSpace($ProjectName) -or $ProjectName -in @("-h", "--help", "/?")) {
    Show-Usage
    exit $(if ([string]::IsNullOrWhiteSpace($ProjectName)) { 1 } else { 0 })
}

if ($ProjectName.Contains("/") -or $ProjectName.Contains("\") -or $ProjectName.StartsWith(".")) {
    Write-Error "[project-status] Invalid project name: $ProjectName"
}

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$ProjectDir = Join-Path $RootDir "projects\$ProjectName"
$StatePath = Join-Path $ProjectDir "PROJECT-STATE.json"
$RunLog = Join-Path $ProjectDir "RUN-LOG.md"

if (-not (Test-Path -LiteralPath $ProjectDir -PathType Container)) {
    Write-Error "[project-status] Missing project: projects/$ProjectName"
}
if (-not (Test-Path -LiteralPath $StatePath -PathType Leaf)) {
    Write-Error "[project-status] Missing PROJECT-STATE.json. Run scripts/migrate-project first."
}

$State = Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8 | ConvertFrom-Json
$Next = $null

Write-Output ("[project-status] Project: " + $State.project)
Write-Output ("[project-status] Phase: " + $State.phase)
Write-Output ("[project-status] Status: " + $State.status)
Write-Output ("[project-status] Genre Skill: " + $State.genreSkill)
Write-Output ("[project-status] Locked: " + $State.locked)

if (Test-Path -LiteralPath $RunLog -PathType Leaf) {
    $NextPrefix = "- " + (New-TextFromCodepoints -Codepoints @(0x4E0B, 0x4E00, 0x6B65, 0xFF1A))
    $NextLine = Get-Content -LiteralPath $RunLog -Encoding UTF8 | Where-Object { $_.StartsWith($NextPrefix) } | Select-Object -Last 1
    if ($NextLine) {
        $Next = $NextLine.Substring($NextPrefix.Length)
        Write-Output ("[project-status] Next: " + $Next)
    }
}

if ([string]::IsNullOrWhiteSpace($Next)) {
    switch ([int]$State.phase) {
        0 { Write-Output "[project-status] Next: Fill PROJECT.md, then request Phase 1 genre Skill loading." }
        1 { Write-Output "[project-status] Next: Confirm GENRE-SKILL-LOCK.md, then request Phase 2 story planning." }
        2 { Write-Output "[project-status] Next: Confirm STORY-SPEC.md and ENDING-LOCK.md, then request Phase 3 outline." }
        3 { Write-Output "[project-status] Next: Confirm OUTLINE.md and reverse-planning files, then request Phase 4 writing." }
        4 { Write-Output "[project-status] Next: Finish requested script/chapter files, then request Phase 5 review." }
        5 { Write-Output "[project-status] Next: Choose revision scope before Phase 6." }
        6 { Write-Output "[project-status] Next: Confirm revisions or request more fixes before Phase 7 lock." }
        7 { Write-Output "[project-status] Next: Wait for explicit user confirmation before Phase 8 post-production." }
        8 { Write-Output "[project-status] Next: Continue only the selected post-production output type." }
    }
}

$FinalScript = Join-Path $ProjectDir "locked\FINAL-SCRIPT.md"
if ((Test-Path -LiteralPath $FinalScript -PathType Leaf) -and -not [bool]$State.locked) {
    Write-Output "[project-status] Warning: FINAL-SCRIPT.md exists but PROJECT-STATE.json locked is not true."
}

if ($Validate) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RootDir "scripts\validate-project-state.ps1") $ProjectName
    exit $LASTEXITCODE
} else {
    Write-Output ("[project-status] Validate: powershell -ExecutionPolicy Bypass -File scripts/project-status.ps1 " + $ProjectName + " -Validate")
}
