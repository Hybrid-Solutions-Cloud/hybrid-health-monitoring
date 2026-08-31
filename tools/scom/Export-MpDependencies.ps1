#Requires -Version 7.0
<#
.SYNOPSIS
    Extracts management pack dependencies from MP source and renders them into documentation.

.DESCRIPTION
    Parses the <References> block of every management pack template for a solution, classifies
    each reference by how an operator obtains it, enriches external references from the solution
    dependency contract, and writes the result into marker-delimited blocks in the documentation.

    Run with -Check in CI to fail when documentation no longer matches MP source.

.PARAMETER Solution
    Which solution to process. Defaults to every configured solution.

.PARAMETER Check
    Verify only. Writes nothing, exits 1 if any generated block is out of date.
#>
[CmdletBinding()]
param(
    [ValidateSet('hyper-v', 'azure-local')]
    [string[]]$Solution = @('hyper-v', 'azure-local'),

    [switch]$Check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

# Management packs present in a default SCOM management group. An operator never downloads these, so
# they are reported as satisfied rather than as prerequisites to obtain.
#
# Preferred source is the VSAE reference folder, which IS the set of packs that ship with SCOM — the
# authoritative answer rather than a guess. The literal list below is the fallback for machines
# without VSAE, and is the OM2022 folder's contents.
#
# This previously omitted Microsoft.Windows.Cluster.Library, which caused the prerequisites page to
# tell operators to download a pack that already ships with SCOM.
$VsaeReferenceRoot = 'C:\Program Files (x86)\System Center Visual Studio 2022 Authoring Extensions\References'

$ShipsWithScomFallback = @(
    'Microsoft.SystemCenter.DataWarehouse.Library'
    'Microsoft.SystemCenter.DataWarehouse.Report.Library'
    'Microsoft.SystemCenter.DataWarehouse.Reports'
    'Microsoft.SystemCenter.DataWarehouse.ServiceLevel.Report.Library'
    'Microsoft.SystemCenter.Image.Library'
    'Microsoft.SystemCenter.InstanceGroup.Library'
    'Microsoft.SystemCenter.Library'
    'Microsoft.SystemCenter.NTService.Library'
    'Microsoft.SystemCenter.NetworkDevice.Library'
    'Microsoft.SystemCenter.OperationsManager.Library'
    'Microsoft.SystemCenter.ProcessMonitoring.Library'
    'Microsoft.SystemCenter.ServiceDesigner.Library'
    'Microsoft.SystemCenter.SyntheticTransactions.Library'
    'Microsoft.SystemCenter.Visualization.Configuration.Library'
    'Microsoft.SystemCenter.Visualization.Library'
    'Microsoft.SystemCenter.Visualization.Network.Library'
    'Microsoft.SystemCenter.WSManagement.Library'
    'Microsoft.SystemCenter.WebApplication.Library'
    'Microsoft.SystemCenter.WorkflowFoundation.Library'
    'Microsoft.Windows.Cluster.Library'
    'Microsoft.Windows.Image.Library'
    'Microsoft.Windows.Library'
    'Microsoft.Windows.Server.Library'
    'System.AdminItem.Library'
    'System.ApplicationLog.Library'
    'System.Hardware.Library'
    'System.Health.Library'
    'System.Image.Library'
    'System.Library'
    'System.NetworkManagement.Library'
    'System.Performance.Library'
    'System.Snmp.Library'
    'System.Software.Library'
    'System.Virtualization.Library'
)

function Get-ShipsWithScomSet {
    # Union every OMxxxx folder VSAE provides, so a reference satisfied by any supported SCOM
    # version is recognised. Falls back to the literal list when VSAE is absent.
    if (-not (Test-Path -LiteralPath $VsaeReferenceRoot)) { return $ShipsWithScomFallback }

    $found = Get-ChildItem -LiteralPath $VsaeReferenceRoot -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -like 'OM*' } |
        ForEach-Object { Get-ChildItem -LiteralPath $_.FullName -Filter '*.mp' -File -ErrorAction SilentlyContinue } |
        ForEach-Object { [IO.Path]::GetFileNameWithoutExtension($_.Name) }

    if (-not $found) { return $ShipsWithScomFallback }
    return @($found | Sort-Object -Unique)
}

$ShipsWithScom = Get-ShipsWithScomSet

$MicrosoftToken = '31bf3856ad364e35'

$Solutions = @{
    'hyper-v'     = @{
        DisplayName  = 'Hyper-V Private Cloud Monitoring'
        FragmentRoot = 'src/hyper-v/scom-mp/v2/fragments'
        Contract     = 'src/hyper-v/scom-mp/contracts/dependencies.v2.json'
        DocPage      = 'docs/hyper-v/prerequisites.md'
    }
    'azure-local' = @{
        DisplayName  = 'Azure Local Monitoring'
        FragmentRoot = 'src/azure-local/scom-mp/fragments'
        Contract     = $null
        DocPage      = 'docs/azure-local/scom/prerequisites.md'
    }
}

function Get-MpManifest {
    param([string]$TemplatePath)

    $raw = Get-Content -LiteralPath $TemplatePath -Raw

    $idMatch = [regex]::Match($raw, '<Identity>\s*<ID>(?<id>[^<]+)</ID>')
    if (-not $idMatch.Success) { return $null }

    $nameMatch = [regex]::Match($raw, '<Manifest>.*?</Identity>\s*<Name>(?<name>[^<]+)</Name>', 'Singleline')

    $references = [regex]::Matches(
        $raw,
        '<Reference\s+Alias="(?<alias>[^"]+)"\s*>\s*<ID>(?<id>[^<]+)</ID>\s*<Version>(?<version>[^<]+)</Version>\s*<PublicKeyToken>(?<token>[^<]+)</PublicKeyToken>\s*</Reference>'
    ) | ForEach-Object {
        [pscustomobject]@{
            Alias   = $_.Groups['alias'].Value
            Id      = $_.Groups['id'].Value
            Version = $_.Groups['version'].Value
            Token   = $_.Groups['token'].Value
        }
    }

    [pscustomobject]@{
        Id           = $idMatch.Groups['id'].Value
        DisplayName  = if ($nameMatch.Success) { $nameMatch.Groups['name'].Value } else { $idMatch.Groups['id'].Value }
        SourcePath   = [IO.Path]::GetRelativePath($RepoRoot, $TemplatePath).Replace('\', '/')
        References   = @($references)
    }
}

function Get-CommonNamespace {
    param([string[]]$Ids)

    if ($Ids.Count -eq 0) { throw 'Cannot derive a namespace from an empty pack list.' }

    $segmentLists = @($Ids | ForEach-Object { , ($_ -split '\.') })
    $common = [System.Collections.Generic.List[string]]::new()

    for ($i = 0; $i -lt $segmentLists[0].Count; $i++) {
        $candidate = $segmentLists[0][$i]
        foreach ($segments in $segmentLists) {
            if ($i -ge $segments.Count -or $segments[$i] -ne $candidate) { $candidate = $null; break }
        }
        if ($null -eq $candidate) { break }
        $common.Add($candidate)
    }

    # Never consume the final segment; "HyperVPrivateCloud.Library" alone must still yield the
    # namespace "HyperVPrivateCloud" rather than the whole ID.
    if ($common.Count -ge $segmentLists[0].Count) { $common.RemoveAt($common.Count - 1) }
    if ($common.Count -eq 0) { throw "Could not derive a common namespace from: $($Ids -join ', ')" }

    return ($common -join '.')
}

function Get-ReferenceClass {
    param([string]$Id, [string]$Token, [string]$Namespace)

    if ($Id.StartsWith($Namespace, [StringComparison]::OrdinalIgnoreCase)) { return 'FirstParty' }
    if ($ShipsWithScom -contains $Id) { return 'ShipsWithScom' }
    if ($Token -eq $MicrosoftToken) { return 'MicrosoftDownload' }
    return 'ThirdParty'
}

# Maps an HCS capability pack to the dependency-contract capabilities that describe where its
# external references are obtained. Needed because a contract capability's managementPacks list
# names the packs in the download bundle, which is not always the same set the MP hard-references
# (Microsoft.Windows.Cluster.Library, for example, is referenced but not listed in the bundle).
$CapabilityContractMap = @{
    'Capability.Cluster'         = @('FailoverCluster', 'ClusterSharedVolume')
    'Capability.S2D'             = @('StorageSpacesDirect')
    'Capability.PureStorage'     = @('PureStorage')
    'Capability.FileServices'    = @('ScaleOutFileServer')
    'Capability.SDN'             = @('SoftwareDefinedNetworking')
    'Capability.VMM'             = @('VirtualMachineManager')
    'Capability.PhysicalNetwork' = @('PhysicalNetwork')
    'Capability.NetworkATC'      = @('NetworkATC')
}

function Get-ContractCapabilityFacts {
    param($Capability)

    $props = $Capability.PSObject.Properties.Name
    [pscustomobject]@{
        CapabilityId    = $Capability.id
        PackageVersion  = if ($props -contains 'packageVersion') { $Capability.packageVersion } else { $null }
        Download        = if ($props -contains 'download') { $Capability.download } else { $null }
        SupportedScom   = if ($props -contains 'supportedScomVersions') { $Capability.supportedScomVersions -join ', ' } else { $null }
        UnsupportedScom = if ($props -contains 'unsupportedScomVersions') { $Capability.unsupportedScomVersions -join ', ' } else { $null }
        OfficialMedia   = if ($props -contains 'officialMedia') { $Capability.officialMedia } else { $null }
    }
}

function Test-ContractNamesPack {
    param($Capability, [string]$MpId)

    if (-not ($Capability.PSObject.Properties.Name -contains 'managementPacks')) { return $false }

    foreach ($entry in $Capability.managementPacks) {
        # managementPacks entries are either a bare ID string or an object carrying id/version/token.
        $candidate = if ($entry -is [string]) { $entry } elseif ($entry.PSObject.Properties.Name -contains 'id') { $entry.id } else { $null }
        if ($candidate -eq $MpId) { return $true }
    }
    return $false
}

function Get-ContractEnrichment {
    param($Contract, [string]$MpId, [string]$OwningPackId)

    if ($null -eq $Contract) { return $null }

    # Prefer an exact match on the referenced pack ID.
    foreach ($capability in $Contract.capabilities) {
        if (Test-ContractNamesPack -Capability $capability -MpId $MpId) {
            return Get-ContractCapabilityFacts -Capability $capability
        }
    }

    # Fall back to the contract capability that owns the HCS pack making the reference.
    foreach ($suffix in $CapabilityContractMap.Keys) {
        if ($OwningPackId -notlike "*$suffix") { continue }
        foreach ($contractId in $CapabilityContractMap[$suffix]) {
            $capability = $Contract.capabilities | Where-Object { $_.id -eq $contractId } | Select-Object -First 1
            if ($null -ne $capability -and
                (($capability.PSObject.Properties.Name -contains 'download') -or
                 ($capability.PSObject.Properties.Name -contains 'officialMedia'))) {
                return Get-ContractCapabilityFacts -Capability $capability
            }
        }
    }

    return $null
}

function Get-ImportOrder {
    param($Packs, [string]$Namespace)

    $byId = @{}
    foreach ($p in $Packs) { $byId[$p.Id] = $p }

    # Depth = longest first-party dependency chain from a root pack. Ordering by depth keeps the
    # required core packs together ahead of optional capabilities, rather than emitting whatever
    # order the filesystem walk happened to satisfy first.
    $depth = @{}

    function Resolve-Depth {
        param([string]$Id, [System.Collections.Generic.HashSet[string]]$Visiting)

        if ($depth.ContainsKey($Id)) { return $depth[$Id] }
        if (-not $Visiting.Add($Id)) {
            throw "Cyclic first-party dependency detected at '$Id'."
        }

        $deps = @($byId[$Id].References |
            Where-Object {
                $_.Id.StartsWith($Namespace, [StringComparison]::OrdinalIgnoreCase) -and
                $_.Id -ne $Id -and
                $byId.ContainsKey($_.Id)
            })

        $result = 0
        foreach ($dep in $deps) {
            $candidate = (Resolve-Depth -Id $dep.Id -Visiting $Visiting) + 1
            if ($candidate -gt $result) { $result = $candidate }
        }

        $Visiting.Remove($Id) | Out-Null
        $depth[$Id] = $result
        return $result
    }

    foreach ($pack in $Packs) {
        Resolve-Depth -Id $pack.Id -Visiting ([System.Collections.Generic.HashSet[string]]::new()) | Out-Null
    }

    # Within a depth tier, list non-capability packs first so core packs read as a group.
    return @($Packs | Sort-Object `
        @{ Expression = { $depth[$_.Id] } }, `
        @{ Expression = { if ($_.Id -match '\.Capability\.') { 1 } else { 0 } } }, `
        @{ Expression = { $_.Id } })
}

function Format-ExternalTable {
    param($External)

    if ($External.Count -eq 0) {
        return @('_No external management pack prerequisites. The packs in this solution depend only on management packs present in a default SCOM installation._')
    }

    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add('| Management pack | Minimum version | Publisher token | Obtain from | Required by |')
    $lines.Add('|---|---|---|---|---|')

    foreach ($dep in $External) {
        $source = if ($dep.Download) {
            "[Download]($($dep.Download))"
        } elseif ($dep.OfficialMedia) {
            "[Official media]($($dep.OfficialMedia))"
        } elseif ($dep.Class -eq 'ThirdParty') {
            'Vendor (see notes)'
        } else {
            'Microsoft Download Center'
        }

        $requiredBy = ($dep.RequiredBy | ForEach-Object { ($_ -split '\.')[-1] }) -join ', '
        $lines.Add("| ``$($dep.Id)`` | $($dep.Version) | ``$($dep.Token)`` | $source | $requiredBy |")
    }

    return $lines
}

function Format-PerPackTable {
    param($Packs, [string]$Namespace)

    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add('| # | Management pack | External prerequisites |')
    $lines.Add('|---:|---|---|')

    $i = 0
    foreach ($pack in $Packs) {
        $i++
        $external = @($pack.References |
            Where-Object { (Get-ReferenceClass -Id $_.Id -Token $_.Token -Namespace $Namespace) -in @('MicrosoftDownload', 'ThirdParty') } |
            ForEach-Object { "``$($_.Id)`` $($_.Version)" })

        $cell = if ($external.Count -eq 0) { '_none beyond the SCOM base packs_' } else { $external -join '<br>' }
        $lines.Add("| $i | ``$($pack.Id)`` | $cell |")
    }

    return $lines
}

function Update-GeneratedBlock {
    param([string]$Content, [string]$BlockName, [string[]]$Body)

    $begin = "<!-- BEGIN GENERATED: $BlockName -->"
    $end = "<!-- END GENERATED: $BlockName -->"

    $pattern = [regex]::Escape($begin) + '.*?' + [regex]::Escape($end)
    if (-not [regex]::IsMatch($Content, $pattern, 'Singleline')) {
        throw "Documentation page is missing the generated block '$BlockName'. Expected markers:`n  $begin`n  $end"
    }

    $replacement = $begin + "`n" + ($Body -join "`n") + "`n" + $end
    return [regex]::Replace($Content, $pattern, { $replacement }, 'Singleline')
}

$exitCode = 0
$results = @{}

foreach ($name in $Solution) {
    $config = $Solutions[$name]
    $fragmentRoot = Join-Path $RepoRoot $config.FragmentRoot

    if (-not (Test-Path -LiteralPath $fragmentRoot)) {
        Write-Warning "Fragment root not found for '$name': $fragmentRoot"
        continue
    }

    $templates = Get-ChildItem -LiteralPath $fragmentRoot -Recurse -Filter 'ManagementPack.xml.template' -File
    $packs = @($templates | ForEach-Object { Get-MpManifest -TemplatePath $_.FullName } | Where-Object { $null -ne $_ })

    if ($packs.Count -eq 0) {
        Write-Warning "No management pack templates found for '$name'."
        continue
    }

    # Longest common dotted prefix across the solution's pack IDs. Derived rather than assumed a
    # fixed segment count, so it survives a namespace rename that changes the number of segments.
    $namespace = Get-CommonNamespace -Ids @($packs | ForEach-Object Id)

    $contract = $null
    if ($config.Contract) {
        $contractPath = Join-Path $RepoRoot $config.Contract
        if (Test-Path -LiteralPath $contractPath) {
            $contract = Get-Content -LiteralPath $contractPath -Raw | ConvertFrom-Json
        }
    }

    # Consolidate external references across all packs.
    $externalMap = [ordered]@{}
    foreach ($pack in $packs) {
        foreach ($ref in $pack.References) {
            $class = Get-ReferenceClass -Id $ref.Id -Token $ref.Token -Namespace $namespace
            if ($class -notin @('MicrosoftDownload', 'ThirdParty')) { continue }

            if (-not $externalMap.Contains($ref.Id)) {
                $enrichment = Get-ContractEnrichment -Contract $contract -MpId $ref.Id -OwningPackId $pack.Id
                $externalMap[$ref.Id] = [pscustomobject]@{
                    Id            = $ref.Id
                    Version       = $ref.Version
                    Token         = $ref.Token
                    Class         = $class
                    Download      = if ($enrichment) { $enrichment.Download } else { $null }
                    OfficialMedia = if ($enrichment) { $enrichment.OfficialMedia } else { $null }
                    RequiredBy    = [System.Collections.Generic.List[string]]::new()
                }
            }
            $externalMap[$ref.Id].RequiredBy.Add($pack.Id) | Out-Null

            # Keep the highest version demanded by any pack.
            $existing = $externalMap[$ref.Id]
            if ([version]$ref.Version -gt [version]$existing.Version) { $existing.Version = $ref.Version }
        }
    }

    $external = @($externalMap.Values | Sort-Object Class, Id)
    $ordered = Get-ImportOrder -Packs $packs -Namespace $namespace

    $results[$name] = [pscustomobject]@{
        Solution    = $name
        Namespace   = $namespace
        PackCount   = $packs.Count
        External    = $external
        ImportOrder = @($ordered | ForEach-Object Id)
    }

    $docPath = Join-Path $RepoRoot $config.DocPage
    if (-not (Test-Path -LiteralPath $docPath)) {
        Write-Warning "Documentation page not found, skipping render: $($config.DocPage)"
        continue
    }

    $original = Get-Content -LiteralPath $docPath -Raw
    $updated = $original
    $updated = Update-GeneratedBlock -Content $updated -BlockName 'external-dependencies' -Body (Format-ExternalTable -External $external)
    $updated = Update-GeneratedBlock -Content $updated -BlockName 'per-pack-dependencies' -Body (Format-PerPackTable -Packs $ordered -Namespace $namespace)
    $updated = Update-GeneratedBlock -Content $updated -BlockName 'import-order' -Body @(
        '```text'
        ($ordered | ForEach-Object -Begin { $n = 0 } -Process { $n++; "{0,2}. {1}" -f $n, $_.Id })
        '```'
    )

    if ($Check) {
        if ($original -ne $updated) {
            Write-Host "DRIFT: $($config.DocPage) does not match management pack source." -ForegroundColor Red
            $exitCode = 1
        } else {
            Write-Host "OK: $($config.DocPage)" -ForegroundColor Green
        }
    } else {
        if ($original -ne $updated) {
            Set-Content -LiteralPath $docPath -Value $updated -NoNewline
            Write-Host "Updated: $($config.DocPage)" -ForegroundColor Yellow
        } else {
            Write-Host "Unchanged: $($config.DocPage)" -ForegroundColor DarkGray
        }
    }
}

if (-not $Check) {
    $snapshotPath = Join-Path $RepoRoot 'tools/scom/mp-dependencies.json'
    $results.Values | Sort-Object Solution | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $snapshotPath
    Write-Host "Wrote dependency snapshot: tools/scom/mp-dependencies.json" -ForegroundColor Cyan
}

exit $exitCode
