[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter(Position = 0)]
    [string]$ProjectName,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"

function Show-Usage {
    Write-Output "Usage: powershell -ExecutionPolicy Bypass -File scripts/new-project.ps1 <project-name>"
    Write-Output "Example: powershell -ExecutionPolicy Bypass -File scripts/new-project.ps1 huanghe-minsu-horror-002"
}

if ($ProjectName -in @("-h", "--help", "/?") -or ($RemainingArgs -and $RemainingArgs[0] -in @("-h", "--help", "/?"))) {
    Show-Usage
    exit 0
}

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    Show-Usage
    exit 1
}

if ($ProjectName -eq "_template" -or $ProjectName -like "test-*" -or $ProjectName.StartsWith(".") -or $ProjectName.Contains("/") -or $ProjectName.Contains("\")) {
    Write-Error "[new-project] Invalid project name: $ProjectName. Use a plain project directory name, not a sample/template/reserved path."
}

if ($ProjectName -notmatch '^[a-z0-9][a-z0-9._-]*$') {
    Write-Error "[new-project] Invalid project name: $ProjectName. Use lowercase letters, numbers, dots, underscores, and hyphens."
}

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$TemplateDir = Join-Path $RootDir "projects\_template"
$ProjectsDir = Join-Path $RootDir "projects"
$TargetDir = Join-Path $ProjectsDir $ProjectName

if (-not (Test-Path -LiteralPath $TemplateDir -PathType Container)) {
    Write-Error "[new-project] Missing template directory: projects/_template"
}

if (Test-Path -LiteralPath $TargetDir) {
    Write-Error "[new-project] Target already exists: projects/$ProjectName"
}

New-Item -ItemType Directory -Path $ProjectsDir -Force | Out-Null
Copy-Item -LiteralPath $TemplateDir -Destination $TargetDir -Recurse

Write-Output "[new-project] Created projects/$ProjectName from projects/_template."
Write-Output "[new-project] Next: edit PROJECT.md, then run powershell -ExecutionPolicy Bypass -File scripts/validate-shell.ps1."
