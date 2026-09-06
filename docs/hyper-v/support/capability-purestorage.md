# Hyper-V Private Cloud Monitoring - Pure Storage Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Pure Storage correlation health {#hypervprivatecloud.capability.purestorage.integrationhealth.monitor}

`HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor`

Verifies exact IQN, WWPN, and serial correlations without duplicating array monitoring.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PureStorage.Array.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies read-only Pure-to-Windows correlation coverage. Pure&#39;s Management Pack remains the array leaf-alert authority.

### Operator response

Validate the Operations Manager SDK path, HCS Storage discovery, Pure host IQN/WWN values, Windows initiators, and Pure volume serials. Review event 8603.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: Pure!PureStorage.FlashArray.PureArray. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;PureIntegrationState&#39;] = Good OR Property[@Name=&#39;PureIntegrationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;PureIntegrationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;PureIntegrationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ArrayId=$Target/Property[Type=&quot;Pure!PureStorage.FlashArray.PureArray&quot;]/ArrayId$; IntervalSeconds=900; SyncTime=; TimeoutSeconds=300 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Read the first probe error and Operations Manager event context. Verify HealthService availability, supported PowerShell runtime, required modules, Run As scope and agent proxy where cross-object discovery requires it. Compare last successful sample and discovery time.

### Corrective action and escalation

Correct the missing runtime/module, access or source defect. Preserve logs before any approved HealthService restart. Do not reset health or clear the agent cache as a substitute for understanding a repeatable script error.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Require a new successful discovery/sample and initialized leaf monitors. Old green values cannot establish recovery of a broken collector.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Pure array health {#hypervprivatecloud.capability.purestorage.array.dependency.monitor}

`HyperVPrivateCloud.Capability.PureStorage.Array.Dependency.Monitor`

Rolls the health of Pure array health into the parent component of the private cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PureStorage.Array.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.PureStorage.StorageContainsPureArray; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Pure port health {#hypervprivatecloud.capability.purestorage.port.dependency.monitor}

`HyperVPrivateCloud.Capability.PureStorage.Port.Dependency.Monitor`

Rolls the health of Pure port health into the parent component of the private cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PureStorage.Port.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.PureStorage.StorageContainsPurePort; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Pure host health {#hypervprivatecloud.capability.purestorage.host.dependency.monitor}

`HyperVPrivateCloud.Capability.PureStorage.Host.Dependency.Monitor`

Rolls the health of Pure host health into the parent component of the private cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PureStorage.Host.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.HostRole; relationship=HyperVPrivateCloud.Capability.PureStorage.HostRoleReferencesPureHost; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Pure volume health {#hypervprivatecloud.capability.purestorage.volume.dependency.monitor}

`HyperVPrivateCloud.Capability.PureStorage.Volume.Dependency.Monitor`

Rolls the health of Pure volume health into the parent component of the private cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PureStorage.Volume.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Storage!HyperVPrivateCloud.Capability.Storage.LogicalUnit; relationship=HyperVPrivateCloud.Capability.PureStorage.LogicalUnitReferencesPureVolume; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Configuration through PureStorage.StorageContainsPureArray {#hypervprivatecloud.capability.purestorage.array.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.PureStorage.Array.Configuration.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PureStorage.Array.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.PureStorage.StorageContainsPureArray; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)
