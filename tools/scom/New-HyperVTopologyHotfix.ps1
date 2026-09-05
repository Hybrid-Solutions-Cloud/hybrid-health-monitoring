#Requires -Version 7.0
<#
.SYNOPSIS
    Builds a temporary unsealed topology hotfix against the installed Hyper-V Library.
.DESCRIPTION
    Reuses the corrected product discovery and its class/relationship declarations. This pack
    contributes real topology while the permanent version increase is being sealed elsewhere.
    It contains no classes, monitors, rules, tasks, credentials, or customer overrides. Remove it
    only after the upgraded sealed Discovery pack has successfully rediscovered every host.
.PARAMETER LibraryVersion
    Installed sealed HyperVPrivateCloud.Library version, not the candidate release version.
.PARAMETER PublicKeyToken
    Public key token of that installed Library.
.PARAMETER OutputPath
    Destination XML file. Build outputs should remain outside committed release directories.
.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
    Version: 1.0.0
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][ValidatePattern('^\d+\.\d+\.\d+\.\d+$')][string]$LibraryVersion,
    [Parameter(Mandatory)][ValidatePattern('^[0-9a-fA-F]{16}$')][string]$PublicKeyToken,
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][string]$OutputPath
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fragmentRoot = Join-Path $repoRoot 'src/hyper-v/scom-mp/fragments/discovery'
$template = Get-Content (Join-Path $fragmentRoot 'ManagementPack.xml.template') -Raw
$template = $template.Replace('{{VERSION}}', $LibraryVersion).Replace('{{PUBLIC_KEY_TOKEN}}', $PublicKeyToken.ToLowerInvariant())
[xml]$source = $template
$scriptBody = Get-Content (Join-Path $fragmentRoot 'Discover-HyperVPrivateCloudTopology.ps1.template') -Raw
$hotfixId = 'Hcs.HyperVPrivateCloud.Topology.Hotfix'

[xml]$pack = '<ManagementPack ContentReadable="true" SchemaVersion="2.0" OriginalSchemaVersion="2.0"><Manifest><Identity><ID/><Version>1.0.0.0</Version></Identity><Name/></Manifest><Monitoring><Discoveries/></Monitoring></ManagementPack>'
$pack.SelectSingleNode('/ManagementPack/Manifest/Identity/ID').InnerText = $hotfixId
$pack.SelectSingleNode('/ManagementPack/Manifest/Name').InnerText = 'Temporary Hyper-V topology hotfix - remove after sealed upgrade'
$references = $pack.ImportNode($source.SelectSingleNode('/ManagementPack/Manifest/References'), $true)
[void]$pack.SelectSingleNode('/ManagementPack/Manifest').AppendChild($references)
$discovery = $pack.ImportNode($source.SelectSingleNode('//Discovery[@ID="HyperVPrivateCloud.Topology.Discovery"]'), $true)
$discovery.SetAttribute('ID', "$hotfixId.Discovery")
$discovery.SelectSingleNode('DataSource/ScriptBody').InnerText = $scriptBody
[void]$pack.SelectSingleNode('/ManagementPack/Monitoring/Discoveries').AppendChild($discovery)
if ($pack.OuterXml -match '\{\{[A-Z_]+\}\}') { throw 'An unresolved build token remains in the hotfix.' }

$resolvedOutput = [IO.Path]::GetFullPath($OutputPath)
[void][IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($resolvedOutput))
$settings = [Xml.XmlWriterSettings]::new()
$settings.Indent = $true
$settings.Encoding = [Text.UTF8Encoding]::new($false)
$writer = [Xml.XmlWriter]::Create($resolvedOutput, $settings)
try { $pack.Save($writer) } finally { $writer.Dispose() }
Write-Host "Built temporary topology hotfix: $resolvedOutput" -ForegroundColor Green
