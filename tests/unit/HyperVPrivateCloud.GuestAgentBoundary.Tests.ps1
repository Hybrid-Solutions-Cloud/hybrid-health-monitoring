#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Describe 'Workload VM monitoring without guest SCOM agents' {
    BeforeAll {
        $script:Fragments=Join-Path $PSScriptRoot '../../src/hyper-v/scom-mp/fragments'
        [xml]$script:Library=Get-Content (Join-Path $script:Fragments 'library/ManagementPack.xml.template') -Raw
        $script:Topology=Get-Content (Join-Path $script:Fragments 'discovery/Discover-HyperVPrivateCloudTopology.ps1.template') -Raw
        $script:VmProbe=Get-Content (Join-Path $script:Fragments 'monitoring/Get-HyperVPrivateCloudVmHealth.ps1.template') -Raw
    }

    It 'hosts VM runtime objects on the Hyper-V computer rather than a guest agent' {
        $runtime=$script:Library.SelectSingleNode('//ClassType[@ID="HyperVPrivateCloud.VirtualMachineRuntime"]')
        $runtime.GetAttribute('Hosted') | Should -Be 'true'
        $runtime.GetAttribute('Base') | Should -Be 'Windows!Microsoft.Windows.LocalApplication'
        $script:Topology | Should -Match 'Add-HcsProperty \$runtimeInstance .*PrincipalName.*\$ComputerName'
        $script:Topology | Should -Not -Match 'Add-HcsProperty \$runtimeInstance .*PrincipalName.*\$vm\.'
    }

    It 'uses host-side Hyper-V queries and integration heartbeat without guest remoting' {
        $script:VmProbe | Should -Match 'Get-VM -Id \$VMId'
        $script:VmProbe | Should -Match 'Get-VMIntegrationService -VM \$vm'
        $script:VmProbe | Should -Not -Match '\b(Invoke-Command|Enter-PSSession|New-PSSession)\b'
        $script:VmProbe | Should -Not -Match 'Get-Service[^\r\n]*HealthService'
    }
}
