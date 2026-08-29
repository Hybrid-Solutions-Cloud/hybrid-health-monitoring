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
        [xml]$script:Presentation = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Presentation.xml') -Raw
        [xml]$script:ClusterCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Cluster.xml') -Raw
        [xml]$script:StorageCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.xml') -Raw
        [xml]$script:S2DCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.xml') -Raw
        [xml]$script:PureCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.xml') -Raw
        [xml]$script:FileServicesCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.xml') -Raw
        [xml]$script:PhysicalNetworkCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PhysicalNetwork.xml') -Raw
        [xml]$script:NetworkAtcCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC.xml') -Raw
        [xml]$script:SdnCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.xml') -Raw
        [xml]$script:VmmCapability = Get-Content -LiteralPath (Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM.xml') -Raw
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

    It 'builds all four required core artifacts plus authored optional capabilities without claiming they are sealed' {
        $script:Receipt.complete | Should -BeTrue
        @($script:Receipt.pendingRequiredArtifacts).Count | Should -Be 0
        @($script:Receipt.artifacts).Count | Should -Be 13
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Cluster'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PhysicalNetwork'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN'
        @($script:Receipt.artifacts.id) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM'
        @($script:Receipt.artifacts | Where-Object sealed).Count | Should -Be 0
        { & $script:BuildTool -Version '2.0.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $script:Output -RequireComplete } | Should -Not -Throw
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

    It 'uses the operator-facing console name and complete core folder hierarchy' {
        $script:Presentation.ManagementPack.Manifest.Name | Should -Be 'Hyper-V Private Cloud Monitoring Presentation'
        $script:Presentation.SelectSingleNode("//DisplayString[@ElementID='HybridSolutionsCloud.HyperVPrivateCloud.Root.Folder']/Name").InnerText | Should -Be 'Hyper-V Private Cloud'
        $folderNames = @($script:Presentation.SelectNodes('//Presentation/Folders/Folder') | ForEach-Object ID)
        foreach ($leaf in @('Overview', 'Compute', 'VirtualMachines', 'Availability', 'Storage', 'Networking', 'MonitoringPipeline', 'Operations')) {
            $folderNames | Should -Contain "HybridSolutionsCloud.HyperVPrivateCloud.$leaf.Folder"
        }
    }

    It 'provides an actual Distributed Application diagram targeted at the private-cloud service' {
        $diagram = $script:Presentation.SelectSingleNode("//View[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Service.Diagram.View']")
        $diagram | Should -Not -BeNullOrEmpty
        $diagram.TypeID | Should -Be 'SC!Microsoft.SystemCenter.DiagramViewType'
        $diagram.Target | Should -Be 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.Service'
        $diagram.SelectSingleNode('Presentation/DiagramViewCriteria/DiagramViewDisplay') | Should -Not -BeNullOrEmpty
    }

    It 'resolves every core Presentation target, folder item, and local parent folder' {
        $classIds = @($script:Library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType') | ForEach-Object ID)
        $viewIds = @($script:Presentation.SelectNodes('//Presentation/Views/View') | ForEach-Object ID)
        $folderIds = @($script:Presentation.SelectNodes('//Presentation/Folders/Folder') | ForEach-Object ID)
        foreach ($target in @($script:Presentation.SelectNodes('//Presentation/Views/View') | ForEach-Object Target)) {
            ($target -replace '^HCSV2Library!', '') | Should -BeIn $classIds
        }
        foreach ($item in $script:Presentation.SelectNodes('//Presentation/FolderItems/FolderItem')) {
            [string]$item.ElementID | Should -BeIn $viewIds
            [string]$item.Folder | Should -BeIn $folderIds
        }
        foreach ($folder in $script:Presentation.SelectNodes('//Presentation/Folders/Folder')) {
            if ([string]$folder.ParentFolder -notlike 'SC!*') { [string]$folder.ParentFolder | Should -BeIn $folderIds }
        }
    }

    It 'places every view in a folder and localizes every folder and view' {
        $viewIds = @($script:Presentation.SelectNodes('//Presentation/Views/View') | ForEach-Object ID)
        $itemViewIds = @($script:Presentation.SelectNodes('//Presentation/FolderItems/FolderItem') | ForEach-Object ElementID)
        foreach ($viewId in $viewIds) {
            $itemViewIds | Should -Contain $viewId
            $script:Presentation.SelectSingleNode("//DisplayString[@ElementID='$viewId']") | Should -Not -BeNullOrEmpty
        }
        foreach ($folder in $script:Presentation.SelectNodes('//Presentation/Folders/Folder')) {
            $script:Presentation.SelectSingleNode("//DisplayString[@ElementID='$($folder.ID)']") | Should -Not -BeNullOrEmpty
        }
    }

    It 'provides health or inventory state views for every core resource family' {
        $stateTargets = @($script:Presentation.SelectNodes("//View[@TypeID='SC!Microsoft.SystemCenter.StateViewType']") | ForEach-Object { $_.Target -replace '^HCSV2Library!', '' })
        foreach ($classId in @(
            'HybridSolutionsCloud.HyperVPrivateCloud.Service',
            'HybridSolutionsCloud.HyperVPrivateCloud.ComponentGroup',
            'HybridSolutionsCloud.HyperVPrivateCloud.HostRole',
            'HybridSolutionsCloud.HyperVPrivateCloud.VirtualMachine',
            'HybridSolutionsCloud.HyperVPrivateCloud.VirtualMachineRuntime',
            'HybridSolutionsCloud.HyperVPrivateCloud.VirtualHardDisk',
            'HybridSolutionsCloud.HyperVPrivateCloud.VirtualNetworkAdapter',
            'HybridSolutionsCloud.HyperVPrivateCloud.VirtualSwitch',
            'HybridSolutionsCloud.HyperVPrivateCloud.ReplicationRelationship',
            'HybridSolutionsCloud.HyperVPrivateCloud.MonitoringPipeline'
        )) {
            $stateTargets | Should -Contain $classId
        }
    }

    It 'keeps optional capability views out of the required core Presentation MP' {
        $script:Presentation.OuterXml | Should -Not -Match 'ClusterSharedVolume|NetworkAtcIntent|PureStorage|StorageSpacesDirect|SoftwareDefinedNetwork|VirtualMachineManager'
    }

    It 'pins the optional Cluster capability to the inspected Microsoft Cluster and CSV contracts' {
        $references = @{}
        foreach ($reference in $script:ClusterCapability.SelectNodes('/ManagementPack/Manifest/References/Reference')) { $references[[string]$reference.Alias] = $reference }
        $references.Cluster.ID | Should -Be 'Microsoft.Windows.Cluster.Library'
        $references.ClusterManagement.ID | Should -Be 'Microsoft.Windows.Cluster.Management.Library'
        $references.ClusterManagement.Version | Should -Be '10.1.0.0'
        $references.CSV.ID | Should -Be 'Microsoft.Windows.Server.ClusterSharedVolumeMonitoring'
        $references.CSV.Version | Should -Be '10.1.2.2'
        $references.HCSV2Presentation.ID | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud.Presentation'
    }

    It 'relates authoritative Microsoft cluster objects without defining duplicate cluster classes' {
        @($script:ClusterCapability.SelectNodes('//ClassType')).Count | Should -Be 0
        $relationships = @($script:ClusterCapability.SelectNodes('//RelationshipType'))
        $relationships.Count | Should -Be 6
        @($relationships.Target.Type) | Should -Contain 'Cluster!Microsoft.Windows.Cluster'
        @($relationships.Target.Type) | Should -Contain 'ClusterManagement!Microsoft.Windows.Cluster.Node'
        @($relationships.Target.Type) | Should -Contain 'ClusterManagement!Microsoft.Windows.Cluster.Group'
        @($relationships.Target.Type) | Should -Contain 'ClusterManagement!Microsoft.Windows.Cluster.Network'
        @($relationships.Target.Type) | Should -Contain 'CSV!Microsoft.Windows.Server.ClusterSharedVolumeMonitoring.ClusterSharedVolume'
        @($script:ClusterCapability.SelectNodes('//DiscoveryClass')).Count | Should -Be 0
        @($script:ClusterCapability.SelectNodes('//DiscoveryRelationship')).Count | Should -Be 6
    }

    It 'uses Microsoft leaf health and adds only HCS integration-pipeline monitoring and rollups' {
        @($script:ClusterCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 1
        @($script:ClusterCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 5
        @($script:ClusterCapability.SelectNodes('//Rule')).Count | Should -Be 0
        $script:ClusterCapability.SelectSingleNode("//UnitMonitor[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.Cluster.IntegrationHealth.Monitor']") | Should -Not -BeNullOrEmpty
        foreach ($rollup in $script:ClusterCapability.SelectNodes('//DependencyMonitor')) {
            [string]$rollup.MemberMonitor | Should -Be 'Health!System.Health.AvailabilityState'
            [string]$rollup.MemberUnAvailable | Should -Be 'Success'
            $rollup.SelectSingleNode('AlertSettings') | Should -BeNullOrEmpty
        }
    }

    It 'ships cluster, node, role, network, CSV, performance, and alert operator views beneath core folders' {
        @($script:ClusterCapability.SelectNodes('//View')).Count | Should -Be 7
        $targets = @($script:ClusterCapability.SelectNodes('//View') | ForEach-Object Target)
        $targets | Should -Contain 'Cluster!Microsoft.Windows.Cluster'
        $targets | Should -Contain 'ClusterManagement!Microsoft.Windows.Cluster.Node'
        $targets | Should -Contain 'ClusterManagement!Microsoft.Windows.Cluster.Group'
        $targets | Should -Contain 'ClusterManagement!Microsoft.Windows.Cluster.Network'
        $targets | Should -Contain 'CSV!Microsoft.Windows.Server.ClusterSharedVolumeMonitoring.ClusterSharedVolume'
        foreach ($item in $script:ClusterCapability.SelectNodes('//FolderItem')) { [string]$item.Folder | Should -BeLike 'HCSV2Presentation!*' }
    }

    It 'uses non-throwing cluster capability probes and syntactically valid embedded PowerShell' {
        foreach ($scriptBody in $script:ClusterCapability.SelectNodes('//ScriptBody')) {
            $scriptBody.InnerText | Should -Match 'function Test-HcsCapability'
            $scriptBody.InnerText | Should -Not -Match 'Import-Module[^\r\n]+-ErrorAction\s+Stop'
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
    }

    It 'defines Windows-owned SAN projection classes without duplicating vendor or S2D objects' {
        $classes = @($script:StorageCapability.SelectNodes('//ClassType'))
        $classes.Count | Should -Be 5
        @($classes.ID) | Should -Be @(
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.LogicalUnit',
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment',
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.IscsiSession',
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.FibreChannelPort',
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.VirtualDiskMapping'
        )
        $script:StorageCapability.OuterXml | Should -Not -Match 'PureStorageFlashArray|StorageSpacesDirect|Microsoft\.Windows\.Server\.Storage'
    }

    It 'discovers complete LUN, attachment, transport, and VHDX correlation topology' {
        @($script:StorageCapability.SelectNodes('//RelationshipType')).Count | Should -Be 13
        @($script:StorageCapability.SelectNodes('//DiscoveryClass')).Count | Should -Be 5
        @($script:StorageCapability.SelectNodes('//DiscoveryRelationship')).Count | Should -Be 13
        foreach ($id in @('VirtualDiskMappingReferencesVirtualHardDisk', 'VirtualDiskMappingReferencesLogicalUnit', 'VirtualHardDiskUsesLogicalUnit')) {
            $script:StorageCapability.SelectSingleNode("//RelationshipType[contains(@ID,'$id')]") | Should -Not -BeNullOrEmpty
        }
    }

    It 'monitors SAN integration, attachment availability, MPIO, iSCSI, and Fibre Channel health' {
        @($script:StorageCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 5
        @($script:StorageCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 3
        @($script:StorageCapability.SelectNodes('//Rule')).Count | Should -Be 0
        foreach ($rollup in $script:StorageCapability.SelectNodes('//DependencyMonitor')) {
            [string]$rollup.MemberUnAvailable | Should -Be 'Success'
            [string]$rollup.MemberMonitor | Should -Be 'Health!System.Health.AvailabilityState'
        }
    }

    It 'resolves every Storage workflow target and configuration parameter' {
        $localClassIds = @($script:StorageCapability.SelectNodes('//ClassType') | ForEach-Object ID)
        $libraryClassIds = @($script:Library.SelectNodes('//ClassType') | ForEach-Object ID)
        foreach ($workflow in $script:StorageCapability.SelectNodes('//UnitMonitor|//DependencyMonitor')) {
            $target = [string]$workflow.Target
            if ($target -like 'HCSV2Library!*') { ($target -replace '^HCSV2Library!', '') | Should -BeIn $libraryClassIds }
            else { $target | Should -BeIn $localClassIds }
        }
        foreach ($monitor in $script:StorageCapability.SelectNodes('//UnitMonitor')) {
            $type = $script:StorageCapability.SelectSingleNode("//UnitMonitorType[@ID='$($monitor.TypeID)']")
            $type | Should -Not -BeNullOrEmpty
            $allowed = @($type.Configuration.ChildNodes | Where-Object LocalName -eq 'element' | ForEach-Object { $_.GetAttribute('name') })
            foreach ($parameter in $monitor.Configuration.ChildNodes | Where-Object NodeType -eq Element) { $allowed | Should -Contain $parameter.LocalName }
        }
    }

    It 'ships SAN inventory and alert views beneath the core Presentation folders' {
        @($script:StorageCapability.SelectNodes('//View')).Count | Should -Be 6
        foreach ($item in $script:StorageCapability.SelectNodes('//FolderItem')) { [string]$item.Folder | Should -BeLike 'HCSV2Presentation!*' }
        foreach ($target in @($script:StorageCapability.SelectNodes("//View[@TypeID='SC!Microsoft.SystemCenter.StateViewType']") | ForEach-Object Target)) {
            $target | Should -BeLike 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.*'
        }
    }

    It 'uses stable hashed LUN keys, non-throwing capability probes, and valid embedded PowerShell' {
        $discoveryScript = $script:StorageCapability.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.Topology.Discovery']//ScriptBody").InnerText
        $discoveryScript | Should -Match "\$storageId = 'lun:' \+ \(Get-HcsStableId"
        foreach ($scriptBody in $script:StorageCapability.SelectNodes('//ScriptBody')) {
            $scriptBody.InnerText | Should -Match 'function Test-HcsCapability'
            $scriptBody.InnerText | Should -Not -Match 'Import-Module[^\r\n]+-ErrorAction\s+Stop'
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
    }

    It 'provides alert resources, display strings, and knowledge for every Storage unit monitor' {
        foreach ($monitor in $script:StorageCapability.SelectNodes('//UnitMonitor')) {
            $script:StorageCapability.SelectSingleNode("//StringResource[@ID='$($monitor.AlertSettings.AlertMessage)']") | Should -Not -BeNullOrEmpty
            $script:StorageCapability.SelectSingleNode("//DisplayString[@ElementID='$($monitor.ID)']") | Should -Not -BeNullOrEmpty
            $script:StorageCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='$($monitor.ID)']") | Should -Not -BeNullOrEmpty
        }
    }

    It 'pins the S2D adapter to the inspected Microsoft 1.0.47.4 package contract' {
        $references = @{}
        foreach ($reference in $script:S2DCapability.SelectNodes('/ManagementPack/Manifest/References/Reference')) { $references[[string]$reference.Alias] = $reference }
        $references.StorageLibrary.ID | Should -Be 'Microsoft.Storage.Library'
        $references.S2D.ID | Should -Be 'Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect'
        $references.S2D.Version | Should -Be '1.0.0.0'
        $references.HCSV2Presentation.ID | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud.Presentation'
    }

    It 'reuses all seven authoritative Microsoft S2D resource families without defining duplicates' {
        @($script:S2DCapability.SelectNodes('//ClassType')).Count | Should -Be 0
        $relationships = @($script:S2DCapability.SelectNodes('//RelationshipType'))
        $relationships.Count | Should -Be 7
        foreach ($leaf in @('StorageSubSystem', 'StorageNode', 'PhysicalDisk', 'StoragePool', 'VirtualDisk', 'Volume', 'FileShare')) {
            @($relationships.Target.Type) | Should -Contain "S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.$leaf"
        }
    }

    It 'discovers each S2D family into the private-cloud Storage branch with host-chain keys' {
        @($script:S2DCapability.SelectNodes('//Discovery')).Count | Should -Be 7
        @($script:S2DCapability.SelectNodes('//DiscoveryRelationship')).Count | Should -Be 7
        foreach ($discovery in $script:S2DCapability.SelectNodes('//Discovery')) {
            [string]$discovery.Target | Should -BeLike 'S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.*'
            $discovery.SelectSingleNode('.//Parameter[Name="ComputerName"]/Value').InnerText | Should -Match 'Microsoft.Windows.Computer'
            $discovery.SelectSingleNode('.//Parameter[Name="UniqueId"]/Value').InnerText | Should -Match 'UniqueID'
        }
        $script:S2DCapability.SelectSingleNode("//Discovery[contains(@ID,'Volume.Relationship')]//Parameter[Name='ParentDiskUniqueId']/Value").InnerText | Should -Match 'Windows.Disk'
        $script:S2DCapability.SelectSingleNode("//Discovery[contains(@ID,'FileShare.Relationship')]//Parameter[Name='ParentVolumeUniqueId']/Value").InnerText | Should -Match 'Windows.Volume'
    }

    It 'adds only HCS integration coverage and authoritative Microsoft S2D health rollups' {
        @($script:S2DCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 1
        @($script:S2DCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 7
        @($script:S2DCapability.SelectNodes('//Rule')).Count | Should -Be 0
        foreach ($rollup in $script:S2DCapability.SelectNodes('//DependencyMonitor')) {
            [string]$rollup.MemberMonitor | Should -Be 'Health!System.Health.AvailabilityState'
            [string]$rollup.MemberUnAvailable | Should -Be 'Success'
            $rollup.SelectSingleNode('AlertSettings') | Should -BeNullOrEmpty
        }
    }

    It 'provides S2D component, fault, job, alert, and performance views beneath Storage' {
        @($script:S2DCapability.SelectNodes('//View')).Count | Should -Be 11
        foreach ($leaf in @('StorageSubSystem', 'StorageNode', 'PhysicalDisk', 'StoragePool', 'VirtualDisk', 'Volume', 'FileShare')) {
            $script:S2DCapability.SelectSingleNode("//View[@Target='S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.$leaf']") | Should -Not -BeNullOrEmpty
        }
        foreach ($item in $script:S2DCapability.SelectNodes('//FolderItem')) { [string]$item.Folder | Should -Be 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder' }
    }

    It 'uses literal SCOM element expressions, non-throwing probes, and valid S2D PowerShell' {
        foreach ($scriptBody in $script:S2DCapability.SelectNodes('//ScriptBody')) {
            $scriptBody.InnerText | Should -Not -Match "MPElement\[Name='S2D!\$"
            $scriptBody.InnerText | Should -Not -Match 'Import-Module[^\r\n]+-ErrorAction\s+Stop'
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
    }

    It 'pins Pure integration to the vendor-supported 2.0.120.0 identity and Storage Core' {
        $references = @{}
        foreach ($reference in $script:PureCapability.SelectNodes('/ManagementPack/Manifest/References/Reference')) { $references[[string]$reference.Alias] = $reference }
        $references.Pure.ID | Should -Be 'PureStorageFlashArray'
        $references.Pure.Version | Should -Be '2.0.120.0'
        $references.Pure.PublicKeyToken | Should -Be 'a9d994eedb5e7179'
        $references.HCSV2Storage.ID | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage'
        @($script:PureCapability.SelectNodes('//ClassType')).Count | Should -Be 0
    }

    It 'maps Pure arrays and ports into Storage and correlates hosts and volumes by exact identities' {
        $relationships = @($script:PureCapability.SelectNodes('//RelationshipType'))
        $relationships.Count | Should -Be 4
        @($relationships.ID) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.StorageContainsPureArray'
        @($relationships.ID) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.StorageContainsPurePort'
        @($relationships.ID) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.HostRoleReferencesPureHost'
        @($relationships.ID) | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.LogicalUnitReferencesPureVolume'
        $script:PureCapability.SelectSingleNode("//DiscoveryRelationship[@TypeID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.LogicalUnitReferencesPureVolume']") | Should -Not -BeNullOrEmpty
    }

    It 'uses no Pure credential or REST control path and preserves vendor leaf-alert authority' {
        @($script:PureCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 1
        @($script:PureCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 4
        @($script:PureCapability.SelectNodes('//Rule')).Count | Should -Be 0
        $script:PureCapability.OuterXml | Should -Not -Match 'FlashArrayAdminAccount|RunAs|Invoke-RestMethod|New-Pfa|Set-Pfa|Remove-Pfa'
        foreach ($rollup in $script:PureCapability.SelectNodes('//DependencyMonitor')) {
            [string]$rollup.MemberMonitor | Should -Be 'Health!System.Health.AvailabilityState'
            [string]$rollup.MemberUnAvailable | Should -Be 'Success'
            $rollup.SelectSingleNode('AlertSettings') | Should -BeNullOrEmpty
        }
    }

    It 'normalizes IQN, WWPN, and serial identifiers and refuses guessed correlations' {
        $scriptText = $script:PureCapability.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.Correlation.Discovery']//ScriptBody").InnerText
        $scriptText | Should -Match 'ConvertTo-HcsIdentifierSet'
        $scriptText | Should -Match 'ConvertTo-HcsSerial'
        $scriptText | Should -Match '\$principals\.Count -ne 1'
        $scriptText | Should -Match '\$lunBySerial\[\$serial\]\.Count -ne 1'
        $scriptText | Should -Not -Match 'Endpoint|FlashArrayAdminAccount|Invoke-RestMethod'
    }

    It 'provides Pure topology, ActiveCluster, alert, and performance views beneath Storage' {
        @($script:PureCapability.SelectNodes('//View')).Count | Should -Be 11
        foreach ($target in @('Pod', 'PodReplica', 'PureArray', 'PureController', 'PureHost', 'PureHostgroup', 'PurePort', 'PureVolume')) {
            $script:PureCapability.SelectSingleNode("//View[@Target='Pure!PureStorage.FlashArray.$target']") | Should -Not -BeNullOrEmpty
        }
        foreach ($item in $script:PureCapability.SelectNodes('//FolderItem')) { [string]$item.Folder | Should -Be 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder' }
    }

    It 'contains syntactically valid Pure correlation scripts and actionable monitor knowledge' {
        foreach ($scriptBody in $script:PureCapability.SelectNodes('//ScriptBody')) {
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
        $monitor = $script:PureCapability.SelectSingleNode("//UnitMonitor[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor']")
        $script:PureCapability.SelectSingleNode("//StringResource[@ID='$($monitor.AlertSettings.AlertMessage)']") | Should -Not -BeNullOrEmpty
        $script:PureCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='$($monitor.ID)']") | Should -Not -BeNullOrEmpty
    }

    It 'emits no unresolved build token in any authored artifact' {
        foreach ($artifact in $script:Receipt.artifacts) {
            Get-Content -LiteralPath (Join-Path $script:Output $artifact.output) -Raw | Should -Not -Match '\{\{[A-Z0-9_]+\}\}'
        }
    }

    It 'pins File Services to the inspected Microsoft 10.1.0.4 SMB contract' {
        $references = @{}
        foreach ($reference in $script:FileServicesCapability.SelectNodes('/ManagementPack/Manifest/References/Reference')) { $references[[string]$reference.Alias] = $reference }
        $references.FileSMB.ID | Should -Be 'Microsoft.Windows.FileServices.SMB.2016'
        $references.FileSMB.Version | Should -Be '10.1.0.4'
        $references.FileServices.ID | Should -Be 'Microsoft.Windows.FileServices'
        $references.Keys | Should -Not -Contain 'FileServices2016'
    }

    It 'models complete Hyper-V over SMB share, path, and VHDX mapping topology' {
        @($script:FileServicesCapability.SelectNodes('//ClassType')).Count | Should -Be 3
        foreach ($classId in @('SmbShare', 'SmbClientPath', 'SmbVhdxMapping')) {
            $script:FileServicesCapability.SelectSingleNode("//ClassType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.$classId']") | Should -Not -BeNullOrEmpty
        }
        @($script:FileServicesCapability.SelectNodes('//RelationshipType')).Count | Should -Be 7
        $script:FileServicesCapability.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbShareReferencesMicrosoftSmbService']") | Should -Not -BeNullOrEmpty
        $script:FileServicesCapability.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbVhdxMappingReferencesVirtualMachine']") | Should -Not -BeNullOrEmpty
    }

    It 'discovers only UNC-backed VM disks with stable hashed identities and exact Microsoft service correlation' {
        $scriptText = $script:FileServicesCapability.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.Discovery']//ScriptBody").InnerText
        $scriptText | Should -Match 'Get-VMHardDiskDrive'
        $scriptText | Should -Match 'Get-SmbMultichannelConnection'
        $scriptText | Should -Match 'Get-HcsStableId'
        $scriptText | Should -Match 'System\.Net\.Dns.*GetHostEntry'
        $scriptText | Should -Match 'FileSMB!Microsoft\.Windows\.FileServices\.Service\.SMB\.10\.0'
        $scriptText | Should -Not -Match 'New-Smb|Set-Smb|Remove-Smb|Invoke-RestMethod'
    }

    It 'monitors required SMB connections, continuous availability, and optional RDMA without duplicate Microsoft alerts' {
        @($script:FileServicesCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 1
        @($script:FileServicesCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 3
        @($script:FileServicesCapability.SelectNodes('//Rule')).Count | Should -Be 0
        $monitor = $script:FileServicesCapability.SelectSingleNode("//UnitMonitor[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.Health.Monitor']")
        $monitor.Configuration.RequireRdma | Should -Be 'false'
        $script:FileServicesCapability.OuterXml | Should -Match 'ContinuouslyAvailable'
        $script:FileServicesCapability.OuterXml | Should -Match 'ClientRdmaCapable'
    }

    It 'provides SMB, SOFS, Microsoft service, alert, and performance views under Storage' {
        @($script:FileServicesCapability.SelectNodes('//View')).Count | Should -Be 7
        foreach ($item in $script:FileServicesCapability.SelectNodes('//FolderItem')) { [string]$item.Folder | Should -Be 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder' }
    }

    It 'contains syntactically valid File Services scripts and monitor knowledge' {
        foreach ($scriptBody in $script:FileServicesCapability.SelectNodes('//ScriptBody')) {
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
        $script:FileServicesCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.Health.Monitor']") | Should -Not -BeNullOrEmpty
    }

    It 'uses the SCOM 2016 physical-network contract floor and does not duplicate network-device classes' {
        $networkReference = $script:PhysicalNetworkCapability.SelectSingleNode("/ManagementPack/Manifest/References/Reference[@Alias='Network']")
        $networkReference.ID | Should -Be 'System.NetworkManagement.Library'
        $networkReference.Version | Should -Be '7.2.11719.0'
        @($script:PhysicalNetworkCapability.SelectNodes('//ClassType')).Count | Should -Be 0
        @($script:PhysicalNetworkCapability.SelectNodes('//Rule')).Count | Should -Be 0
    }

    It 'relates external virtual switches to exact Windows computer network adapters for built-in MAC correlation' {
        @($script:PhysicalNetworkCapability.SelectNodes('//RelationshipType')).Count | Should -Be 2
        $script:PhysicalNetworkCapability.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.PhysicalNetwork.NetworkComponentContainsComputerNetworkAdapter']") | Should -Not -BeNullOrEmpty
        $script:PhysicalNetworkCapability.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.PhysicalNetwork.VirtualSwitchUsesComputerNetworkAdapter']") | Should -Not -BeNullOrEmpty
        $scriptText = $script:PhysicalNetworkCapability.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.PhysicalNetwork.Relationship.Discovery']//ScriptBody").InnerText
        $scriptText | Should -Match 'Get-NetAdapter -Physical'
        $scriptText | Should -Match 'Microsoft\.Windows\.ComputerNetworkAdapter'
        $scriptText | Should -Match 'System\.Device\.NetworkAdapter.*MACAddress'
        $scriptText | Should -Not -Match "MacAddress\) -replace|MacAddress\).*ToUpperInvariant"
        $scriptText | Should -Not -Match 'Invoke-RestMethod|Get-Credential|CommunityString|Import-Module\s+.*SNMP'
    }

    It 'monitors physical-network correlation inputs and reuses Microsoft health and presentation' {
        @($script:PhysicalNetworkCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 1
        @($script:PhysicalNetworkCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 2
        @($script:PhysicalNetworkCapability.SelectNodes('//View')).Count | Should -Be 8
        $script:PhysicalNetworkCapability.OuterXml | Should -Match 'System\.NetworkManagement\.Node'
        $script:PhysicalNetworkCapability.OuterXml | Should -Match 'System\.NetworkManagement\.Switch'
        $script:PhysicalNetworkCapability.OuterXml | Should -Match 'System\.NetworkManagement\.Port'
        $script:PhysicalNetworkCapability.OuterXml | Should -Match 'System\.NetworkManagement\.VLAN'
        foreach ($item in $script:PhysicalNetworkCapability.SelectNodes('//FolderItem')) { [string]$item.Folder | Should -Be 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Networking.Folder' }
    }

    It 'contains syntactically valid Physical Network scripts and monitor knowledge' {
        foreach ($scriptBody in $script:PhysicalNetworkCapability.SelectNodes('//ScriptBody')) {
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
        $script:PhysicalNetworkCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.PhysicalNetwork.IntegrationHealth.Monitor']") | Should -Not -BeNullOrEmpty
    }

    It 'models Network ATC intents, per-host status, global settings, and exact adapter relationships' {
        $classIds = @($script:NetworkAtcCapability.SelectNodes('//ClassType') | ForEach-Object ID)
        $classIds | Should -Be @(
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent',
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus',
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus'
        )
        @($script:NetworkAtcCapability.SelectNodes('//RelationshipType')).Count | Should -Be 6
        @($script:NetworkAtcCapability.SelectNodes('//DiscoveryClass')).Count | Should -Be 3
        @($script:NetworkAtcCapability.SelectNodes('//DiscoveryRelationship')).Count | Should -Be 6
        $script:NetworkAtcCapability.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC.NodeStatusReferencesComputerNetworkAdapter']") | Should -Not -BeNullOrEmpty
    }

    It 'uses only core HCS dependencies and keeps Network ATC an optional read-only authority' {
        $references = @($script:NetworkAtcCapability.SelectNodes('/ManagementPack/Manifest/References/Reference') | ForEach-Object { [string]$_.ID })
        $references | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Library'
        $references | Should -Contain 'HybridSolutionsCloud.HyperVPrivateCloud.Presentation'
        ($references -join "`n") | Should -Not -Match 'Cluster|SDN|VirtualMachineManager|PureStorage|StorageSpacesDirect'
        $scriptText = $script:NetworkAtcCapability.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC.Discovery']//ScriptBody").InnerText
        $scriptText | Should -Match 'Get-NetIntentStatus'
        $scriptText | Should -Match 'NetAdapterNamesAsList|NetAdapterNameCsv'
        $scriptText | Should -Match 'Microsoft\.Windows\.ComputerNetworkAdapter'
        $scriptText | Should -Not -Match '(?i)\b(Add|Set|Remove|Update)-NetIntent|Set-NetIntentRetryState|Restart-Service'
    }

    It 'implements explicit authority, convergence, adapter, and global health without remediation' {
        @($script:NetworkAtcCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 4
        @($script:NetworkAtcCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 4
        @($script:NetworkAtcCapability.SelectNodes('//Rule')).Count | Should -Be 0
        $capability = $script:NetworkAtcCapability.SelectSingleNode("//UnitMonitor[contains(@ID,'CapabilityHealth')]")
        $capability.Configuration.RequireNetworkATC | Should -Be 'false'
        $adapter = $script:NetworkAtcCapability.SelectSingleNode("//UnitMonitor[contains(@ID,'AdapterReadiness')]")
        $adapter.Configuration.RequireRdmaForStorage | Should -Be 'true'
        $healthScript = $script:NetworkAtcCapability.SelectSingleNode("//DataSourceModuleType[contains(@ID,'Health.DataSource')]//ScriptBody").InnerText
        $healthScript | Should -Match "ConfigurationStatus"
        $healthScript | Should -Match "configuration -eq 'Success'"
        $healthScript | Should -Match "ProvisioningStatus"
        $healthScript | Should -Match "MaxTransitionalMinutes"
        $healthScript | Should -Match "ManualOrExternal"
        $healthScript | Should -Not -Match '(?i)\b(Add|Set|Remove|Update)-NetIntent|Set-NetIntentRetryState|Restart-Service'
    }

    It 'provides localized Network ATC views, alerts, and operational knowledge under Networking' {
        @($script:NetworkAtcCapability.SelectNodes('//View')).Count | Should -Be 7
        foreach ($item in $script:NetworkAtcCapability.SelectNodes('//FolderItem')) {
            [string]$item.Folder | Should -Be 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Networking.Folder'
        }
        foreach ($monitor in $script:NetworkAtcCapability.SelectNodes('//UnitMonitor')) {
            $script:NetworkAtcCapability.SelectSingleNode("//StringResource[@ID='$($monitor.AlertSettings.AlertMessage)']") | Should -Not -BeNullOrEmpty
            $script:NetworkAtcCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='$($monitor.ID)']") | Should -Not -BeNullOrEmpty
        }
    }

    It 'contains syntactically valid PowerShell 7 Network ATC scripts' {
        foreach ($scriptBody in $script:NetworkAtcCapability.SelectNodes('//ScriptBody')) {
            $scriptBody.InnerText | Should -Match '^#Requires -Version 7\.0'
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
    }

    It 'pins SDN integration to Microsoft 10.0.0.2 and does not duplicate Microsoft SDN resources' {
        $sdnReference = $script:SdnCapability.SelectSingleNode("/ManagementPack/Manifest/References/Reference[@Alias='SDN']")
        $sdnReference.ID | Should -Be 'Microsoft.Windows.10.SDNMonitoring'
        $sdnReference.Version | Should -Be '10.0.0.2'
        $sdnReference.PublicKeyToken | Should -Be '31bf3856ad364e35'
        $classes = @($script:SdnCapability.SelectNodes('//ClassType'))
        $classes.Count | Should -Be 1
        $classes[0].ID | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.HostBinding'
        $script:SdnCapability.OuterXml | Should -Not -Match '<ClassType ID="SDNMonitoringMP\.'
    }

    It 'maps SDN control-plane and data-plane groups into the correct private-cloud branches' {
        @($script:SdnCapability.SelectNodes('//RelationshipType')).Count | Should -Be 10
        @($script:SdnCapability.SelectNodes('//DiscoveryRelationship')).Count | Should -Be 10
        $controller = $script:SdnCapability.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.ManagementContainsNetworkControllerGroup']/Target")
        $controller.Type | Should -Be 'SDN!SDNMonitoringMP.SDNMonitoring.NetworkControllerClusterNodeGroup'
        foreach ($leaf in @('HostGroup', 'VirtualNetworkGroup', 'AccessControlListGroup', 'NetworkInterfaceGroup', 'LoadBalancerMuxGroup', 'GatewayPoolGroup')) {
            $script:SdnCapability.SelectSingleNode("//RelationshipType[contains(@ID,'NetworkContains$leaf')]") | Should -Not -BeNullOrEmpty
        }
        $script:SdnCapability.SelectSingleNode("//RelationshipType[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.NetworkReferencesStamp']") | Should -Not -BeNullOrEmpty
    }

    It 'adds service impact and the missing Network Controller security rollup without duplicate leaf alerts' {
        @($script:SdnCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 1
        @($script:SdnCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 11
        @($script:SdnCapability.SelectNodes('//Rule')).Count | Should -Be 0
        $monitor = $script:SdnCapability.SelectSingleNode("//UnitMonitor[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.IntegrationHealth.Monitor']")
        $monitor.Configuration.RequireSDN | Should -Be 'false'
        $monitor.Configuration.RequireSlbHostAgent | Should -Be 'false'
        $monitor.SelectSingleNode('AlertSettings') | Should -BeNullOrEmpty
        $securityRollup = $script:SdnCapability.SelectSingleNode("//DependencyMonitor[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.NetworkControllerGroup.Security.Dependency.Monitor']")
        $securityRollup.RelationshipType | Should -Be 'SDN!SDNMonitoringMP.SDNMonitoring.NetworkControllerClusterNodeGroupHostsNetworkControllerClusterNode'
        $securityRollup.MemberMonitor | Should -Be 'Health!System.Health.SecurityState'
    }

    It 'uses read-only local host evidence and no competing Network Controller query or remediation path' {
        $discoveryScript = $script:SdnCapability.SelectSingleNode("//Discovery[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.Relationship.Discovery']//ScriptBody").InnerText
        $healthScript = $script:SdnCapability.SelectSingleNode("//DataSourceModuleType[contains(@ID,'IntegrationHealth.DataSource')]//ScriptBody").InnerText
        $discoveryScript | Should -Match 'NcHostAgent\\Parameters'
        $discoveryScript | Should -Match 'Get-Service -Name \$Name'
        $discoveryScript | Should -Match "Get-HcsServiceState -Name 'NcHostAgent'"
        $healthScript | Should -Match 'RequireSDN'
        $healthScript | Should -Match 'RequireSlbHostAgent'
        ($discoveryScript + $healthScript) | Should -Not -Match '(?i)\b(Get|New|Set|Remove|Debug)-NetworkController|Invoke-RestMethod|Restart-Service|Start-Service|Stop-Service'
    }

    It 'provides localized Microsoft SDN topology, alert, state, and performance views' {
        @($script:SdnCapability.SelectNodes('//View')).Count | Should -Be 16
        $folder = $script:SdnCapability.SelectSingleNode("//Folder[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.Folder']")
        $folder.ParentFolder | Should -Be 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Networking.Folder'
        foreach ($item in $script:SdnCapability.SelectNodes('//FolderItem')) {
            [string]$item.Folder | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.Folder'
        }
        foreach ($target in @('StampGroup', 'NetworkControllerClusterNode', 'Host', 'VirtualNetwork', 'AccessControlList', 'NetworkInterface', 'LoadBalancerMux', 'VirtualGateway', 'NetworkConnection', 'BGPRouter', 'BGPPeer', 'GatewayPool', 'Gateway')) {
            $script:SdnCapability.SelectSingleNode("//View[contains(@Target,'$target')]") | Should -Not -BeNullOrEmpty
        }
    }

    It 'contains syntactically valid PowerShell 7 SDN scripts and actionable knowledge' {
        foreach ($scriptBody in $script:SdnCapability.SelectNodes('//ScriptBody')) {
            $scriptBody.InnerText | Should -Match '^#Requires -Version 7\.0'
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
        $script:SdnCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN.IntegrationHealth.Monitor']") | Should -Not -BeNullOrEmpty
    }

    It 'pins the VMM 2025 adapter to the exact shipped Microsoft Management Pack identities' {
        $expected = [ordered]@{
            VMMBase = @('Microsoft.SystemCenter.VirtualMachineManager.Library', '11.19.0.3')
            VMMDiscovery = @('Microsoft.SystemCenter.VirtualMachineManager.Discovery', '11.19.0.3')
            VMMMonitoring = @('Microsoft.SystemCenter.VirtualMachineManager.Monitoring', '11.19.0.3')
            VMMProV2 = @('Microsoft.SystemCenter.VirtualMachineManager.PRO.V2.Library', '10.25.1200.0')
        }
        foreach ($entry in $expected.GetEnumerator()) {
            $reference = $script:VmmCapability.SelectSingleNode("/ManagementPack/Manifest/References/Reference[@Alias='$($entry.Key)']")
            $reference.ID | Should -Be $entry.Value[0]
            $reference.Version | Should -Be $entry.Value[1]
            $reference.PublicKeyToken | Should -Be '31bf3856ad364e35'
        }
    }

    It 'reuses Microsoft VMM fabric objects and adds only the verified logical-network gap classes' {
        $classIds = @($script:VmmCapability.SelectNodes('//ClassType') | ForEach-Object ID)
        $classIds | Should -Be @(
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM.LogicalNetwork',
            'HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM.NetworkSite'
        )
        $script:VmmCapability.OuterXml | Should -Not -Match '<ClassType ID="Microsoft\.SystemCenter\.VirtualMachineManager\.'
        @($script:VmmCapability.SelectNodes('//RelationshipType')).Count | Should -Be 9
        foreach ($target in @('VMMManagementServer', 'HyperVHost', 'PrivateCloud', 'VMNetwork')) {
            $script:VmmCapability.SelectSingleNode("//RelationshipType/*[contains(@Type,'$target')]") | Should -Not -BeNullOrEmpty
        }
    }

    It 'creates a VMM fabric service and maps VMM hosts and clouds into local Hyper-V boundaries' {
        @($script:VmmCapability.SelectNodes('//Discovery')).Count | Should -Be 3
        $fabricScript = $script:VmmCapability.SelectSingleNode("//Discovery[contains(@ID,'Fabric.Discovery')]//ScriptBody").InnerText
        $hostScript = $script:VmmCapability.SelectSingleNode("//Discovery[contains(@ID,'Host.Relationship.Discovery')]//ScriptBody").InnerText
        $cloudScript = $script:VmmCapability.SelectSingleNode("//Discovery[contains(@ID,'Cloud.Relationship.Discovery')]//ScriptBody").InnerText
        $fabricScript | Should -Match "VirtualMachineManagerFabric"
        $fabricScript | Should -Match 'Get-SCLogicalNetwork'
        $fabricScript | Should -Match 'Get-SCLogicalNetworkDefinition'
        $fabricScript | Should -Match 'Get-SCVMNetwork'
        $hostScript | Should -Match "'vmm:\{0\}'"
        $hostScript | Should -Match "'cluster:\{0\}'"
        $hostScript | Should -Match 'HostRoleReferencesVMMHost'
        $cloudScript | Should -Match 'ManagementReferencesPrivateCloud'
        $cloudScript | Should -Match "-split '\[;,\]'"
    }

    It 'uses the Microsoft VMM connection Run As profile with read-only queries only' {
        $runAs = 'VMMProV2!Microsoft.SystemCenter.VirtualMachineManager.2012.VMMServerConnectionRunAsProfile'
        $script:VmmCapability.SelectSingleNode("//Discovery[contains(@ID,'Fabric.Discovery')]/DataSource").RunAs | Should -Be $runAs
        @($script:VmmCapability.SelectNodes("//UnitMonitor[contains(@ID,'IntegrationHealth.Monitor') or contains(@ID,'FailedJobs.Monitor')]") | ForEach-Object RunAs) |
            Should -Be @($runAs, $runAs)
        $script:VmmCapability.SelectSingleNode("//UnitMonitorType[contains(@ID,'Health.MonitorType')]//DataSource[@ID='DataSource']").RunAs |
            Should -BeNullOrEmpty
        $scripts = @($script:VmmCapability.SelectNodes('//ScriptBody') | ForEach-Object InnerText) -join "`n"
        $scripts | Should -Match 'Get-SCVMMServer'
        $scripts | Should -Match 'Get-SCJob'
        $scripts | Should -Not -Match '(?i)\b(New|Set|Remove|Restart|Repair|Start|Stop)-SC|Invoke-Sqlcmd|Restart-Service|Start-Service|Stop-Service'
    }

    It 'monitors VMM query coverage and recent failed jobs without duplicating Microsoft leaf alerts' {
        @($script:VmmCapability.SelectNodes('//UnitMonitor')).Count | Should -Be 2
        @($script:VmmCapability.SelectNodes('//DependencyMonitor')).Count | Should -Be 10
        @($script:VmmCapability.SelectNodes('//Rule')).Count | Should -Be 0
        $failedJobs = $script:VmmCapability.SelectSingleNode("//UnitMonitor[contains(@ID,'FailedJobs.Monitor')]")
        $failedJobs.Configuration.JobLookbackHours | Should -Be '24'
        $failedJobs.Configuration.FailedJobCriticalCount | Should -Be '1'
        $failedJobs.Configuration.PropertyName | Should -Be 'FailedJobState'
        $healthScript = $script:VmmCapability.SelectSingleNode("//DataSourceModuleType[contains(@ID,'Health.DataSource')]//ScriptBody").InnerText
        $healthScript | Should -Match "Status -eq 'Failed'"
        $healthScript | Should -Match 'Get-SCJob -VMMServer \$vmmServer -Newest \$JobLookbackHours'
        $knowledge = $script:VmmCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM.IntegrationHealth.Monitor']").InnerText
        $knowledge | Should -Match 'Read-Only|read-only' -Because 'operator knowledge must establish least privilege'
    }

    It 'rolls only VMM-specific host checks plus Microsoft server and cloud health into the DA' {
        $winRmRollups = @($script:VmmCapability.SelectNodes("//DependencyMonitor[contains(@MemberMonitor,'HostWinRMService.Monitor')]")).Count
        $agentRollups = @($script:VmmCapability.SelectNodes("//DependencyMonitor[contains(@MemberMonitor,'HostVMMAgentVersionMonitor')]")).Count
        $winRmRollups | Should -Be 2
        $agentRollups | Should -Be 2
        $script:VmmCapability.OuterXml | Should -Not -Match 'HostCPUUtilizationMonitor|HostMemoryUtilizationMonitor|HyperVService.Monitor'
    }

    It 'provides a dedicated VMM console folder with fabric, topology, alert, and performance views' {
        @($script:VmmCapability.SelectNodes('//View')).Count | Should -Be 20
        $folder = $script:VmmCapability.SelectSingleNode("//Folder[@ID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM.Folder']")
        $folder.ParentFolder | Should -Be 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Root.Folder'
        foreach ($item in $script:VmmCapability.SelectNodes('//FolderItem')) {
            [string]$item.Folder | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM.Folder'
        }
        foreach ($target in @('VMMManagementServer', 'PrivateCloud', 'HostGroup', 'HostCluster', 'HyperVHost', 'VirtualMachine', 'VMNetwork', 'LogicalNetwork', 'NetworkSite', 'VSwitch', 'StoragePool')) {
            $script:VmmCapability.SelectSingleNode("//View[contains(@Target,'$target')]") | Should -Not -BeNullOrEmpty
        }
    }

    It 'contains syntactically valid PowerShell 7 VMM scripts and actionable knowledge' {
        foreach ($scriptBody in $script:VmmCapability.SelectNodes('//ScriptBody')) {
            $scriptBody.InnerText | Should -Match '^#Requires -Version 7\.0'
            $tokens = $null
            $parseErrors = $null
            [System.Management.Automation.Language.Parser]::ParseInput($scriptBody.InnerText, [ref]$tokens, [ref]$parseErrors) | Out-Null
            @($parseErrors).Count | Should -Be 0
        }
        foreach ($monitorId in @('IntegrationHealth', 'FailedJobs')) {
            $script:VmmCapability.SelectSingleNode("//KnowledgeArticle[@ElementID='HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM.$monitorId.Monitor']") | Should -Not -BeNullOrEmpty
        }
    }

    It 'writes UTF-8 XML without a byte-order mark' {
        $path = Join-Path $script:Output 'HybridSolutionsCloud.HyperVPrivateCloud.Library.xml'
        $bytes = [System.IO.File]::ReadAllBytes($path)
        @($bytes[0], $bytes[1], $bytes[2]) -join ',' | Should -Not -Be '239,187,191'
    }
}
