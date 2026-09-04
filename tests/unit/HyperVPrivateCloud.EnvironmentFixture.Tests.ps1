#Requires -Version 7.0
<#
    Environment fixtures.

    ProbeSmoke proves a script parses, binds and returns a well-formed DataItem on THIS build host,
    which has no cluster, no VMM, no SAN, no Network ATC, no SDN and no fabric devices. It therefore
    proves nothing about what a probe REPORTS where a capability exists, or exists and is broken.
    That gap is how defects reached the management group: a probe that returns Good on a failure, or
    an alerting state on an absent capability, passes ProbeSmoke.

    These fixtures stub the platform and assert the health state each probe actually reports:

        absent   -> NotApplicable, and no error event
        failing  -> Warning or Critical, never Good

    The harness throws if a probe produces no bag, so a broken fixture fails loudly instead of
    passing vacuously on $null.
#>

BeforeAll {
    Import-Module (Join-Path $PSScriptRoot 'HcsProbeFixture.psm1') -Force
    $script:Fragments = Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) 'src/hyper-v/scom-mp/fragments'
    $script:FabricProbe = Join-Path $script:Fragments 'discovery/Get-HyperVPrivateCloudFabricHealth.ps1.template'
    # TEST-NET-3 (RFC 5737): guaranteed unroutable, so this is a genuinely unreachable device.
    $script:Unreachable = '203.0.113.7'
}

Describe 'Physical fabric device probe' {

    It 'reports NotApplicable, with no error event, when no management address is declared' {
        $state = Invoke-HcsFixtureProbe -TemplatePath $script:FabricProbe -Parameters @{
            DeviceKind = 'EdgeFirewall'; DeviceName = 'lab-rtp-inf-fw'; ManagementAddress = ''
        }
        $state.HcsBagCount | Should -BeGreaterThan 0
        $state.FabricDeviceState | Should -Be 'NotApplicable'
        $state.HcsEventLog | Should -BeNullOrEmpty -Because 'an undeclared device is not a fault'
    }

    It 'reports Critical when a declared device answers neither ICMP nor a management port' {
        $state = Invoke-HcsFixtureProbe -TemplatePath $script:FabricProbe -Parameters @{
            DeviceKind = 'TopOfRackSwitch'; DeviceName = 'LAB-RTP-DCF-LEAF-11'
            ManagementAddress = $script:Unreachable; ManagementPorts = '22'; TimeoutSeconds = 2
        }
        $state.FabricDeviceState | Should -Be 'Critical'
        $state.FabricDeviceStateDetail | Should -Match 'did not answer'
    }

    It 'never reports Good for a device it could not reach' -ForEach @(
        @{ Kind = 'TopOfRackSwitch' }, @{ Kind = 'OutOfBandSwitch' }, @{ Kind = 'EdgeFirewall' }
        @{ Kind = 'ConsoleServer' }, @{ Kind = 'PhysicalChassis' }
    ) {
        $state = Invoke-HcsFixtureProbe -TemplatePath $script:FabricProbe -Parameters @{
            DeviceKind = $Kind; DeviceName = "unreachable-$Kind"
            ManagementAddress = $script:Unreachable; ManagementPorts = '22'; TimeoutSeconds = 2
        }
        # Assert the harness actually captured a bag before trusting the state.
        $state.HcsBagCount | Should -BeGreaterThan 0
        $state.FabricDeviceState | Should -Not -BeNullOrEmpty
        $state.FabricDeviceState | Should -Not -Be 'Good' -Because "$Kind was unreachable"
    }

    It 'reports Good when the device accepts a connection on a management port' {
        # Bind a local listener and point the probe at it: a device that answers its management port.
        $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, 0)
        $listener.Start()
        try {
            $port = ([System.Net.IPEndPoint]$listener.LocalEndpoint).Port
            $state = Invoke-HcsFixtureProbe -TemplatePath $script:FabricProbe -Parameters @{
                DeviceKind = 'ConsoleServer'; DeviceName = 'fixture-console'
                ManagementAddress = '127.0.0.1'; ManagementPorts = "$port"; TimeoutSeconds = 5
            }
            $state.FabricDeviceState | Should -Be 'Good'
            $state.FabricDeviceManagementPort | Should -Be $port
        }
        finally { $listener.Stop() }
    }
}

Describe 'Fabric seed discovery' {

    BeforeAll {
        $script:SeedDiscovery = Join-Path $script:Fragments 'discovery/Discover-HyperVPrivateCloudFabricSeed.ps1.template'
    }

    It 'creates no fabric instances when no endpoints are declared' {
        $state = Invoke-HcsFixtureProbe -TemplatePath $script:SeedDiscovery -Parameters @{
            SourceId = '{00000000-0000-0000-0000-000000000000}'
            ManagedEntityId = '{00000000-0000-0000-0000-000000000000}'
            ComputerName = $env:COMPUTERNAME; BoundaryId = 'host:fixture'
        }
        # A chassis may still appear through the local IPMI fallback; no switch, firewall or console
        # server may be invented without a declaration.
        $state.HcsInstanceCount | Should -BeLessOrEqual 1
        $state.HcsEventLog | Should -BeNullOrEmpty
    }

    It 'creates an instance for every declared device' {
        $state = Invoke-HcsFixtureProbe -TemplatePath $script:SeedDiscovery -Parameters @{
            SourceId = '{00000000-0000-0000-0000-000000000000}'
            ManagedEntityId = '{00000000-0000-0000-0000-000000000000}'
            ComputerName = $env:COMPUTERNAME; BoundaryId = 'host:fixture'
            TopOfRackSwitches = 'LEAF-11=10.1.2.11,LEAF-12=10.1.2.12'
            EdgeFirewalls = 'lab-rtp-inf-fw=10.1.2.1'
            ConsoleServers = 'oob-console=10.1.2.50'
            OutOfBandSwitches = 'LAB-RTP-OOB-SW-H77=10.1.2.60'
        }
        # Two switches, one firewall, one console server and one OOB switch were declared.
        $state.HcsInstanceCount | Should -BeGreaterOrEqual 5
        $state.HcsEventLog | Should -BeNullOrEmpty
    }

    It 'ignores malformed seed entries instead of failing the whole discovery' {
        $state = Invoke-HcsFixtureProbe -TemplatePath $script:SeedDiscovery -Parameters @{
            SourceId = '{00000000-0000-0000-0000-000000000000}'
            ManagedEntityId = '{00000000-0000-0000-0000-000000000000}'
            ComputerName = $env:COMPUTERNAME; BoundaryId = 'host:fixture'
            TopOfRackSwitches = ',,  ,=10.0.0.1,GOOD-SWITCH=10.0.0.2,'
        }
        $state.HcsEventLog | Should -BeNullOrEmpty -Because 'a malformed entry must not throw'
    }
}
