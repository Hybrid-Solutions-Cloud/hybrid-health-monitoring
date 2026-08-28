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
        [xml]$script:Monitoring = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Monitoring.xml') -Raw
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
        @($script:Receipt.pendingRequiredArtifacts).Count | Should -Be 1
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

    It 'implements core host and agent-hosted per-VM monitoring' {
        @($script:Monitoring.SelectNodes('//UnitMonitor')).Count | Should -Be 22
        @($script:Monitoring.SelectNodes('//DependencyMonitor')).Count | Should -Be 14
        @($script:Monitoring.SelectNodes('//Rule')).Count | Should -Be 12
        @($script:Monitoring.SelectNodes('//Task')).Count | Should -Be 1
        @($script:Monitoring.SelectNodes('//KnowledgeArticle')).Count | Should -Be 22
        @($script:Monitoring.SelectNodes("//UnitMonitor[starts-with(@ID,'HybridSolutionsCloud.HyperVPrivateCloud.VmRuntime.')]")).Count | Should -Be 9
    }

    It 'resolves every monitoring target and rollup relationship against the Library' {
        $classIds = @($script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType') | ForEach-Object ID)
        $relationshipIds = @($script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/RelationshipTypes/RelationshipType') | ForEach-Object ID)
        foreach ($target in @($script:Monitoring.SelectNodes('//UnitMonitor|//DependencyMonitor|//Rule|//Task') | ForEach-Object Target)) {
            if ($target -like 'HCSV2Library!*') { ($target -replace '^HCSV2Library!', '') | Should -BeIn $classIds }
        }
        foreach ($relationship in @($script:Monitoring.SelectNodes('//DependencyMonitor') | ForEach-Object RelationshipType)) {
            ($relationship -replace '^HCSV2Library!', '') | Should -BeIn $relationshipIds
        }
    }

    It 'uses only parameters exposed by each referenced monitor type' {
        foreach ($monitor in $script:Monitoring.SelectNodes('//UnitMonitor')) {
            $typeId = [string]$monitor.TypeID
            $monitorType = $script:Monitoring.SelectSingleNode("//UnitMonitorType[@ID='$typeId']")
            $monitorType | Should -Not -BeNullOrEmpty
            $allowed = @($monitorType.Configuration.ChildNodes | Where-Object LocalName -eq 'element' | ForEach-Object { $_.GetAttribute('name') })
            foreach ($parameter in $monitor.Configuration.ChildNodes | Where-Object NodeType -eq Element) {
                $allowed | Should -Contain $parameter.LocalName
            }
        }
    }

    It 'ships actionable alert resources, displays, and knowledge for every unit monitor' {
        foreach ($monitor in $script:Monitoring.SelectNodes('//UnitMonitor')) {
            $script:Monitoring.SelectSingleNode("//StringResource[@ID='$($monitor.AlertSettings.AlertMessage)']") | Should -Not -BeNullOrEmpty
            $script:Monitoring.SelectSingleNode("//DisplayString[@ElementID='$($monitor.ID)']") | Should -Not -BeNullOrEmpty
            $script:Monitoring.SelectSingleNode("//KnowledgeArticle[@ElementID='$($monitor.ID)']") | Should -Not -BeNullOrEmpty
        }
    }

    It 'keeps capability monitoring out of core and uses non-throwing module probes' {
        $monitoringText = $script:Monitoring.OuterXml
        $monitoringText | Should -Not -Match 'ClusterSharedVolume|NetworkAtcIntent|PureStorage|StorageSpacesDirect|SoftwareDefinedNetwork'
        $monitoringText | Should -Not -Match 'Import-Module[^\r\n]+-ErrorAction\s+Stop'
    }

    It 'contains syntactically valid host, VM, and diagnostic monitoring scripts' {
        foreach ($scriptBody in $script:Monitoring.SelectNodes('//ScriptBody')) {
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
    }

    It 'writes UTF-8 XML without a byte-order mark' {
        $path = Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Library.xml'
        $bytes = [System.IO.File]::ReadAllBytes($path)
        @($bytes[0], $bytes[1], $bytes[2]) -join ',' | Should -Not -Be '239,187,191'
    }
}
