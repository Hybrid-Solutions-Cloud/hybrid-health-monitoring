# Hyper-V Private Cloud Monitoring - Physical Network Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Collect physical adapter bytes received per second {#hypervprivatecloud.capability.physicalnetwork.adapterreceivedbytes.collection.rule}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterReceivedBytes.Collection.Rule`

Collects performance counter data for Collect physical adapter bytes received per second into Operations Manager databases.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterReceivedBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect physical adapter bytes sent per second {#hypervprivatecloud.capability.physicalnetwork.adaptersentbytes.collection.rule}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterSentBytes.Collection.Rule`

Collects performance counter data for Collect physical adapter bytes sent per second into Operations Manager databases.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterSentBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect physical adapter errors per second {#hypervprivatecloud.capability.physicalnetwork.adaptererrors.collection.rule}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterErrors.Collection.Rule`

Collects performance counter data for Collect physical adapter errors per second into Operations Manager databases.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterErrors.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect physical adapter discards per second {#hypervprivatecloud.capability.physicalnetwork.adapterdiscards.collection.rule}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterDiscards.Collection.Rule`

Collects performance counter data for Collect physical adapter discards per second into Operations Manager databases.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterDiscards.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect physical adapter link utilisation percent {#hypervprivatecloud.capability.physicalnetwork.adapterutilization.collection.rule}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterUtilization.Collection.Rule`

Collects performance counter data for Collect physical adapter link utilisation percent into Operations Manager databases.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect switch port utilisation percent {#hypervprivatecloud.capability.physicalnetwork.portutilization.collection.rule}

`HyperVPrivateCloud.Capability.PhysicalNetwork.PortUtilization.Collection.Rule`

Collects performance counter data for Collect switch port utilisation percent into Operations Manager databases.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.PortUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Show physical adapter inventory {#hypervprivatecloud.capability.physicalnetwork.adapterinventory.task}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterInventory.Task`

Adapters with status, link speed, duplex, driver provider/version/date, MTU, PCIe slot, RSS/VMQ/SR-IOV and jumbo-frame settings.

### Summary

Show physical adapter inventory

### What it runs

Adapters with status, link speed, duplex, driver provider/version/date, MTU, PCIe slot, RSS/VMQ/SR-IOV and jumbo-frame settings.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterInventory.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Show adapter error and discard counters {#hypervprivatecloud.capability.physicalnetwork.adaptererrors.task}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterErrors.Task`

Get-NetAdapterStatistics errors and discards plus Hyper-V virtual switch dropped-packet counters.

### Summary

Show adapter error and discard counters

### What it runs

Get-NetAdapterStatistics errors and discards plus Hyper-V virtual switch dropped-packet counters.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterErrors.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Show virtual switch uplinks and team members {#hypervprivatecloud.capability.physicalnetwork.switchuplinks.task}

`HyperVPrivateCloud.Capability.PhysicalNetwork.SwitchUplinks.Task`

External switches, SET team members, management OS team mappings and any legacy LBFO teams.

### Summary

Show virtual switch uplinks and team members

### What it runs

External switches, SET team members, management OS team mappings and any legacy LBFO teams.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.SwitchUplinks.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Discover Top-of-Rack switch LLDP and CDP neighbors {#hypervprivatecloud.capability.physicalnetwork.getlldpneighbor.task}

`HyperVPrivateCloud.Capability.PhysicalNetwork.GetLldpNeighbor.Task`

Discovers connected ToR switch port ID, chassis ID, and physical adapter DCB/LLDP advanced properties via CIM and driver queries.

### Summary

Discover Top-of-Rack switch LLDP and CDP neighbors

### What it runs

Discovers connected ToR switch port ID, chassis ID, and physical adapter DCB/LLDP advanced properties via CIM and driver queries.

### Impact

Read-only. Returns neighbor data without changing adapter settings.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.GetLldpNeighbor.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Show Priority Flow Control and RDMA pause counters {#hypervprivatecloud.capability.physicalnetwork.pfcetscounters.task}

`HyperVPrivateCloud.Capability.PhysicalNetwork.PfcEtsCounters.Task`

Queries RDMA Activity, PFC pause frames, DCB traffic classes, and QoS policy drop counters for deep network troubleshooting.

### Summary

Show Priority Flow Control and RDMA pause counters

### What it runs

Queries RDMA Activity, PFC pause frames, DCB traffic classes, and QoS policy drop counters for deep network troubleshooting.

### Impact

Read-only. Samples performance counters and QoS state without changing traffic policies.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.PfcEtsCounters.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Physical-network correlation input health {#hypervprivatecloud.capability.physicalnetwork.integrationhealth.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.IntegrationHealth.Monitor`

Validates the exact Windows adapter identities supplied to SCOM built-in MAC-based network topology correlation.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.IntegrationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that each external Hyper-V virtual switch uplink exposes the stable Windows adapter identity and MAC address used by SCOM network topology correlation.

### Operator response

Verify Hyper-V PowerShell management tools, physical adapter state, stable MAC addresses, and SCOM network discovery. Confirm that the built-in network diagram connects the Windows adapter to the expected switch port before relying on service-impact traversal.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.IntegrationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;PhysicalNetworkIntegrationState&#39;] = Good OR Property[@Name=&#39;PhysicalNetworkIntegrationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;PhysicalNetworkIntegrationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;PhysicalNetworkIntegrationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntervalSeconds=300; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

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


## Physical adapter link state {#hypervprivatecloud.capability.physicalnetwork.adapterlinkstate.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterLinkState.Monitor`

Monitors operational health, status, and thresholds for Physical adapter link state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterLinkState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Reads Get-NetAdapter for every physical adapter that is not disabled. An adapter that is not Up is Critical; an adapter that is Up with a disconnected media state is Warning.

### Operator response

Check the cable, transceiver, switch port state, adapter driver, and firmware. Disabled and not-present adapters are ignored.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterLinkState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AdapterLinkState&#39;] = Good OR Property[@Name=&#39;AdapterLinkState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;AdapterLinkState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;AdapterLinkState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IncludeNonUplinkAdapters=false; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=AdapterLinkState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Physical adapter link speed {#hypervprivatecloud.capability.physicalnetwork.adapterlinkspeed.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterLinkSpeed.Monitor`

Monitors operational health, status, and thresholds for Physical adapter link speed.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterLinkSpeed.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Compares the negotiated link speed of every Up physical adapter with MinimumLinkSpeedMbps, which defaults to 10000 Mbps.

### Operator response

Confirm the transceiver, cable grade, and switch port speed and duplex settings. Lower MinimumLinkSpeedMbps for hosts that legitimately use slower management adapters.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterLinkSpeed.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AdapterSpeedState&#39;] = Good OR Property[@Name=&#39;AdapterSpeedState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;AdapterSpeedState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;AdapterSpeedState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IncludeNonUplinkAdapters=false; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=AdapterSpeedState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Physical adapter error rate {#hypervprivatecloud.capability.physicalnetwork.adaptererrorrate.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterErrorRate.Monitor`

Monitors operational health, status, and thresholds for Physical adapter error rate.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterErrorRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Samples Get-NetAdapterStatistics twice, SampleSeconds apart, and derives inbound plus outbound packet errors per second. WarningErrorsPerSecond defaults to 1 and CriticalErrorsPerSecond defaults to 10.

### Operator response

Inspect the cable, transceiver, switch port counters, adapter firmware, and offload settings. Raise the thresholds only where a known and accepted error floor exists.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterErrorRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AdapterErrorsState&#39;] = Good OR Property[@Name=&#39;AdapterErrorsState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;AdapterErrorsState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;AdapterErrorsState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=AdapterErrorsState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Physical adapter discard rate {#hypervprivatecloud.capability.physicalnetwork.adapterdiscardrate.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterDiscardRate.Monitor`

Monitors operational health, status, and thresholds for Physical adapter discard rate.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterDiscardRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Samples Get-NetAdapterStatistics twice, SampleSeconds apart, and derives inbound plus outbound discarded packets per second. WarningDiscardsPerSecond defaults to 5 and CriticalDiscardsPerSecond defaults to 50.

### Operator response

Review receive buffers, RSS and VMQ configuration, flow control, switch port buffering, and offered load. Raise the thresholds only for accepted burst behaviour.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.AdapterDiscardRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AdapterDiscardsState&#39;] = Good OR Property[@Name=&#39;AdapterDiscardsState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;AdapterDiscardsState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;AdapterDiscardsState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=AdapterDiscardsState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Switch port operational state {#hypervprivatecloud.capability.physicalnetwork.switchportstate.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.SwitchPortState.Monitor`

Monitors operational health, status, and thresholds for Switch port operational state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.SwitchPortState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Evaluates the switch port that serves each external virtual switch uplink from the host side, and confirms LLDP neighbour data where Windows publishes it. Missing LLDP data is Warning only when RequireLldpCorrelation is overridden to true.

### Operator response

Confirm the switch port administrative and operational state, the cable and transceiver, and the LLDP agent on both ends. SCOM network discovery remains authoritative for the switch object itself.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.SwitchPortState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;SwitchPortState&#39;] = Good OR Property[@Name=&#39;SwitchPortState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;SwitchPortState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;SwitchPortState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=SwitchPortState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Port-to-adapter correlation {#hypervprivatecloud.capability.physicalnetwork.portcorrelation.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.PortCorrelation.Monitor`

Monitors operational health, status, and thresholds for Port-to-adapter correlation.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.PortCorrelation.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that every uplink exposes a unique MAC address and a stable device identifier, which are the facts SCOM MAC-based topology correlation uses to join a Windows adapter to a physical switch port.

### Operator response

Remove duplicate or randomised MAC addresses, restore a stable device identifier, and rerun SCOM network discovery so the built-in network diagram reconnects the adapter to its port.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.PortCorrelation.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;PortCorrelationState&#39;] = Good OR Property[@Name=&#39;PortCorrelationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;PortCorrelationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;PortCorrelationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=PortCorrelationState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Adapter and switch port VLAN match {#hypervprivatecloud.capability.physicalnetwork.vlanmismatch.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.VlanMismatch.Monitor`

Compares the VLAN configured on each uplink with the VLAN the switch port advertises. Disabled by default: Windows exposes no LLDP neighbour data (no MSFT_NetLldpNeighbor class), so the switch side cannot be read; enable only where a customer LLDP collector supplies that class.

### Summary

Compares the VLAN configured on each uplink adapter with the VLAN the switch port publishes through LLDP. Unavailable VLAN data is Warning only when RequireVlanMatch is overridden to true.

### Operator response

Align the host adapter VLAN with the switch port VLAN or trunk allow-list. Where LLDP does not publish a port VLAN, validate the VLAN by hand and leave RequireVlanMatch false.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.VlanMismatch.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VlanMismatchState&#39;] = Good OR Property[@Name=&#39;VlanMismatchState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VlanMismatchState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VlanMismatchState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=VlanMismatchState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Switch port utilisation {#hypervprivatecloud.capability.physicalnetwork.portutilization.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.PortUtilization.Monitor`

Monitors operational health, status, and thresholds for Switch port utilisation.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.PhysicalNetwork.PortUtilization.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Derives utilisation for each uplink port as sampled throughput over negotiated link speed. WarningUtilizationPercent defaults to 70 and CriticalUtilizationPercent defaults to 90.

### Operator response

Review workload placement, teaming and load-balancing mode, and uplink capacity. Add uplink bandwidth or rebalance traffic before the port saturates.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.PortUtilization.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;PortUtilizationState&#39;] = Good OR Property[@Name=&#39;PortUtilizationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;PortUtilizationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;PortUtilizationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalDiscardsPerSecond=50; CriticalErrorsPerSecond=10; CriticalUtilizationPercent=90; IntervalSeconds=300; MinimumLinkSpeedMbps=10000; PropertyName=PortUtilizationState; RequireLldpCorrelation=false; RequireVlanMatch=false; SampleSeconds=10; SyncTime=; TimeoutSeconds=180; WarningDiscardsPerSecond=5; WarningErrorsPerSecond=1; WarningUtilizationPercent=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Hyper-V host network-adapter health {#hypervprivatecloud.capability.physicalnetwork.networkadapter.dependency.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.NetworkAdapter.Dependency.Monitor`

Rolls physical network adapter health into the host network role.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.NetworkAdapter.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.PhysicalNetwork.NetworkComponentContainsComputerNetworkAdapter; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up physical uplink health into virtual switches {#hypervprivatecloud.capability.physicalnetwork.virtualswitchuplink.dependency.monitor}

`HyperVPrivateCloud.Capability.PhysicalNetwork.VirtualSwitchUplink.Dependency.Monitor`

Rolls physical uplink health into external Hyper-V virtual switches.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Capability.PhysicalNetwork.VirtualSwitchUplink.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.VirtualSwitch; relationship=HyperVPrivateCloud.Capability.PhysicalNetwork.VirtualSwitchUsesComputerNetworkAdapter; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Warning. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)
