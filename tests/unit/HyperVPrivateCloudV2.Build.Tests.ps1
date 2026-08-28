#Requires -Version 7.0

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Describe 'Hyper-V Private Cloud Monitoring v2 core build' {
    BeforeAll {
        $script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
        $script:V2Root = Join-Path $script:RepoRoot 'src/hyper-v/scom-mp/v2'
        $script:BuildTool = Join-Path $script:V2Root 'tools/Build-HyperVPrivateCloudManagementPacks.ps1'
        $script:Manifest = Get-Content -LiteralPath (Join-Path $script:V2Root 'build/build-manifest.json') -Raw | ConvertFrom-Json
        $script:Output = Join-Path ([System.IO.Path]::GetTempPath()) "hcs-hyperv-v2-$([guid]::NewGuid().ToString('N'))"
        & $script:BuildTool -Version '2.0.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $script:Output
        $script:Receipt = Get-Content -LiteralPath (Join-Path $script:Output 'build-receipt.json') -Raw | ConvertFrom-Json
        [xml]$script:Library = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Library.xml') -Raw
        [xml]$script:Discovery = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Discovery.xml') -Raw
    }

    AfterAll {
        if (Test-Path -LiteralPath $script:Output) {
            Remove-Item -LiteralPath $script:Output -Recurse -Force
        }
    }

    It 'uses the immutable v2 namespace and operator-facing product name' {
        $script:Manifest.namespace | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud'
        $script:Library.ManagementPack.Manifest.Name | Should -Be 'Hyper-V Private Cloud Monitoring Library'
        $script:Library.SelectSingleNode("//DisplayString[@ElementID='HybridSolutionsCloud.HyperVPrivateCloud.Service']/Name").InnerText | Should -Be 'Hyper-V Private Cloud'
    }

    It 'defines the complete required Distributed Application branch contract' {
        $required = @('ManagementComponent', 'ComputeComponent', 'VirtualMachineComponent', 'AvailabilityComponent', 'StorageComponent', 'NetworkComponent', 'MonitoringComponent')
        $classIds = @($script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType') | ForEach-Object ID)
        foreach ($leaf in $required) {
            $classIds | Should -Contain "HybridSolutionsCloud.HyperVPrivateCloud.$leaf"
            $script:Library.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.ServiceContains$leaf']") | Should -Not -BeNullOrEmpty
        }
    }

    It 'models core VM disks, adapters, switching, replication, and pipeline health' {
        $classIds = @($script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType') | ForEach-Object ID)
        foreach ($leaf in @('VirtualMachine', 'VirtualHardDisk', 'VirtualNetworkAdapter', 'VirtualSwitch', 'ReplicationRelationship', 'MonitoringPipeline')) {
            $classIds | Should -Contain "HybridSolutionsCloud.HyperVPrivateCloud.$leaf"
        }
    }

    It 'keeps optional capability objects out of the required core library' {
        $ids = @($script:Library.SelectNodes('//@ID') | ForEach-Object Value)
        ($ids -join "`n") | Should -Not -Match 'ClusterSharedVolume|NetworkAtcIntent|PureStorage|StorageSpacesDirect|SoftwareDefinedNetwork|VirtualMachineManager'
    }

    It 'generates display strings for every public class property and relationship' {
        foreach ($classType in $script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType')) {
            foreach ($property in $classType.SelectNodes('Property')) {
                $query = "//DisplayString[@ElementID='$($classType.ID)' and @SubElementID='$($property.ID)']"
                $script:Library.SelectSingleNode($query) | Should -Not -BeNullOrEmpty
            }
        }
        foreach ($relationship in $script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/RelationshipTypes/RelationshipType')) {
            $script:Library.SelectSingleNode("//DisplayString[@ElementID='$($relationship.ID)']") | Should -Not -BeNullOrEmpty
        }
    }

    It 'does not claim the incomplete authoring milestone is a complete release' {
        $script:Receipt.complete | Should -BeFalse
        @($script:Receipt.pendingRequiredArtifacts).Count | Should -Be 2
        { & $script:BuildTool -Version '2.0.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $script:Output -RequireComplete } | Should -Throw '*not complete*'
    }

    It 'builds a core Discovery MP with host seed and staged topology workflows' {
        $discoveries = @($script:Discovery.SelectNodes('/ManagementPack/Monitoring/Discoveries/Discovery'))
        $discoveries.Count | Should -Be 2
        @($discoveries.ID) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.HostRole.Seed.Discovery'
        @($discoveries.ID) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Topology.Discovery'
        $script:Discovery.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.HostRole.Seed.Discovery']//Setting/Name[contains(text(),'HostRole') and contains(text(),'/HostId')]") | Should -Not -BeNullOrEmpty
    }

    It 'resolves every Discovery class and relationship against the v2 Library' {
        $classIds = @($script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType') | ForEach-Object ID)
        $relationshipIds = @($script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/RelationshipTypes/RelationshipType') | ForEach-Object ID)
        foreach ($typeId in @($script:Discovery.SelectNodes('//DiscoveryTypes/DiscoveryClass') | ForEach-Object TypeID)) {
            ($typeId -replace '^HCSV2Library!', '') | Should -BeIn $classIds
        }
        foreach ($typeId in @($script:Discovery.SelectNodes('//DiscoveryTypes/DiscoveryRelationship') | ForEach-Object TypeID)) {
            ($typeId -replace '^HCSV2Library!', '') | Should -BeIn $relationshipIds
        }
    }

    It 'discovers VM disks, adapters, switches, Replica, pipeline, and all DA branches' {
        $declared = @($script:Discovery.SelectNodes('//DiscoveryTypes/DiscoveryClass') | ForEach-Object { $_.TypeID -replace '^HCSV2Library!', '' })
        foreach ($leaf in @('VirtualHardDisk', 'VirtualNetworkAdapter', 'VirtualSwitch', 'ReplicationRelationship', 'MonitoringPipeline', 'ManagementComponent', 'ComputeComponent', 'VirtualMachineComponent', 'AvailabilityComponent', 'StorageComponent', 'NetworkComponent', 'MonitoringComponent')) {
            $declared | Should -Contain "HybridSolutionsCloud.HyperVPrivateCloud.$leaf"
        }
    }

    It 'uses non-throwing capability probes and preserves optional capability isolation' {
        $scriptText = $script:Discovery.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Topology.Discovery']//ScriptBody").InnerText
        $scriptText | Should -Match 'function Test-HcsCapability'
        $scriptText | Should -Not -Match 'Import-Module[^\r\n]+-ErrorAction\s+Stop'
        $scriptText | Should -Not -Match 'ClusterSharedVolume|NetworkAtcIntent|PureStorage|StorageSpacesDirect|SoftwareDefinedNetwork|VirtualMachineManager\.'
    }

    It 'contains syntactically valid embedded PowerShell' {
        $scriptText = $script:Discovery.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Topology.Discovery']//ScriptBody").InnerText
        $tokens = $null
        $parseErrors = $null
        [System.Management.Automation.Language.Parser]::ParseInput($scriptText, [ref]$tokens, [ref]$parseErrors) | Out-Null
        @($parseErrors).Count | Should -Be 0
    }

    It 'writes UTF-8 XML without a byte-order mark' {
        $path = Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Library.xml'
        $bytes = [System.IO.File]::ReadAllBytes($path)
        @($bytes[0], $bytes[1], $bytes[2]) -join ',' | Should -Not -Be '239,187,191'
    }
}
