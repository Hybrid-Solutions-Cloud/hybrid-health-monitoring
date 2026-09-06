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

    It 'loads VMM in a private temporary directory and restores the process environment' {
        $stubs = $script:Common + @'

$originalTemp=$env:TEMP
$originalTmp=$env:TMP
function Import-Module {
    param($Name, [switch]$Global)
    if (-not $Global) { throw 'Module must be visible to the task after helper returns' }
    if ($env:TEMP -eq $originalTemp -or $env:TEMP -ne $env:TMP -or -not (Test-Path $env:TEMP)) { throw 'Compiler temp directory was not isolated' }
    $script:capturedScratch=$env:TEMP
}
function Get-SCVMMServer {
    if ($env:TEMP -ne $originalTemp -or $env:TMP -ne $originalTmp) { throw 'TEMP/TMP not restored' }
    if (Test-Path $script:capturedScratch) { throw 'Scratch directory leaked' }
    'fixture'
}
function Get-SCVMHost { [pscustomobject]@{Name='host01'} }
'@
        $result = Invoke-OperatorFixture vmm HostStatus $stubs
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match 'host01'
    }

    It 'preserves the first import failure instead of retrying into an alias conflict' {
        $stubs = $script:Common + @'

$script:imports=0
function Import-Module {
    $script:imports++
    if ($script:imports -gt 1) { throw 'Alias already exists' }
    throw 'Original compiler initialization error'
}
'@
        $result = Invoke-OperatorFixture vmm AgentVersions $stubs
        $result.ExitCode | Should -Be 1
        $result.Output | Should -Match 'FAILED: Original compiler initialization error'
        $result.Output | Should -Not -Match 'Alias already exists'
    }

    It 'uses nested native host agent versions and retains zero and false values' {
        $stubs = $script:Common + @'

function Get-SCVMMServer { [pscustomobject]@{Name='vmm';ProductVersion='10.25.1439.0'} }
function Get-SCVMHost { [pscustomobject]@{Name='host01';Agent=[pscustomobject]@{AgentVersion='10.25.1439.0'};MaintenanceHost=$false;CpuUtilization=0} }
'@
        $result = Invoke-OperatorFixture vmm HostStatus $stubs
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match '10.25.1439.0'
        $result.Output | Should -Match 'False'
        $result.Output | Should -Not -Match 'Unavailable'
        $versions = Invoke-OperatorFixture vmm AgentVersions $stubs
        $versions.ExitCode | Should -Be 0
        $versions.Output | Should -Match '10.25.1439.0\s+1\s+host01'
    }

    It 'labels missing host agent versions explicitly' {
        $stubs = $script:Common + "`nfunction Get-SCVMMServer { [pscustomobject]@{Name='vmm';ProductVersion='1.0'} }`nfunction Get-SCVMHost { [pscustomobject]@{Name='host01'} }"
        $result = Invoke-OperatorFixture vmm AgentVersions $stubs
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match 'Unavailable\s+1\s+host01'
    }

    It 'shows native library server status and agent version without invented share health' {
        $stubs = $script:Common + @'

function Get-SCVMMServer { 'fixture' }
function Get-SCLibraryServer { [pscustomobject]@{Name='lib01';Status='Responding';ManagedComputer=[pscustomobject]@{AgentVersion='10.25.1439.0'}} }
function Get-SCLibraryShare { [pscustomobject]@{Name='Library';Path='\\lib01\Library';LibraryServer=[pscustomobject]@{Name='lib01'}} }
'@
        $result = Invoke-OperatorFixture vmm LibraryStatus $stubs
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match 'Responding\s+10.25.1439.0'
        $result.Output | Should -Match '\\\\lib01\\Library\s+lib01'
        $result.Output | Should -Not -Match 'IsAvailableForPlacement|Unavailable'
    }

    It 'fails rather than silently omitting a denied library query' {
        $stubs = $script:Common + @'

function Get-SCVMMServer { 'fixture' }
function Get-SCLibraryServer { [CmdletBinding()]param($VMMServer) Write-Error 'Library access denied' }
function Get-SCLibraryShare { }
'@
        $result = Invoke-OperatorFixture vmm LibraryStatus $stubs
        $result.ExitCode | Should -Be 1
        $result.Output | Should -Match 'FAILED: Library access denied'
    }

    It 'isolates compiler temp files in every VMM module import path' {
        foreach ($name in @('Invoke-HyperVPrivateCloudVmmTask','Get-HyperVPrivateCloudVmmHealth','Discover-HyperVPrivateCloudVmmFabric')) {
            $path="$script:CapabilityRoot/vmm/$name.ps1.template"
            $text=Get-Content $path -Raw
            $errors=$null; $tokens=$null
            $ast=[Management.Automation.Language.Parser]::ParseFile($path,[ref]$tokens,[ref]$errors)
            $errors.Count | Should -Be 0
            $imports=@($ast.FindAll({param($n) $n -is [Management.Automation.Language.CommandAst] -and $n.GetCommandName() -eq 'Import-Module'},$true))
            $imports.Count | Should -Be 1
            $imports[0].Extent.Text | Should -Match '\$module.Path -Global'
            $text | Should -Match '\$env:TEMP = \$scratch'
            $text | Should -Match '(?s)finally\s*\{\s*\$env:TEMP = \$previousTemp\s*\$env:TMP = \$previousTmp'
        }
    }
}
