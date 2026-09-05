#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

BeforeAll {
    $script:Fragments = Join-Path $PSScriptRoot '../../src/hyper-v/scom-mp/fragments'
    $clusterPath = Join-Path $script:Fragments 'capabilities/cluster/Get-HyperVPrivateCloudClusterCsvHealth.ps1.template'
    $tokens = $null
    $parseErrors = $null
    $ast = [Management.Automation.Language.Parser]::ParseFile($clusterPath, [ref]$tokens, [ref]$parseErrors)
    if ($parseErrors.Count) { throw ($parseErrors.Message -join '; ') }
    $helper = $ast.Find({ param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst] -and $node.Name -eq 'Get-HcsSafeCollection' }, $true)
    . ([scriptblock]::Create($helper.Extent.Text))
}

Describe 'Cluster event collection error classification' {
    BeforeEach { $script:HcsCollectionFailures = [Collections.Generic.List[string]]::new() }

    It 'accepts an empty event search without declaring a collection failure' {
        $result = Get-HcsSafeCollection -AllowNoMatchingEvents -Query {
            Write-Error -Message 'No events were found.' -ErrorId 'NoMatchingEventsFound,Microsoft.PowerShell.Commands.GetWinEventCommand' -ErrorAction Stop
        }
        $result.Count | Should -Be 0
        $script:HcsCollectionFailures.Count | Should -Be 0
    }

    It 'retains an access failure even when an empty event search is allowed' {
        $result = Get-HcsSafeCollection -AllowNoMatchingEvents -Name 'cluster failover events' -Query {
            throw [UnauthorizedAccessException]::new('Access denied')
        }
        $result.Count | Should -Be 0
        $script:HcsCollectionFailures.Count | Should -Be 1
        $script:HcsCollectionFailures[0] | Should -Match 'cluster failover events failed: Access denied'
    }

    It 'does not suppress the same error for other collection types' {
        $null = Get-HcsSafeCollection -Query {
            Write-Error -Message 'No events were found.' -ErrorId 'NoMatchingEventsFound' -ErrorAction Stop
        }
        $script:HcsCollectionFailures.Count | Should -Be 1
    }
}

Describe 'Live migration alert event selection' {
    It 'does not label a migration-start notification as a failure' {
        $text = Get-Content (Join-Path $script:Fragments 'monitoring/ManagementPack.xml.template') -Raw
        $ruleText = [regex]::Match($text, '<Rule ID="HyperVPrivateCloud.Host.Event.LiveMigrationFailed.Alert.Rule".*?</Rule>', 'Singleline').Value
        [xml]$rule = $ruleText
        $eventIds = @($rule.SelectNodes('//Expression/SimpleExpression/ValueExpression/Value') | ForEach-Object InnerText)
        $eventIds | Should -Not -Contain '20413'
        $eventIds | Should -Contain '21502'
        $eventIds | Should -Contain '21501'
        $eventIds | Should -Contain '21125'
    }
}

Describe 'Cluster without CSV storage' {
    It 'reports healthy when there are no failover events and never queries CSV counters' {
        Import-Module (Join-Path $PSScriptRoot 'HcsProbeFixture.psm1') -Force
        $stubs = @'
function Get-Cluster { [pscustomobject]@{Name='fixture-cluster';WitnessDynamicWeight=1} }
function Get-ClusterNode { [pscustomobject]@{State='Up';DynamicWeight=1}; [pscustomobject]@{State='Up';DynamicWeight=1} }
function Get-ClusterQuorum { [pscustomobject]@{QuorumType='Majority';QuorumResource=[pscustomobject]@{ResourceType='Cloud Witness';State='Online'}} }
function Get-ClusterNetwork { [pscustomobject]@{State='Up'} }
function Get-ClusterGroup { [pscustomobject]@{State='Online'} }
function Get-ClusterSharedVolume { @() }
function Get-WinEvent { Write-Error -Message 'No matching events' -ErrorId 'NoMatchingEventsFound,Microsoft.PowerShell.Commands.GetWinEventCommand' -ErrorAction Stop }
function Get-Counter { throw 'CSV_COUNTER_QUERY_MUST_NOT_RUN' }
'@
        $result = Invoke-HcsFixtureProbe -TemplatePath (Join-Path $script:Fragments 'capabilities/cluster/Get-HyperVPrivateCloudClusterCsvHealth.ps1.template') -Parameters @{ComputerName='fixture';BoundaryId='cluster:fixture'} -Stubs $stubs
        $result.ClusterCsvHealthState | Should -Be 'Good'
        $result.CsvCount | Should -Be 0
        $result.GroupFailoverEventCount | Should -Be 0
        $result.HcsEventLog | Should -BeNullOrEmpty
    }
}

Describe 'Topology discovery submission' {
    It 'references singleton roots without submitting empty class instances' {
        Import-Module (Join-Path $PSScriptRoot 'HcsProbeFixture.psm1') -Force
        $stubs = @'
function Get-Module { param($Name, [switch]$ListAvailable) [pscustomobject]@{Name=$Name} }
function Import-Module { param($Name) }
function Get-VMHost { [pscustomobject]@{} }
function Get-VM { @() }
function Get-VMSwitch { @() }
function Get-Service { param($Name) $null }
function Get-ItemProperty { param($LiteralPath, $Name) $null }
function Get-DnsClientServerAddress { param($AddressFamily) @() }
function Get-CimInstance {
    param($ClassName, $Namespace, $Filter)
    switch ($ClassName) {
        'Win32_ComputerSystem' { [pscustomobject]@{NumberOfLogicalProcessors=16;TotalPhysicalMemory=68719476736;PartOfDomain=$false;Domain='';Workgroup='WORKGROUP'} }
        'Win32_OperatingSystem' { [pscustomobject]@{Version='10.0.26100'} }
        default { $null }
    }
}

'@
        $result = Invoke-HcsFixtureProbe -TemplatePath (Join-Path $script:Fragments 'discovery/Discover-HyperVPrivateCloudTopology.ps1.template') -Parameters @{
            SourceId = '{00000000-0000-0000-0000-000000000000}'
            ManagedEntityId = '{00000000-0000-0000-0000-000000000000}'
            ComputerName = 'fixture.example.test'
        } -Stubs $stubs
        $result.HcsInstanceCount | Should -BeGreaterThan 20
        $result.HcsEmptyClassInstanceCount | Should -Be 0
        $result.HcsEventLog | Should -BeNullOrEmpty
    }
}

Describe 'Runtime deployment safeguards' {
    It 'returns command output from both diagnostic write-action wrappers' {
        [xml]$library = Get-Content (Join-Path $script:Fragments 'library/ManagementPack.xml.template') -Raw
        foreach ($id in @('HyperVPrivateCloud.Pwsh.WriteAction', 'HyperVPrivateCloud.WinPS.WriteAction')) {
            $library.SelectSingleNode("//WriteActionModuleType[@ID='$id']//RequireOutput").InnerText | Should -Be 'true'
        }
    }

    It 'builds a discovery-only hotfix using the installed library and corrected source' {
        $destination = Join-Path $TestDrive 'hotfix.xml'
        & (Join-Path $PSScriptRoot '../../tools/scom/New-HyperVTopologyHotfix.ps1') -LibraryVersion '1.3.4.0' -PublicKeyToken '54d0fb1159995c86' -OutputPath $destination
        [xml]$hotfix = Get-Content $destination -Raw
        $hotfix.SelectNodes('//Discovery').Count | Should -Be 1
        $hotfix.SelectNodes('//ClassType|//UnitMonitor|//Rule|//Task|//Override').Count | Should -Be 0
        $hotfix.SelectSingleNode('//Reference[ID="HyperVPrivateCloud.Library"]/Version').InnerText | Should -Be '1.3.4.0'
        $expected = Get-Content (Join-Path $script:Fragments 'discovery/Discover-HyperVPrivateCloudTopology.ps1.template') -Raw
        $actual = $hotfix.SelectSingleNode('//Discovery/DataSource/ScriptBody').InnerText
        ($actual -replace "`r`n", "`n").TrimEnd() | Should -Be (($expected -replace "`r`n", "`n").TrimEnd())
        $hotfix.OuterXml | Should -Not -Match '\{\{[A-Z_]+\}\}'
    }
}
