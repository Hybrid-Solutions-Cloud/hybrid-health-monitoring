#Requires -Version 7.0
<#
.SYNOPSIS
    Validates built Management Pack XML against the official SCOM Management Pack XSD.

.DESCRIPTION
    This is the check SCOM itself runs at import time
    (Microsoft.EnterpriseManagement.Configuration.XSDVerification). Well-formed XML is NOT
    schema-valid XML: the MP schema constrains element ORDER, and 1.3.2.0 shipped with
    ModuleTypes children out of order, producing this at import:

        The element 'ModuleTypes' has invalid child element 'DataSourceModuleType'.
        List of possible elements expected: 'WriteActionModuleType'.

    Every pack imported cleanly right up until that one, because nothing in the build validated
    against the schema. `[xml]$text` only proves well-formedness and will happily accept it.

    The schema is extracted from Microsoft.EnterpriseManagement.Core.dll, which ships with VSAE,
    so this needs no management group, no SCOM SDK and no approved dependency management packs --
    it runs anywhere the authoring tools are installed.

.PARAMETER Path
    Directory containing built .xml management packs. Defaults to out/development.

.PARAMETER CoreAssemblyPath
    Microsoft.EnterpriseManagement.Core.dll. Defaults to the VSAE location.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [string]$Path,

    [Parameter()]
    [string]$CoreAssemblyPath = 'C:\Program Files (x86)\MSBuild\Microsoft\VSAC\Microsoft.EnterpriseManagement.Core.dll'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Path)) {
    $Path = Join-Path (Split-Path $PSScriptRoot -Parent) 'out/development'
}
if (-not (Test-Path -LiteralPath $Path)) { throw "Path not found: '$Path'." }
if (-not (Test-Path -LiteralPath $CoreAssemblyPath)) {
    throw "Microsoft.EnterpriseManagement.Core.dll not found at '$CoreAssemblyPath'. Install VSAE or pass -CoreAssemblyPath."
}

function Get-HcsManagementPackSchemaSet {
    param([Parameter(Mandatory)][string]$CoreAssembly)

    $work = Join-Path ([IO.Path]::GetTempPath()) ("hcs-mp-xsd-" + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Force -Path $work | Out-Null

    $assembly = [System.Reflection.Assembly]::LoadFrom($CoreAssembly)
    $reader = New-Object System.Resources.ResourceReader($assembly.GetManifestResourceStream('ManagementPackSchema.resources'))
    try {
        foreach ($entry in $reader) {
            if ($entry.Value -isnot [string]) { continue }
            $destination = Join-Path $work ([string]$entry.Key)
            $directory = Split-Path $destination -Parent
            if (-not (Test-Path -LiteralPath $directory)) { New-Item -ItemType Directory -Force -Path $directory | Out-Null }
            [IO.File]::WriteAllText($destination, [string]$entry.Value)
        }
    }
    finally { $reader.Close() }

    # Maml.xsd is extracted into maml\ but includes its siblings by bare filename, while the rest
    # land at the root. Mirror both ways so the include chain resolves; without this the schema set
    # fails to compile and every pack reports a false failure.
    $mamlDirectory = Join-Path $work 'maml'
    if (Test-Path -LiteralPath $mamlDirectory) {
        Get-ChildItem -LiteralPath $work -Filter *.xsd -File | ForEach-Object { Copy-Item $_.FullName (Join-Path $mamlDirectory $_.Name) -Force }
        Get-ChildItem -LiteralPath $mamlDirectory -Filter *.xsd -File | ForEach-Object { Copy-Item $_.FullName (Join-Path $work $_.Name) -Force }
    }

    $set = New-Object System.Xml.Schema.XmlSchemaSet
    $set.XmlResolver = New-Object System.Xml.XmlUrlResolver
    [void]$set.Add($null, (Join-Path $work 'ManagementPackSchema.v2.0.xsd'))
    $set.Compile()
    if ($set.Count -eq 0) { throw 'The Management Pack schema set failed to load; a zero-schema set would report every pack as valid.' }
    return $set
}

function Test-HcsManagementPackSchema {
    param(
        [Parameter(Mandatory)][string]$FilePath,
        [Parameter(Mandatory)][System.Xml.Schema.XmlSchemaSet]$SchemaSet
    )

    $errors = New-Object System.Collections.Generic.List[string]
    $settings = New-Object System.Xml.XmlReaderSettings
    $settings.ValidationType = [System.Xml.ValidationType]::Schema
    $settings.Schemas = $SchemaSet
    $settings.add_ValidationEventHandler({
            param($sender, $eventArgs)
            if ($eventArgs.Severity -eq [System.Xml.Schema.XmlSeverityType]::Error) { $errors.Add([string]$eventArgs.Message) }
        })

    try {
        $xmlReader = [System.Xml.XmlReader]::Create($FilePath, $settings)
        try { while ($xmlReader.Read()) { } } finally { $xmlReader.Dispose() }
    }
    catch { $errors.Add([string]$_.Exception.Message) }

    # Comma operator: returning the list bare lets PowerShell unroll an empty collection to $null,
    # and $null.Count throws under Set-StrictMode. This is the same defect class as Event 8702.
    return , $errors
}

$schemaSet = Get-HcsManagementPackSchemaSet -CoreAssembly $CoreAssemblyPath
Write-Host "Management Pack schema loaded ($($schemaSet.Count) schemas)."

$failed = 0
foreach ($file in Get-ChildItem -LiteralPath $Path -Filter *.xml -File | Sort-Object Name) {
    $errors = Test-HcsManagementPackSchema -FilePath $file.FullName -SchemaSet $schemaSet
    if ($errors.Count -gt 0) {
        $failed++
        Write-Host ("FAIL {0}" -f $file.BaseName)
        foreach ($message in $errors) { Write-Host ("       {0}" -f $message) }
    }
    else {
        Write-Host ("PASS {0}" -f $file.BaseName)
    }
}

Write-Host ''
if ($failed -gt 0) { throw "$failed management pack(s) failed SCOM XSD validation. SCOM will reject these at import." }
Write-Host 'All management packs are schema-valid.'
