#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

BeforeAll {
    $script:CapabilityRoot = Join-Path $PSScriptRoot '../../src/hyper-v/scom-mp/fragments/capabilities'
    function Invoke-OperatorFixture {
        param([string]$Capability, [string]$Action, [string]$Stubs)
        $taskName = if ($Capability -eq 'cluster') { 'Cluster' } else { 'Vmm' }
        $body = Get-Content "$script:CapabilityRoot/$Capability/Invoke-HyperVPrivateCloud${taskName}Task.ps1.template" -Raw
        $command = $Stubs + "`n& {`n" + $body + "`n} -Action '$Action' -ComputerName fixture"
        $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($command))
        $runtime = if ($IsWindows) { "$env:windir/System32/WindowsPowerShell/v1.0/powershell.exe" } else { (Get-Command pwsh).Source }
        $output = & $runtime -NoProfile -NonInteractive -EncodedCommand $encoded 2>&1 | Out-String
        [pscustomobject]@{ ExitCode = $LASTEXITCODE; Output = $output }
    }
    $script:Common = @'
function Get-Module { [pscustomobject]@{ Name='Fixture'; Path='Fixture' } }
function Import-Module { }
'@
    $script:Cluster = $script:Common + @'

function Get-Cluster { [pscustomobject]@{Name='fixture-cluster'} }
function Get-ClusterQuorum { }
function Get-ClusterNode { }
function Get-ClusterNetwork { }
function Get-ClusterNetworkInterface { }
function Get-ClusterGroup { }
function Get-ClusterSharedVolumeState { }
function Get-ClusterSharedVolume {
    [pscustomobject]@{Name='CSV01'; OwnerNode='host01'; State='Online'; SharedVolumeInfo=@(
        [pscustomobject]@{FriendlyVolumeName='CSV01'; Partition=$partition; RedirectedAccess=$false; MaintenanceMode=$false; FaultState='NoFaults'}
    )}
}
'@
}

Describe 'Operator task runtime regressions' {
    It 'calculates CSV used percentage without a nonexistent PercentUsed property' {
        $result = Invoke-OperatorFixture cluster ClusterSummary ($script:Cluster + "`n" + '$partition=[pscustomobject]@{Size=4397979402240;FreeSpace=3440903962624}')
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match '21[.,]76'
        $result.Output | Should -Not -Match 'FAILED:'
    }
    It 'fails explicitly for invalid CSV capacity: <Partition>' -ForEach @(
        @{Partition='@{Size=0;FreeSpace=0}'},
        @{Partition='@{FreeSpace=10}'},
        @{Partition='@{Size=100;FreeSpace=101}'},
        @{Partition='@{Size=100;FreeSpace=$null}'}
    ) {
        $result = Invoke-OperatorFixture cluster ClusterSummary ($script:Cluster + "`n" + '$partition=[pscustomobject]' + $Partition)
        $result.ExitCode | Should -Be 1
        $result.Output | Should -Match 'unavailable or invalid partition capacity'
    }
    It 'propagates VMM access denial as a failed process' {
        $result = Invoke-OperatorFixture vmm HostStatus ($script:Common + "`nfunction Get-SCVMMServer { throw 'Insufficient privileges' }")
        $result.ExitCode | Should -Be 1
        $result.Output | Should -Match 'FAILED: Insufficient privileges'
    }
    It 'returns successful VMM host output' {
        $result = Invoke-OperatorFixture vmm HostStatus ($script:Common + "`nfunction Get-SCVMMServer { 'fixture' }`nfunction Get-SCVMHost { [pscustomobject]@{Name='host01';OverallState='OK'} }")
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match 'host01'
        $result.Output | Should -Not -Match 'FAILED:'
    }
    It 'binds all five VMM task workflows to the VMM Run As profile' {
        [xml]$mp = Get-Content "$script:CapabilityRoot/vmm/ManagementPack.xml.template" -Raw
        $tasks = @($mp.SelectNodes('//Task/WriteAction'))
        $tasks.Count | Should -Be 5
        foreach ($task in $tasks) {
            $task.TypeID | Should -Be 'HyperVPrivateCloud.Capability.VMM.Task.WriteAction'
            $task.RunAs | Should -Be 'VMMProV2!Microsoft.SystemCenter.VirtualMachineManager.2012.VMMServerConnectionRunAsProfile'
        }
    }
}
