[CmdletBinding()]
param()

$ErrorActionPreference = "Continue"

$RootDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$TemplateDir = Join-Path $RootDir "projects\_template-edu-shortdrama"
$StateFile = Join-Path $TemplateDir "PROJECT-STATE.json"
$Errors = 0
$Warnings = 0

function Add-InfoMessage {
    param([string]$Message)
    Write-Output ("[validate-edu-shortdrama-template] [info] " + $Message)
}

function Add-WarningMessage {
    param([string]$Message)
    Write-Output ("[validate-edu-shortdrama-template] [warn] " + $Message)
    $script:Warnings++
}

function Add-ErrorMessage {
    param([string]$Message)
    [Console]::Error.WriteLine("[validate-edu-shortdrama-template] [error] " + $Message)
    $script:Errors++
}

function Require-Dir {
    param([string]$RelativePath)
    $Target = Join-Path $TemplateDir $RelativePath
    if (-not (Test-Path -LiteralPath $Target -PathType Container)) {
        Add-ErrorMessage -Message ("missing directory: " + $RelativePath.Replace("\", "/").TrimEnd("/") + "/")
    }
}

function Require-File {
    param([string]$RelativePath)
    $Target = Join-Path $TemplateDir $RelativePath
    if (-not (Test-Path -LiteralPath $Target -PathType Leaf)) {
        Add-ErrorMessage -Message ("missing file: " + $RelativePath.Replace("\", "/"))
    }
}

function New-TextFromCodepoints {
    param([int[]]$Codepoints)
    $Chars = foreach ($Codepoint in $Codepoints) {
        [char]$Codepoint
    }
    return -join $Chars
}

function Require-TextAny {
    param(
        [string]$RelativePath,
        [string]$Label,
        [string[]]$Needles
    )
    $Target = Join-Path $TemplateDir $RelativePath
    $DisplayPath = $RelativePath.Replace("\", "/")
    if (-not (Test-Path -LiteralPath $Target -PathType Leaf)) {
        Add-ErrorMessage -Message ($DisplayPath + " missing; cannot check " + $Label + ".")
        return
    }
    $Text = Get-Content -LiteralPath $Target -Raw -Encoding UTF8
    foreach ($Needle in $Needles) {
        if ($Text.Contains($Needle)) {
            return
        }
    }
    Add-ErrorMessage -Message ($DisplayPath + " missing required semantic keyword for " + $Label + ": " + ($Needles -join " "))
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

function Require-JsonField {
    param(
        [object]$State,
        [string]$Field
    )
    if (-not (Test-JsonField -Object $State -Path $Field)) {
        Add-ErrorMessage -Message ("PROJECT-STATE.json missing required field: " + $Field)
    }
}

function Require-JsonType {
    param(
        [object]$State,
        [string]$Field,
        [string]$Expected
    )
    $Actual = Get-JsonFieldType -Object $State -Path $Field
    if ($null -eq $Actual) {
        Add-ErrorMessage -Message ("PROJECT-STATE.json missing required field: " + $Field)
        return
    }
    if ($Actual -ne $Expected) {
        Add-ErrorMessage -Message ("PROJECT-STATE.json field " + $Field + " must be " + $Expected + ", got " + $Actual + ".")
    }
}

function Require-JsonValue {
    param(
        [object]$State,
        [string]$Field,
        [string]$Expected
    )
    if (-not (Test-JsonField -Object $State -Path $Field)) {
        Add-ErrorMessage -Message ("PROJECT-STATE.json missing required field: " + $Field)
        return
    }
    $Actual = [string](Get-JsonFieldValue -Object $State -Path $Field)
    if ($Actual -ne $Expected) {
        Add-ErrorMessage -Message ("PROJECT-STATE.json field " + $Field + " must be '" + $Expected + "', got '" + $Actual + "'.")
    }
}

if (-not (Test-Path -LiteralPath $TemplateDir -PathType Container)) {
    Add-ErrorMessage -Message "missing template directory: projects/_template-edu-shortdrama/"
} else {
    Add-InfoMessage -Message "checking projects/_template-edu-shortdrama/"
}

foreach ($Dir in @(
    "materials",
    "specs",
    "planning",
    "outlines",
    "scripts",
    "reviews",
    "revisions",
    "locked",
    "short-drama-shotlists",
    "seedance-prompts",
    "drafts"
)) {
    Require-Dir -RelativePath $Dir
}

foreach ($File in @(
    "PROJECT.md",
    "PROJECT-STATE.json",
    "GENRE-SKILL-LOCK.md",
    "PROJECT-MEMORY.md",
    "RUN-LOG.md",
    "materials/README.md",
    "specs/STORY-SPEC.md",
    "planning/ENDING-LOCK.md",
    "outlines/OUTLINE.md",
    "scripts/SCRIPT-STATUS.md",
    "reviews/README.md",
    "revisions/README.md",
    "revisions/revision-log.md",
    "locked/README.md",
    "locked/FINAL-SCRIPT.md",
    "short-drama-shotlists/README.md",
    "seedance-prompts/README.md",
    "drafts/README.md"
)) {
    Require-File -RelativePath $File
}

if (Test-Path -LiteralPath $StateFile -PathType Leaf) {
    try {
        $State = Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        Add-ErrorMessage -Message "PROJECT-STATE.json is not valid JSON."
        $State = $null
    }

    if ($null -ne $State) {
        foreach ($Field in @(
            "projectType",
            "skillId",
            "phase",
            "status",
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
            Require-JsonField -State $State -Field $Field
        }

        Require-JsonValue -State $State -Field "projectType" -Expected "edu-shortdrama"
        Require-JsonValue -State $State -Field "skillId" -Expected "wenyan-skill"
        Require-JsonType -State $State -Field "phase" -Expected "int"
        Require-JsonType -State $State -Field "status" -Expected "string"
        Require-JsonType -State $State -Field "confirmedArtifacts" -Expected "object"
        Require-JsonType -State $State -Field "lockedArtifacts" -Expected "array"
        Require-JsonType -State $State -Field "notes" -Expected "array"

        $StatusValue = [string](Get-JsonFieldValue -Object $State -Path "status")
        if ([string]::IsNullOrWhiteSpace($StatusValue)) {
            Add-ErrorMessage -Message "PROJECT-STATE.json field status must be non-empty."
        }

        foreach ($Artifact in @(
            "projectMd",
            "genreSkillLock",
            "storySpec",
            "endingLock",
            "outline",
            "originalTextAnalysis",
            "sceneMapping",
            "script",
            "subtitlePlan",
            "shotlistPlan",
            "teachingReview",
            "revisionLog",
            "finalScript",
            "productionPackage"
        )) {
            Require-JsonField -State $State -Field ("confirmedArtifacts." + $Artifact)
        }
    }
}

$OriginalText = New-TextFromCodepoints -Codepoints @(0x539F, 0x6587)
$PlainTranslation = New-TextFromCodepoints -Codepoints @(0x767D, 0x8BDD)
$TeachingObjective = New-TextFromCodepoints -Codepoints @(0x6559, 0x5B66, 0x76EE, 0x6807)
$Scene = New-TextFromCodepoints -Codepoints @(0x573A, 0x666F)
$Subtitle = New-TextFromCodepoints -Codepoints @(0x5B57, 0x5E55)
$Shotlist = New-TextFromCodepoints -Codepoints @(0x5206, 0x955C)
$FinalScript = New-TextFromCodepoints -Codepoints @(0x6700, 0x7EC8, 0x5267, 0x672C)
$ProductionPackage = New-TextFromCodepoints -Codepoints @(0x751F, 0x4EA7, 0x7A3F, 0x5305)

Require-TextAny -RelativePath "specs/STORY-SPEC.md" -Label "original text" -Needles @($OriginalText)
Require-TextAny -RelativePath "specs/STORY-SPEC.md" -Label "plain translation" -Needles @($PlainTranslation)
Require-TextAny -RelativePath "specs/STORY-SPEC.md" -Label "teaching objectives" -Needles @($TeachingObjective)
Require-TextAny -RelativePath "outlines/OUTLINE.md" -Label "scene mapping" -Needles @("Scene", $Scene)
Require-TextAny -RelativePath "outlines/OUTLINE.md" -Label "original text mapping" -Needles @($OriginalText)
Require-TextAny -RelativePath "scripts/SCRIPT-STATUS.md" -Label "subtitle plan" -Needles @($Subtitle)
Require-TextAny -RelativePath "scripts/SCRIPT-STATUS.md" -Label "shotlist plan" -Needles @($Shotlist)
Require-TextAny -RelativePath "GENRE-SKILL-LOCK.md" -Label "capability declaration" -Needles @("capabilities", "declaredCapabilities")
Require-TextAny -RelativePath "locked/FINAL-SCRIPT.md" -Label "final script or production package boundary" -Needles @($FinalScript, $ProductionPackage)

Add-InfoMessage -Message "active-project lock state, final-review, RUN-LOG runtime records, Phase 7, and lock manifest checks are intentionally out of scope for this template validator."
Write-Output ("[validate-edu-shortdrama-template] Completed with " + $Errors + " error(s), " + $Warnings + " warning(s).")

if ($Errors -gt 0) {
    exit 1
}

exit 0
