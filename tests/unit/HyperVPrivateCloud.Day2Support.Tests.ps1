#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

BeforeAll {
    $script:SourceRoot = Join-Path $PSScriptRoot '../../src/hyper-v/scom-mp'
    Import-Module (Join-Path $PSScriptRoot 'HcsProbeFixture.psm1') -Force
}

Describe 'Cluster failure episode evidence' {
    It 'correlates resource and group events by named role and exposes the actual error' {
        $stubs = @'
function Get-Cluster { [pscustomobject]@{Name='fixture-cluster';WitnessDynamicWeight=1} }
function Get-ClusterNode { [pscustomobject]@{State='Up';DynamicWeight=1}; [pscustomobject]@{State='Up';DynamicWeight=1} }
function Get-ClusterQuorum { [pscustomobject]@{QuorumType='NodeMajority';QuorumResource=$null} }
function Get-ClusterNetwork { [pscustomobject]@{State='Up'} }
function Get-ClusterGroup { [pscustomobject]@{Name='fixture-role';State='Failed';OwnerNode='fixture-node'} }
function Get-ClusterSharedVolume { @() }
function Get-WinEvent {
    foreach ($id in @(1069,1205,1254)) {
        $event = [pscustomobject]@{Id=$id;RecordId=$id;TimeCreated=[datetime]'2026-09-06T14:00:01Z'}
        $event | Add-Member ScriptMethod ToXml { '<Event><EventData><Data Name="ResourceName">fixture-config</Data><Data Name="ResourceGroup">fixture-role</Data><Data Name="ApplicationErrorCode">The system cannot find the path specified.</Data><Data Name="ErrorCause">0x3</Data></EventData></Event>' }
        $event
    }
}
'@
        $result = Invoke-HcsFixtureProbe -TemplatePath (Join-Path $script:SourceRoot 'fragments/capabilities/cluster/Get-HyperVPrivateCloudClusterCsvHealth.ps1.template') -Parameters @{ComputerName='fixture-node';BoundaryId='cluster:fixture'} -Stubs $stubs
        $result.HcsEventLog | Should -BeNullOrEmpty
        $result.GroupFailoverEventCount | Should -Be 1
        $result.GroupFailedCount | Should -Be 1
        $result.GroupDetail | Should -Match "fixture-role.*fixture-node"
        $result.GroupDetail | Should -Match 'path specified.*0x3'
        $result.GroupDetail | Should -Match 'NOT a count of VM migrations'
        $result.GroupDetail | Should -Match 'UTC='
    }
}

Describe 'VMM enterprise diagram membership' {
    It 'emits the enterprise links in an actual discovery payload without empty singleton instances' {
        $stubs = @'
# The positive fixture must not depend on VMM being installed on the build runner.
function Get-Module { param([string]$Name, [switch]$ListAvailable) if ($Name -eq 'VirtualMachineManager') { [pscustomobject]@{Name=$Name;Path='fixture-vmm-module.psm1'} } }
function Import-Module { }
function Get-SCVMMServer { [pscustomobject]@{Name='fixture-vmm'} }
function Get-SCLogicalNetwork { @() }
function Get-SCLogicalNetworkDefinition { @() }
function Get-SCVMNetwork { @() }
'@
        $result = Invoke-HcsFixtureProbe -TemplatePath (Join-Path $script:SourceRoot 'fragments/capabilities/vmm/Discover-HyperVPrivateCloudVmmFabric.ps1.template') -Parameters @{ComputerName='fixture-vmm';SourceId='fixture';ManagedEntityId='fixture'} -Stubs $stubs
        $result.HcsEventLog | Should -BeNullOrEmpty
        $result.HcsEmptyClassInstanceCount | Should -Be 0
        foreach ($edge in @('SolutionContainsFabric','SolutionContainsManagementStack','FabricContainsService','ManagementStackContainsManagementComponent','ManagementStackContainsMonitoringComponent')) {
            @($result.HcsRelationships | Where-Object { $_.TypeId -match "HyperVPrivateCloud\.$edge" }).Count | Should -Be 1
        }
    }
    It 'declares and emits all five enterprise relationships without submitting empty singletons' {
        $discovery = Get-Content (Join-Path $script:SourceRoot 'fragments/capabilities/vmm/Discover-HyperVPrivateCloudVmmFabric.ps1.template') -Raw
        [xml]$pack = (Get-Content (Join-Path $script:SourceRoot 'fragments/capabilities/vmm/ManagementPack.xml.template') -Raw).Replace('{{VERSION}}','1.3.8.0').Replace('{{PUBLIC_KEY_TOKEN}}','0123456789abcdef')
        $fabricDiscovery = $pack.SelectSingleNode('//Discovery[DiscoveryTypes/DiscoveryClass[@TypeID="HyperVPrivateCloud.Capability.VMM.LogicalNetwork"]]')
        foreach ($edge in @('SolutionContainsFabric','SolutionContainsManagementStack','FabricContainsService','ManagementStackContainsManagementComponent','ManagementStackContainsMonitoringComponent')) {
            $discovery | Should -Match "Add-HcsRelationship.*HyperVPrivateCloud\.$edge"
            $fabricDiscovery.SelectSingleNode("DiscoveryTypes/DiscoveryRelationship[@TypeID='HCSV2Library!HyperVPrivateCloud.$edge']") | Should -Not -BeNullOrEmpty
        }
        $discovery | Should -Not -Match 'AddInstance\(\$(solution|fabric|managementStack)\)'
    }
}

Describe 'Enterprise health aspect completeness' {
    It 'includes security in service and enterprise rollups so certificate failures reach the root' {
        $builder = Get-Content (Join-Path $script:SourceRoot 'tools/Build-HyperVPrivateCloudManagementPacks.ps1') -Raw
        $builder | Should -Match "@\('Security', 'SecurityState', 'SecurityHealth'\)"
    }
}

Describe 'Generated support knowledge contract' {
    BeforeAll {
        $script:SupportOutput = Join-Path $TestDrive 'support-build'
        & (Join-Path $script:SourceRoot 'tools/Build-HyperVPrivateCloudManagementPacks.ps1') -Version '1.3.8.0' -PublicKeyToken '0123456789abcdef' -OutputPath $script:SupportOutput
        $script:SupportPacks = @(Get-ChildItem $script:SupportOutput -Filter '*.xml' | ForEach-Object { [xml](Get-Content $_.FullName -Raw) })
    }
    It 'gives every class, unit/dependency monitor, rule and task actionable linked knowledge' {
        foreach ($pack in $script:SupportPacks) {
            foreach ($element in $pack.SelectNodes('//ClassType | //UnitMonitor | //DependencyMonitor | //Rule | //Task')) {
                $article = $pack.SelectSingleNode("//KnowledgeArticle[@ElementID='$($element.ID)']")
                $article | Should -Not -BeNullOrEmpty -Because $element.ID
                $article.InnerText | Should -Match 'Read-only investigation'
                $article.InnerText | Should -Match 'Corrective action and escalation'
                $article.InnerText | Should -Match 'Verify recovery'
                $links = @($article.SelectNodes('.//*[local-name()="uri"]'))
                $links.Count | Should -BeGreaterThan 0
                foreach ($link in $links) { $link.GetAttribute('href') | Should -Match '^https://learn\.microsoft\.com/' }
            }
        }
    }
    It 'documents exact lower-is-worse boundaries and immediate critical conditions' {
        $cluster = $script:SupportPacks | Where-Object { $_.ManagementPack.Manifest.Identity.ID -eq 'HyperVPrivateCloud.Capability.Cluster' }
        $free = $cluster.SelectSingleNode('//KnowledgeArticle[@ElementID="HyperVPrivateCloud.Capability.Cluster.CSV.FreeSpace.Monitor"]').InnerText
        $free | Should -Match "CsvWorstFreePercent'\] <= 15"
        $free | Should -Match "CsvWorstFreePercent'\] > 8"
        $free | Should -Match "CsvWorstFreePercent'\] <= 8"
        $cluster.SelectSingleNode('//KnowledgeArticle[@ElementID="HyperVPrivateCloud.Capability.Cluster.Group.Failed.Monitor"]').InnerText | Should -Match 'no intermediate numeric warning band'
        $cluster.SelectSingleNode('//DisplayString[@ElementID="HyperVPrivateCloud.Capability.Cluster.Group.Failover.Monitor.Message"]/Name').InnerText | Should -Be 'Cluster role failure episodes threshold breached'
    }
    It 'carries Security through every service branch and all enterprise dependencies' {
        $monitoring = $script:SupportPacks | Where-Object { $_.ManagementPack.Manifest.Identity.ID -eq 'HyperVPrivateCloud.Monitoring' }
        @($monitoring.SelectNodes('//DependencyMonitor[@Target="HCSV2Library!HyperVPrivateCloud.Service" and @ParentMonitorID="Health!System.Health.SecurityState"]')).Count | Should -Be 7
        @($monitoring.SelectNodes('//DependencyMonitor[contains(@ID,".Enterprise.") and @ParentMonitorID="Health!System.Health.SecurityState"]')).Count | Should -Be 5
    }
    It 'explains the actual probe branches for every core state-valued monitor' {
        $monitoring = $script:SupportPacks | Where-Object { $_.ManagementPack.Manifest.Identity.ID -eq 'HyperVPrivateCloud.Monitoring' }
        $stateMonitors = @($monitoring.SelectNodes('//UnitMonitor[not(Configuration/WarningThreshold)]'))
        $stateMonitors.Count | Should -Be 31
        foreach ($monitor in $stateMonitors) {
            $monitoring.SelectSingleNode("//KnowledgeArticle[@ElementID='$($monitor.ID)']").InnerText | Should -Match 'Probe-specific state reasons' -Because $monitor.ID
        }
    }
    It 'passes the complete official MP and MAML schemas' {
        { & (Join-Path $script:SourceRoot 'tools/Test-HyperVPrivateCloudSchema.ps1') -Path $script:SupportOutput } | Should -Not -Throw
    }
    It 'does not duplicate display or knowledge identities within a language pack' {
        foreach ($pack in $script:SupportPacks) {
            foreach ($language in $pack.SelectNodes('//LanguagePack')) {
                $displayKeys = @($language.SelectNodes('DisplayStrings/DisplayString') | ForEach-Object { $_.GetAttribute('ElementID') + '|' + $_.GetAttribute('SubElementID') })
                @($displayKeys | Group-Object | Where-Object Count -gt 1).Count | Should -Be 0 -Because $pack.ManagementPack.Manifest.Identity.ID
                @($language.SelectNodes('KnowledgeArticles/KnowledgeArticle') | Group-Object ElementID | Where-Object Count -gt 1).Count | Should -Be 0
            }
        }
    }
    It 'provides a source-defined root health path for every enabled product unit monitor' {
        $audit = & (Join-Path $script:SourceRoot 'tools/Test-HyperVPrivateCloudHealthGraph.ps1') -Path $script:SupportOutput -FailOnMissing | ConvertFrom-Json
        $audit.NotProvenReachable.Count | Should -Be 0
        $expected = @($script:SupportPacks | ForEach-Object { $_.SelectNodes('//UnitMonitor[@Enabled!="false"]') }).Count
        $audit.ReachedUnitMonitors | Should -Be $expected
    }
    It 'rejects empty input and a deliberately disconnected enabled leaf' {
        $empty = New-Item -ItemType Directory -Path (Join-Path $TestDrive 'empty-graph')
        { & (Join-Path $script:SourceRoot 'tools/Test-HyperVPrivateCloudHealthGraph.ps1') -Path $empty.FullName -FailOnMissing } | Should -Throw '*compiled solution root*'
        $broken = New-Item -ItemType Directory -Path (Join-Path $TestDrive 'broken-graph')
        Copy-Item (Join-Path $script:SupportOutput '*.xml') -Destination $broken.FullName
        $file = Join-Path $broken.FullName 'HyperVPrivateCloud.Monitoring.xml'
        [xml]$pack = Get-Content $file -Raw
        $leaf = $pack.CreateElement('UnitMonitor')
        $leaf.SetAttribute('ID','Fixture.Unreachable.Monitor')
        $leaf.SetAttribute('Target','Fixture.Unreachable.Class')
        $leaf.SetAttribute('ParentMonitorID','Health!System.Health.AvailabilityState')
        $leaf.SetAttribute('Enabled','true')
        [void]$pack.SelectSingleNode('/ManagementPack/Monitoring/Monitors').AppendChild($leaf)
        $pack.Save($file)
        { & (Join-Path $script:SourceRoot 'tools/Test-HyperVPrivateCloudHealthGraph.ps1') -Path $broken.FullName -FailOnMissing } | Should -Throw '*1 enabled product monitors*'
    }
    It 'declares participation containment in the owning discovery and preserves capability gating' {
        foreach ($capability in @('Storage','FileServices')) {
            $pack = $script:SupportPacks | Where-Object { $_.ManagementPack.Manifest.Identity.ID -eq "HyperVPrivateCloud.Capability.$capability" }
            $relationship = $pack.SelectSingleNode('//RelationshipType[contains(@ID,"ContainsHostParticipation")]')
            $relationship | Should -Not -BeNullOrEmpty
            $pack.SelectSingleNode("//DiscoveryRelationship[@TypeID='$($relationship.ID)']") | Should -Not -BeNullOrEmpty
            @($pack.SelectNodes("//DependencyMonitor[@RelationshipType='$($relationship.ID)']")).Count | Should -Be 4
            $scriptBody = $pack.SelectNodes('//Discovery/DataSource/ScriptBody') | Where-Object { $_.InnerText -match [regex]::Escape($relationship.ID) }
            @($scriptBody).Count | Should -Be 1
            $scriptBody.InnerText | Should -Match 'if \(\$(uncDiskCount|mpioDiskCount) -gt 0'
        }
    }
}
