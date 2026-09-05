#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

BeforeAll {
    $script:VmmProbe=Join-Path $PSScriptRoot '../../src/hyper-v/scom-mp/fragments/capabilities/vmm/Get-HyperVPrivateCloudVmmHealth.ps1.template'
    $tokens=$null; $parseErrors=$null
    $ast=[Management.Automation.Language.Parser]::ParseFile($script:VmmProbe,[ref]$tokens,[ref]$parseErrors)
    if ($parseErrors.Count) { throw ($parseErrors.Message -join '; ') }
    foreach ($function in $ast.FindAll({param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst]},$false)) {
        . ([scriptblock]::Create($function.Extent.Text))
    }
    function Get-SCVMHost { }
    Mock Test-HcsCommand { $true }
}

Describe 'VMM host-group memory units' {
    It 'converts available MiB to bytes before comparing against total bytes' {
        Mock Get-SCVMHost { [pscustomobject]@{VMHostGroup=[pscustomobject]@{Name='fixture'};TotalMemory=1TB;AvailableMemory=786432;TotalStorageCapacity=2TB;AvailableStorageCapacity=1TB;CpuUtilization=5;LogicalProcessorCount=64} }
        $records=@(Get-HcsHostGroupCapacity -VmmServer 'fixture')
        $records.Count | Should -Be 1
        $records[0].MemoryPercent | Should -Be 25
        $records[0].StoragePercent | Should -Be 50
    }

    It 'does not invent 100 percent memory usage when available memory is missing' {
        Mock Get-SCVMHost { [pscustomobject]@{VMHostGroup=[pscustomobject]@{Name='fixture'};TotalMemory=1TB} }
        $records=@(Get-HcsHostGroupCapacity -VmmServer 'fixture')
        $records[0].MemoryPercent | Should -Be -1
    }

    It 'distinguishes missing usage from a genuine zero' {
        Get-HcsPercentUsed -Used $null -Total 100 | Should -Be -1
        Get-HcsPercentUsed -Used 0 -Total 100 | Should -Be 0
    }
}

Describe 'VMM uplink applicability' {
    BeforeAll { Import-Module (Join-Path $PSScriptRoot 'HcsProbeFixture.psm1') -Force }

    It 'ignores an unused disconnected NIC with an empty network map' {
        $stubs=@'
function Get-SCVMMServer { [pscustomobject]@{Name='fixture'} }
function Get-SCVMHostNetworkAdapter {
    [pscustomobject]@{ConnectionName='spare';VirtualNetwork='';LogicalNetworkMap=@{};ConnectionState='MediaDisconnected'}
    [pscustomobject]@{ConnectionName='uplink';VirtualNetwork='fixture-switch';LogicalNetworkMap=@{fixture='subnet'};ConnectionState='Connected'}
}
'@
        $result=Invoke-HcsFixtureProbe -TemplatePath $script:VmmProbe -Parameters @{ComputerName='fixture';Mode='VirtualSwitchUplink'} -Stubs $stubs
        $result.VirtualSwitchUplinkState | Should -Be 'Good'
        $result.HcsEventLog | Should -BeNullOrEmpty
    }

    It 'still detects a disconnected adapter that really belongs to a virtual switch' {
        $stubs=@'
function Get-SCVMMServer { [pscustomobject]@{Name='fixture'} }
function Get-SCVMHostNetworkAdapter { [pscustomobject]@{ConnectionName='uplink';VirtualNetwork='fixture-switch';LogicalNetworkMap=@{fixture='subnet'};ConnectionState='MediaDisconnected'} }
'@
        $result=Invoke-HcsFixtureProbe -TemplatePath $script:VmmProbe -Parameters @{ComputerName='fixture';Mode='VirtualSwitchUplink'} -Stubs $stubs
        $result.VirtualSwitchUplinkState | Should -Be 'Critical'
        $result.VirtualSwitchUplinkStateDetail | Should -Match 'fixture-switch'
    }
}
