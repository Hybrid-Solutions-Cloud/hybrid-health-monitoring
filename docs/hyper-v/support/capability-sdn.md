# Hyper-V Private Cloud Monitoring - Windows Server SDN Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Windows Server SDN host binding {#hypervprivatecloud.capability.sdn.hostbinding}

`HyperVPrivateCloud.Capability.SDN.HostBinding`

Association between a Hyper-V host and the SDN authority. Service, identity, control/data-plane and certificate monitors apply only to a genuinely detected binding.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostBinding. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=BindingId, BoundaryId, NetworkControllerHostId, NcHostAgentState, SlbHostAgentState. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### What this object represents

Association between a Hyper-V host and the SDN authority. Service, identity, control/data-plane and certificate monitors apply only to a genuinely detected binding.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Show SDN host agent status {#hypervprivatecloud.capability.sdn.hostagentstatus.task}

`HyperVPrivateCloud.Capability.SDN.HostAgentStatus.Task`

NC and SLB host agent services, host agent registry configuration, established connections owned by the agents and the VFP switch extension state.

### Summary

Show SDN host agent status

### What it runs

NC and SLB host agent services, host agent registry configuration, established connections owned by the agents and the VFP switch extension state.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostAgentStatus.Task. Kind: Task.

### Execution safety

Target=HyperVPrivateCloud.Capability.SDN.HostBinding; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Show SDN certificate status {#hypervprivatecloud.capability.sdn.certificatestatus.task}

`HyperVPrivateCloud.Capability.SDN.CertificateStatus.Task`

The certificates named by HostAgentCertificateCName / PeerCertificateCName with expiry, chain trust and private key presence.

### Summary

Show SDN certificate status

### What it runs

The certificates named by HostAgentCertificateCName / PeerCertificateCName with expiry, chain trust and private key presence.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.CertificateStatus.Task. Kind: Task.

### Execution safety

Target=HyperVPrivateCloud.Capability.SDN.HostBinding; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Show SDN host agent events {#hypervprivatecloud.capability.sdn.hostagentevents.task}

`HyperVPrivateCloud.Capability.SDN.HostAgentEvents.Task`

Latest Error/Warning events from the NC host agent, VFP extension and SLB channels. Parameter = events per channel (default 25).

### Summary

Show SDN host agent events

### What it runs

Latest Error/Warning events from the NC host agent, VFP extension and SLB channels. Parameter = events per channel (default 25).

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostAgentEvents.Task. Kind: Task.

### Execution safety

Target=HyperVPrivateCloud.Capability.SDN.HostBinding; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Remediation: Restart the SDN host agents {#hypervprivatecloud.capability.sdn.restarthostagents.task}

`HyperVPrivateCloud.Capability.SDN.RestartHostAgents.Task`

Restart-Service NcHostAgent and SlbHostAgent on this host. Never touches Network Controller.

### Summary

Restart the SDN host agents

### What it runs

Restart-Service NcHostAgent and SlbHostAgent on this host. Never touches Network Controller.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.RestartHostAgents.Task. Kind: Task.

### Execution safety

Target=HyperVPrivateCloud.Capability.SDN.HostBinding; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Windows Server SDN host integration health {#hypervprivatecloud.capability.sdn.integrationhealth.monitor}

`HyperVPrivateCloud.Capability.SDN.IntegrationHealth.Monitor`

Validates local Network Controller and optional SLB host-agent evidence without duplicating Microsoft SDN leaf alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.IntegrationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Validates the local Network Controller Host Agent identity and service, plus the optional Software Load Balancer Host Agent. Microsoft.Windows.10.SDNMonitoring remains authoritative for SDN resource discovery, leaf health, alerts, and performance.

### Operator response

Check the NcHostAgent and SlbHostAgent services, the NcHostAgent HostId registry value, and the matching Network Controller server InstanceId. Then follow the authoritative Microsoft SDN alert and troubleshooting guidance. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.IntegrationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SdnIntegrationState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;SdnIntegrationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;SdnIntegrationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntervalSeconds=300; RequireSDN=false; RequireSlbHostAgent=false; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Network Controller Host Agent service state {#hypervprivatecloud.capability.sdn.nchostagent.service.monitor}

`HyperVPrivateCloud.Capability.SDN.NcHostAgent.Service.Monitor`

Raises an error when the installed Network Controller Host Agent service is not running. WarningThreshold and CriticalThreshold both default to 1 and are overridable. A host where the service is not installed reports zero and never alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.NcHostAgent.Service.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The Network Controller Host Agent applies Network Controller policy to this host. When it is not running the host keeps its last programmed policy and stops receiving updates.

### Operator response

Confirm that the NcHostAgent service is set to start automatically and is running, review its recent service and system events, and confirm the host is still a member of the SDN fabric. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.NcHostAgent.Service.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NcHostAgentStoppedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;NcHostAgentStoppedCount&#39;] &gt;= 1 AND Property[@Name=&#39;NcHostAgentStoppedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;NcHostAgentStoppedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=NcHostAgentStoppedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Software Load Balancer Host Agent service state {#hypervprivatecloud.capability.sdn.slbhostagent.service.monitor}

`HyperVPrivateCloud.Capability.SDN.SlbHostAgent.Service.Monitor`

Raises an error when the installed Software Load Balancer Host Agent service is not running. WarningThreshold and CriticalThreshold both default to 1 and are overridable. A host where the service is not installed reports zero and never alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.SlbHostAgent.Service.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The Software Load Balancer Host Agent programs virtual IP and dynamic IP mappings on this host. When it is not running, load balanced traffic to workloads on this host can stop being programmed.

### Operator response

Confirm that the SlbHostAgent service is installed intentionally on this host, that it is set to start automatically, and that it is running. Review its recent service events, then follow the authoritative Microsoft SDN load balancer guidance. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.SlbHostAgent.Service.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SlbHostAgentStoppedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;SlbHostAgentStoppedCount&#39;] &gt;= 1 AND Property[@Name=&#39;SlbHostAgentStoppedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;SlbHostAgentStoppedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=SlbHostAgentStoppedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Network Controller Host Agent host identity {#hypervprivatecloud.capability.sdn.hostagent.hostid.monitor}

`HyperVPrivateCloud.Capability.SDN.HostAgent.HostId.Monitor`

Raises an error when an SDN host agent is installed but the NcHostAgent HostId registry value is missing or empty. WarningThreshold and CriticalThreshold both default to 1 and are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostAgent.HostId.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The HostId registry value binds this host to its Network Controller server record. Without it the host agent cannot be correlated with the Network Controller server InstanceId.

### Operator response

Inspect HKLM SYSTEM CurrentControlSet Services NcHostAgent Parameters HostId and confirm it matches the InstanceId of the corresponding Network Controller server record. Re-run host registration using the supported Microsoft procedure. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostAgent.HostId.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;HostIdMissingCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;HostIdMissingCount&#39;] &gt;= 1 AND Property[@Name=&#39;HostIdMissingCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;HostIdMissingCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=HostIdMissingCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Network Controller connection count {#hypervprivatecloud.capability.sdn.networkcontroller.connections.monitor}

`HyperVPrivateCloud.Capability.SDN.NetworkController.Connections.Monitor`

Raises a warning when the number of Network Controller endpoints recorded locally by the host agent falls to or below WarningThreshold (default 1) and an error at or below CriticalThreshold (default 0). Both thresholds are overridable. Where the platform does not record connections locally the measure reports a benign not-applicable value and never alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.NetworkController.Connections.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The host agent records the Network Controller endpoints it is configured to reach. Only ssl: entries are counted (the pssl: listener entry is not an endpoint). A host normally records exactly one Network Controller REST endpoint; zero means the host agent has no configured path to the control plane and cannot receive policy. The value is read locally and is never obtained by calling Network Controller REST.

### Operator response

Compare the locally recorded endpoints with the Network Controller REST endpoint set for this fabric, then re-run host registration using the supported Microsoft procedure if they disagree. Where a single-node control plane is intentional, override WarningThreshold to 0 on this host. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.NetworkController.Connections.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NetworkControllerConnectionCount&#39;] &gt; 0

Warning [Warning]: (Property[@Name=&#39;NetworkControllerConnectionCount&#39;] &lt;= 0 AND Property[@Name=&#39;NetworkControllerConnectionCount&#39;] &gt; 0)

Error [Critical]: Property[@Name=&#39;NetworkControllerConnectionCount&#39;] &lt;= 0

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=0; IntervalSeconds=300; PropertyName=NetworkControllerConnectionCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=0 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Network Controller Host Agent listener presence {#hypervprivatecloud.capability.sdn.hostagent.listener.monitor}

`HyperVPrivateCloud.Capability.SDN.HostAgent.Listener.Monitor`

Raises a warning when a running Network Controller Host Agent owns no listening TCP endpoint, that is when the count falls to or below WarningThreshold (default 0). CriticalThreshold defaults to -1 so the error state never fires until it is overridden. Both thresholds are overridable. Where the service is absent or stopped the measure reports a benign not-applicable value.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostAgent.Listener.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The Network Controller reaches the host agent over a listening TCP endpoint owned by the host agent process. A running host agent with no listening endpoint cannot receive policy, even though its service state looks healthy.

### Operator response

Confirm the host agent process is listening, check the host firewall rules for the SDN management ports, and verify no other component has claimed the port. Then follow the authoritative Microsoft SDN host agent troubleshooting guidance. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostAgent.Listener.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;OvsdbListenerCount&#39;] &gt; 0

Warning [Warning]: (Property[@Name=&#39;OvsdbListenerCount&#39;] &lt;= 0 AND Property[@Name=&#39;OvsdbListenerCount&#39;] &gt; -1)

Error [Critical]: Property[@Name=&#39;OvsdbListenerCount&#39;] &lt;= -1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=-1; IntervalSeconds=300; PropertyName=OvsdbListenerCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=0 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Local Network Controller service state {#hypervprivatecloud.capability.sdn.networkcontroller.service.monitor}

`HyperVPrivateCloud.Capability.SDN.NetworkController.Service.Monitor`

Raises an error when a Network Controller service installed on this computer is not running. WarningThreshold and CriticalThreshold both default to 1 and are overridable. A computer that is not a Network Controller node reports zero and never alerts. The monitor observes whichever Network Controller services are present and makes no assumption about the hosting model.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.NetworkController.Service.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Windows Server 2019 and 2022 host the Network Controller as a Service Fabric role, and Windows Server 2025 hosts it as a Failover Clustering service on the node. This monitor reports whichever Network Controller services exist locally and are not running, without asserting either shape.

### Operator response

Confirm this computer is intended to be a Network Controller node, then check the service state, the cluster or Service Fabric role that owns it, and the node certificate. Microsoft.Windows.10.SDNMonitoring remains the authority for Network Controller cluster node health. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.NetworkController.Service.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NetworkControllerServiceStoppedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;NetworkControllerServiceStoppedCount&#39;] &gt;= 1 AND Property[@Name=&#39;NetworkControllerServiceStoppedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;NetworkControllerServiceStoppedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=NetworkControllerServiceStoppedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Network Controller Host Agent recent restart {#hypervprivatecloud.capability.sdn.hostagent.uptime.monitor}

`HyperVPrivateCloud.Capability.SDN.HostAgent.Uptime.Monitor`

Raises a warning when the running Network Controller Host Agent process has been up for WarningThreshold minutes or fewer (default 15) and an error at or below CriticalThreshold minutes (default 5). Both thresholds are overridable. Where the process start time cannot be read the measure reports a benign not-applicable value.

### Summary

A host agent that restarts repeatedly reprograms host policy each time and can produce intermittent data plane loss that no single service state check catches.

### Operator response

Correlate the restart with service control manager events, host agent crash events, and any recent SDN configuration change. A single restart after planned maintenance is expected. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostAgent.Uptime.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NcHostAgentUptimeMinutes&#39;] &gt; 15

Warning [Warning]: (Property[@Name=&#39;NcHostAgentUptimeMinutes&#39;] &lt;= 15 AND Property[@Name=&#39;NcHostAgentUptimeMinutes&#39;] &gt; 5)

Error [Critical]: Property[@Name=&#39;NcHostAgentUptimeMinutes&#39;] &lt;= 5

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=5; IntervalSeconds=300; PropertyName=NcHostAgentUptimeMinutes; SyncTime=; TimeoutSeconds=120; WarningThreshold=15 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## SDN certificate expiry warning window {#hypervprivatecloud.capability.sdn.certificate.expiry.monitor}

`HyperVPrivateCloud.Capability.SDN.Certificate.Expiry.Monitor`

Raises a warning when the soonest expiring SDN candidate certificate in the local computer personal store has WarningThreshold days or fewer remaining (default 30) and an error at or below CriticalThreshold days (default 14). Both thresholds are overridable. Where no candidate certificate is found the measure reports a benign value and never alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.Certificate.Expiry.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

SDN authenticates the host agent, the Network Controller REST endpoint, and the southbound channel with certificates. A candidate certificate is a local computer personal store entry whose subject or subject alternative name matches this computer. Expiry breaks the SDN trust chain outright.

### Operator response

Identify the expiring certificate from the alert context, renew it using the supported Microsoft SDN certificate procedure, and confirm the Network Controller and every host trust the replacement before the current one expires. This workflow performs no remediation and never renews a certificate.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Certificate.Expiry.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.SecurityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SdnCertificateDaysToExpiry&#39;] &gt; 30

Warning [Warning]: (Property[@Name=&#39;SdnCertificateDaysToExpiry&#39;] &lt;= 30 AND Property[@Name=&#39;SdnCertificateDaysToExpiry&#39;] &gt; 14)

Error [Critical]: Property[@Name=&#39;SdnCertificateDaysToExpiry&#39;] &lt;= 14

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=14; IntervalSeconds=300; PropertyName=SdnCertificateDaysToExpiry; SyncTime=; TimeoutSeconds=120; WarningThreshold=30 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Expired SDN certificate present {#hypervprivatecloud.capability.sdn.certificate.expired.monitor}

`HyperVPrivateCloud.Capability.SDN.Certificate.Expired.Monitor`

Raises an error when one or more SDN candidate certificates in the local computer personal store have already expired. WarningThreshold and CriticalThreshold both default to 1 and are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.Certificate.Expired.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

An expired certificate that matches this computer is still presented by whichever component selects it, and the SDN trust chain fails at that point.

### Operator response

Remove or replace the expired certificate using the supported Microsoft SDN certificate procedure, then confirm the component that used it now presents the current certificate. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Certificate.Expired.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.SecurityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SdnCertificateExpiredCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;SdnCertificateExpiredCount&#39;] &gt;= 1 AND Property[@Name=&#39;SdnCertificateExpiredCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;SdnCertificateExpiredCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=SdnCertificateExpiredCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## SDN certificate chain trust {#hypervprivatecloud.capability.sdn.certificate.trust.monitor}

`HyperVPrivateCloud.Capability.SDN.Certificate.Trust.Monitor`

Raises a warning when an unexpired SDN candidate certificate fails local chain validation, that is when the count reaches WarningThreshold (default 1). CriticalThreshold defaults to 99999 so the error state never fires until it is overridden. Both thresholds are overridable. A self-signed SDN certificate that has not been imported into the local Trusted Root store reports as untrusted by design.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.Certificate.Trust.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

SDN deployments frequently use self-signed certificates that must be imported into the Trusted Root store of every participating node. A certificate whose chain does not build locally will not be trusted by the peer that validates it.

### Operator response

Confirm whether the certificate is expected to be self-signed. If it is, import it into the Trusted Root Certification Authorities store of every Network Controller node and SDN host as Microsoft documents. If it is issued by a certification authority, confirm the intermediate and root certificates are present. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Certificate.Trust.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.SecurityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SdnCertificateUntrustedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;SdnCertificateUntrustedCount&#39;] &gt;= 1 AND Property[@Name=&#39;SdnCertificateUntrustedCount&#39;] &lt; 99999)

Error [Critical]: Property[@Name=&#39;SdnCertificateUntrustedCount&#39;] &gt;= 99999

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=99999; IntervalSeconds=300; PropertyName=SdnCertificateUntrustedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Virtual filtering platform switch extension state {#hypervprivatecloud.capability.sdn.dataplane.vfpextension.monitor}

`HyperVPrivateCloud.Capability.SDN.DataPlane.VfpExtension.Monitor`

Raises an error when a virtual filtering platform switch extension is present on a virtual switch but disabled. WarningThreshold and CriticalThreshold both default to 1 and are overridable. A host with no such extension, or without the Hyper-V module, reports zero and never alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.DataPlane.VfpExtension.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The virtual filtering platform switch extension enforces the SDN data plane on this host. A disabled extension silently bypasses virtual network isolation, access control lists, and load balancer programming for every workload on that switch.

### Operator response

Confirm the extension is expected on the switch, re-enable it using the supported Hyper-V procedure, and verify virtual network and access control list enforcement afterwards. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.DataPlane.VfpExtension.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;VfpExtensionDisabledCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;VfpExtensionDisabledCount&#39;] &gt;= 1 AND Property[@Name=&#39;VfpExtensionDisabledCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;VfpExtensionDisabledCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=VfpExtensionDisabledCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## SDN control plane error events {#hypervprivatecloud.capability.sdn.controlplane.errorevents.monitor}

`HyperVPrivateCloud.Capability.SDN.ControlPlane.ErrorEvents.Monitor`

Raises a warning when SDN control plane channels record WarningThreshold or more error and critical events in the sampling window (default 1 event) and an error at CriticalThreshold or more (default 10). Both thresholds are overridable. The window is 60 minutes. A host with no SDN event channels reports zero and never alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.ControlPlane.ErrorEvents.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts error and critical events raised in the last 60 minutes by the Network Controller, Network Controller Host Agent, and Software Load Balancer Host Agent event channels present on this computer. This is a volume signal, not a duplicate of any Microsoft leaf alert.

### Operator response

Open the named channels for the sampling window, identify the repeating event, and follow the authoritative Microsoft SDN guidance for it. Cross-check the Microsoft SDN alerts already raised against the affected objects before acting on this count. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.ControlPlane.ErrorEvents.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SdnControlPlaneErrorEventCount&#39;] &lt; 5

Warning [Warning]: (Property[@Name=&#39;SdnControlPlaneErrorEventCount&#39;] &gt;= 5 AND Property[@Name=&#39;SdnControlPlaneErrorEventCount&#39;] &lt; 25)

Error [Critical]: Property[@Name=&#39;SdnControlPlaneErrorEventCount&#39;] &gt;= 25

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=25; IntervalSeconds=300; PropertyName=SdnControlPlaneErrorEventCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=5 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## SDN data plane error events {#hypervprivatecloud.capability.sdn.dataplane.errorevents.monitor}

`HyperVPrivateCloud.Capability.SDN.DataPlane.ErrorEvents.Monitor`

Raises a warning when SDN data plane channels record WarningThreshold or more error and critical events in the sampling window (default 1 event) and an error at CriticalThreshold or more (default 10). Both thresholds are overridable. The window is 60 minutes. A host with no such channels reports zero and never alerts.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.DataPlane.ErrorEvents.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts error and critical events raised in the last 60 minutes by the virtual filtering platform channels present on this computer. Sustained data plane errors accompany packet loss that the control plane reports as healthy.

### Operator response

Open the named channels for the sampling window, correlate the events with virtual switch and physical uplink state, and follow the authoritative Microsoft SDN data plane guidance. This workflow performs no remediation.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.DataPlane.ErrorEvents.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SdnDataPlaneErrorEventCount&#39;] &lt; 5

Warning [Warning]: (Property[@Name=&#39;SdnDataPlaneErrorEventCount&#39;] &gt;= 5 AND Property[@Name=&#39;SdnDataPlaneErrorEventCount&#39;] &lt; 25)

Error [Critical]: Property[@Name=&#39;SdnDataPlaneErrorEventCount&#39;] &gt;= 25

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=25; IntervalSeconds=300; PropertyName=SdnDataPlaneErrorEventCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=5 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Windows Server SDN host depth probe health {#hypervprivatecloud.capability.sdn.hostdepth.pipeline.monitor}

`HyperVPrivateCloud.Capability.SDN.HostDepth.Pipeline.Monitor`

Tracks completion of the shared read-only SDN host depth probe. Warning means one or more evidence sources were unreadable and their measures reported a benign sentinel value; error means the probe itself failed and no depth measure is current.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.SDN.HostDepth.Pipeline.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks completion of the shared read-only SDN host depth probe on this host. The probe reads local service, registry, listener, certificate, virtual switch extension, and event channel evidence only. It never calls Network Controller REST and never remediates.

### Operator response

Read the alert context for the list of unreadable evidence sources. Verify that the HealthService account can read the local certificate store, the service control manager, the Hyper-V module, and the SDN event channels, then review Operations Manager event 8201 and the workflow timeout. Measures fed by an unreadable source report a benign sentinel value and will not alert until the source is readable again.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostDepth.Pipeline.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.SDN.HostBinding. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SdnHostDepthState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;SdnHostDepthState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;SdnHostDepthState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntervalSeconds=300; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up Network Controller certificate security {#hypervprivatecloud.capability.sdn.networkcontrollergroup.security.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.NetworkControllerGroup.Security.Dependency.Monitor`

Rolls up the health of member Roll up Network Controller certificate security objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.NetworkControllerGroup.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=SDN!SDNMonitoringMP.SDNMonitoring.NetworkControllerClusterNodeGroup; relationship=SDN!SDNMonitoringMP.SDNMonitoring.NetworkControllerClusterNodeGroupHostsNetworkControllerClusterNode; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Warning. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up Network Controller availability {#hypervprivatecloud.capability.sdn.management.controller.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Management.Controller.Availability.Dependency.Monitor`

Rolls up the health of member Roll up Network Controller availability objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Management.Controller.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.SDN.ManagementContainsNetworkControllerGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up Network Controller configuration {#hypervprivatecloud.capability.sdn.management.controller.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Management.Controller.Configuration.Dependency.Monitor`

Rolls up the health of member Roll up Network Controller configuration objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Management.Controller.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.SDN.ManagementContainsNetworkControllerGroup; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up Network Controller performance {#hypervprivatecloud.capability.sdn.management.controller.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Management.Controller.Performance.Dependency.Monitor`

Rolls up the health of member Roll up Network Controller performance objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Management.Controller.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.SDN.ManagementContainsNetworkControllerGroup; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up Network Controller security {#hypervprivatecloud.capability.sdn.management.controller.security.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Management.Controller.Security.Dependency.Monitor`

Rolls up the health of member Roll up Network Controller security objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Management.Controller.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.SDN.ManagementContainsNetworkControllerGroup; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up SDN host availability {#hypervprivatecloud.capability.sdn.network.hosts.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Network.Hosts.Availability.Dependency.Monitor`

Rolls up the health of member Roll up SDN host availability objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Network.Hosts.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsHostGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up virtual network availability {#hypervprivatecloud.capability.sdn.network.virtualnetworks.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Network.VirtualNetworks.Availability.Dependency.Monitor`

Rolls up the health of member Roll up virtual network availability objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Network.VirtualNetworks.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsVirtualNetworkGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up access control list availability {#hypervprivatecloud.capability.sdn.network.accesscontrollists.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Network.AccessControlLists.Availability.Dependency.Monitor`

Rolls up the health of member Roll up access control list availability objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Network.AccessControlLists.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsAccessControlListGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up SDN network interface availability {#hypervprivatecloud.capability.sdn.network.interfaces.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Network.Interfaces.Availability.Dependency.Monitor`

Rolls up the health of member Roll up SDN network interface availability objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Network.Interfaces.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsNetworkInterfaceGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up load balancer MUX availability {#hypervprivatecloud.capability.sdn.network.loadbalancermuxes.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Network.LoadBalancerMuxes.Availability.Dependency.Monitor`

Rolls up the health of member Roll up load balancer MUX availability objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Network.LoadBalancerMuxes.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsLoadBalancerMuxGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up SDN gateway availability {#hypervprivatecloud.capability.sdn.network.gateways.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.Network.Gateways.Availability.Dependency.Monitor`

Rolls up the health of member Roll up SDN gateway availability objects into the parent entity.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.Network.Gateways.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsGatewayPoolGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up SDN host binding availability into Networking {#hypervprivatecloud.capability.sdn.hostbinding.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor`

Rolls the availability state of the host-side SDN binding (host agents, certificates, VFP, control-plane events) into the Networking branch of the Distributed Application.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostBinding.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsHostBinding; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up SDN host binding configuration into Networking {#hypervprivatecloud.capability.sdn.hostbinding.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.HostBinding.Configuration.Dependency.Monitor`

Rolls the configuration state of the host-side SDN binding (host agents, certificates, VFP, control-plane events) into the Networking branch of the Distributed Application.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostBinding.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsHostBinding; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up SDN host binding security into Networking {#hypervprivatecloud.capability.sdn.hostbinding.security.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.HostBinding.Security.Dependency.Monitor`

Rolls the security state of the host-side SDN binding (host agents, certificates, VFP, control-plane events) into the Networking branch of the Distributed Application.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostBinding.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsHostBinding; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)


## Roll up SDN host binding performance into Networking {#hypervprivatecloud.capability.sdn.hostbinding.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.SDN.HostBinding.Performance.Dependency.Monitor`

Rolls the performance state of the host-side SDN binding (host agents, certificates, VFP, control-plane events) into the Networking branch of the Distributed Application.

### Support scope

Software-defined networking control-plane, host binding, data-plane and certificate evidence. Control-plane failure does not prove every existing tenant flow has failed.

Element: HyperVPrivateCloud.Capability.SDN.HostBinding.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.SDN.NetworkContainsHostBinding; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the controller, host and tenant path involved. Inspect the reported service, host identifier, listener, controller connectivity and VFP extension before changing anything. For certificates, record subject, issuer, validity, chain and intended binding without exporting private keys. Correlate policy/configuration errors with the native controller and host logs.

### Corrective action and escalation

Correct the specific controller/host policy, connectivity or certificate binding through the SDN authority. Renew certificates before expiry using the deployment-specific procedure. Do not disable certificate validation, remove VFP extensions or restart the entire controller cluster as a generic fix.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm controller and host agreement, trusted unexpired certificates, cessation of fresh errors and a representative tenant-path test. Follow Security health through the DA separately from availability.

### Microsoft references

[Microsoft Learn: troubleshoot sdn guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-sdn-guidance)

[Microsoft Learn: troubleshoot windows server software defined networking stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)
