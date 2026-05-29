[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter(Position = 0)]
    [string]$ProposalName
)

$ErrorActionPreference = "Stop"

function Show-Usage {
    Write-Output "Usage: powershell -ExecutionPolicy Bypass -File scripts/new-proposal.ps1 <proposal-name>"
    Write-Output "Example: powershell -ExecutionPolicy Bypass -File scripts/new-proposal.ps1 20260518-120000-proposal.md"
}

if ($ProposalName -in @("-h", "--help", "/?")) {
    Show-Usage
    exit 0
}

if ([string]::IsNullOrWhiteSpace($ProposalName)) {
    Show-Usage
    exit 1
}

if ($ProposalName.StartsWith(".") -or $ProposalName.Contains("/") -or $ProposalName.Contains("\")) {
    Write-Error "[new-proposal] Invalid proposal name: $ProposalName"
}

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$ProposalsDir = Join-Path $RootDir "workflow\feedback\proposals"
$Template = Join-Path $ProposalsDir "TEMPLATE.md"
$Target = Join-Path $ProposalsDir $ProposalName

if (-not (Test-Path -LiteralPath $Template -PathType Leaf)) {
    Write-Error "[new-proposal] Missing workflow/feedback/proposals/TEMPLATE.md"
}

New-Item -ItemType Directory -Path $ProposalsDir -Force | Out-Null

if (Test-Path -LiteralPath $Target) {
    Write-Error "[new-proposal] Target already exists: workflow/feedback/proposals/$ProposalName"
}

Copy-Item -LiteralPath $Template -Destination $Target
Write-Output "[new-proposal] Created workflow/feedback/proposals/$ProposalName from TEMPLATE.md."
