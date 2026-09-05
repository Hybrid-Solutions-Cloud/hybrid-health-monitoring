---
title: ADR 0053 — Management pack review and runtime correctness
description: What a full line-by-line review of the thirteen Hyper-V Private Cloud packs found, why the shipped 1.0.0.0 could never have monitored a real host, and the design decisions taken while fixing it.
---

# ADR 0053 — Management pack review and runtime correctness

- **Status:** Accepted
- **Date:** 2026-08-31
- **Relates to:** [ADR 0047](0047-hyper-v-v2-explicit-powershell-7-execution.md) (PowerShell 7 command
  executor), [ADR 0051](0051-dependency-currency-and-platform-validation.md) (platform validation).

## Context

Before resealing the monitoring-depth build as `1.1.0.0`, every line of the thirteen packs — the
built XML, the templates, the generator and all 27 probe and discovery scripts — was reviewed
against the Management Pack schema, the Hyper-V PowerShell module (2.0.0.0, Server 2025), the
`pwsh -File` execution model the Library modules use, and Microsoft / Kevin Holman / MPAuthor
authoring guidance. Microsoft VSAE verification was run against every pack with a throwaway key.

The review found that the published `1.0.0.0` **could not have monitored a real host**. None of
the four causes is visible to XML well-formedness checks, XPath count tests, or VSAE; all four
only surface when a script runs on an agent:

1. **Non-existent property.** `$vmHost.HyperVVersion` is not a property of
   `Microsoft.HyperV.PowerShell.VMHost`. Under `Set-StrictMode -Version Latest` the access throws,
   so topology discovery failed on every host every 30 minutes (nothing beyond the registry seed
   was ever discovered — no VMs, no Distributed Application) and twelve host states went Critical.
2. **Non-existent type.** 20 of 27 scripts constructed the script API as the .NET type literal
   `[Microsoft.EnterpriseManagement.Mom.ScriptAPI]::new()`. The agent exposes that API only as the
   COM ProgID `MOM.ScriptAPI`; in a standalone `pwsh.exe` the type literal fails with "Unable to
   find type" before the first `try`, so every capability discovery, monitor and rule produced
   nothing.
3. **Unbindable parameters.** `pwsh -File` delivers every argument as a string, and a `[bool]`
   parameter rejects the strings `"true"`, `"True"`, `"1"` and `""` outright. Nine such parameters
   (Network ATC 6, Physical Network 2, VMM 1) killed those probes before line 1.
4. **Garbled names.** The generator split display names with a case-insensitive `-replace`, so
   every class property and relationship rendered as `B ou nd ar yI d` in 273 console strings.

Beyond those, the review recorded a long list of runtime defects (per-instance duplication of
cluster-wide facts, a quorum-margin default that was permanently Critical on every cluster of four
or fewer votes, CSV objects keyed differently from Microsoft's own pack, Dynamic Memory ratios
applied to static-memory VMs, live-migration alert storms, views that could never show the pack's
own data, and more) and design gaps (all seven Distributed Application branches mirroring one
availability aggregate, event views with no event rules, no product-wide alert scope).

## Decision

1. **Scripts target the agent as it is.** Every script uses `New-Object -ComObject 'MOM.ScriptAPI'`,
   declares boolean inputs as `[string]` and coerces them once, sets
   `$WarningPreference = 'SilentlyContinue'` and `-WarningAction SilentlyContinue` on module loads
   (Windows PowerShell compatibility warnings otherwise reach stdout ahead of the property bag), and
   never reads a Hyper-V object property whose existence was not verified. A unit test enforces the
   first three rules for every `*.ps1.template`.
2. **Superseded monitors ship disabled, never deleted.** `Host.Cpu`, `Host.Memory`, `Host.Paging`
   and `VmRuntime.MemoryPressure` evaluated thresholds inside the probe (an override splits
   cookdown) and duplicated the threshold-type depth monitors with different values. Their element
   IDs are part of the sealed `1.0.0.0` identity, so they remain with `Enabled="false"` and a
   knowledge note naming the superseding monitor. The same rule applies to the S2D media-error
   monitor and the two lifetime-maximum "latency" collection rules.
3. **Each Distributed Application branch rolls up its own domain.** Storage rolls up VM virtual-disk
   availability, latency and queue; Networking rolls up VM network connectivity and the SDN host
   binding; Availability rolls up expected state, heartbeat and Replica; Management rolls up VMMS,
   Host Compute and the hypervisor; Monitoring Pipeline rolls up probe and capability health;
   Compute and Virtual Machines roll up the whole host/VM aggregate. Every branch also rolls
   Performance and Configuration into the service. Roll-ups that point at a specific unit monitor
   use `MemberUnAvailable=Success` so disabling that monitor by override does not redden the branch;
   whole-aggregate roll-ups keep `Error` so an unreachable agent does.
4. **Event monitoring is first-party.** No Microsoft pack covers Hyper-V's own event channels, so the
   Monitoring pack collects Error/Critical/Warning events from the eight Hyper-V admin channels and
   alerts on verified failure signatures (live migration 21502/21501/21125, hypervisor not
   running 3112) plus level-based error rules per channel with suppression on event number and VM.
5. **One product-wide alert scope.** `HyperVPrivateCloud.Product.Group` is an instance group
   populated with every object contained by a Distributed Application; the Overview folder carries an
   "All Active Alerts" view targeted at it. Alert views scope by class, not containment, so this is
   the only way to see the whole product's alerts in one place.
6. **Discovery cadence.** Capability topology and relationship discoveries default to four hours.
   The core topology discovery stays at 30 minutes because virtual machine runtimes must follow live
   migration; that interval is the documented exception.
7. **Defaults that were wrong are corrected, and Standard tier follows them.** Quorum vote margin
   Warning 1 / Critical 0 (margin is votes that can still be lost); Node.Paused Warning 2;
   S2D VirtualDisk.Repair Warning 2; SDN error-event windows 5/25; NC endpoint count alerts only at
   zero. The tuning catalog's Standard tier equals the coded default by contract.

## Consequences

### Follow-up live validation for the 1.3.5.0 candidate

- Discovery must not submit empty singleton class instances. Use existing singleton objects as
  relationship endpoints; an otherwise valid discovery payload can be rejected as a whole.
- Cluster node-local CSV/quorum queries must omit the cluster network-name parameter. The
  corrected queries were executed through HealthService LocalSystem on active and passive nodes
  and a non-CSV management cluster. Windows PowerShell is used where those modules require it;
  the PowerShell 7 requirement applies to components that support that runtime.
- VMM host memory fields use different units: `TotalMemory` is bytes and `AvailableMemory` is
  MiB. Convert before calculating utilization, and do not invent usage from a missing value.
- An empty `LogicalNetworkMap` dictionary is not a virtual switch name. Ignore unused adapters
  without `VirtualNetwork`; continue detecting disconnected adapters with actual switch bindings.
- Corrected source probes under the SCOM Run As account eliminate the false memory/uplink
  conditions while retaining real quota and logical-network-site faults. These task results are
  source-runtime evidence, not proof that a new sealed product has been deployed.
- An isolated, host-monitored VM without a SCOM guest agent demonstrated availability fault and
  recovery and a disconnected-NIC warning, including the Networking dependency rollup. A blank
  firmware VM cannot establish successful guest heartbeat or guest-OS health.

The candidate still requires its exact sealed upgrade and post-upgrade certification evidence.

### Earlier releases

- All 13 packs pass Microsoft VSAE verification and seal; 135 unit tests pass, including the new
  script-hygiene and display-name tests. Total authored product: 162 unit monitors, 93 dependency
  monitors, 80 rules (62 performance, 8 event collection, 10 event alert), 20 discoveries, 111 views
  and 172 knowledge articles.
- The `1.0.0.0` download remains published as release evidence but is not fit for deployment; the
  next release supersedes it and the download page must say so.
- Closed in the follow-up release (1.3.0.0): **cluster-wide facts are evaluated once per cluster.**
  `HyperVPrivateCloud.Capability.Cluster.ClusterRole` is hosted by the cluster core virtual server
  (`Microsoft.Windows.Cluster.VirtualServer`), exactly as Microsoft's CSV and S2D packs host their
  cluster-scoped objects, so the 13 cluster-wide monitors, the two CSV capacity rules and the
  relationship discovery run on the node that owns the core group and fail over with it; only the
  node-local CSV latency/queue monitors stay on the host role. The original v1 storage availability
  monitors (`AttachmentAvailability`, `AttachmentRedundancy`, `IscsiSessionAvailability`,
  `FibreChannelPortAvailability`) ship disabled as superseded by the depth monitors, and the inert
  VLAN-mismatch monitor ships disabled with its reason. A 63-task operator catalogue and a probe
  smoke test were added in 1.2.0.0.
- Closed in 1.4.0.0: **host-wide facts are evaluated once per host.** The three storage event-count
  monitors (iSCSI connection errors, iSCSI authentication failures, MPIO path failovers) target the
  host role through a shared `HostEvents` monitor type whose three consumers carry identical data
  source configuration, so one probe run feeds all three (the events carry no session or disk
  attribution, so per-instance targeting had raised the same alert once per session and once per
  LUN). The Network ATC ETS and QoS traffic-class monitors likewise target the host role —
  `Get-NetQosTrafficClass` is host-global. The Physical Network link-state and link-speed monitors
  evaluate only external-vSwitch uplinks and Network ATC intent adapters by default (the
  `IncludeNonUplinkAdapters` override restores the old behaviour), so a dark port on a multi-port
  NIC no longer holds the host Warning forever. The File Services discovery no longer emits a
  Microsoft SMB service instance for the file servers it sees — that emission rejected the whole
  discovery batch (event 10801) whenever the file server's computer object was not in the
  management group, and created a phantom SMB service where it was; the reference now ships as a
  separate `MicrosoftSmbLink` discovery, disabled by default, for deployments whose SMB file
  servers are themselves SCOM-managed.
- Recorded but deliberately not changed yet (next major): per-instance probe fan-out (one
  `pwsh.exe` per VM / LUN / intent per interval) and thresholds evaluated in-script for the older
  capability monitors, which together defeat cookdown; and the Pure Storage scripts' dependence on
  the .NET Framework SCOM SDK under PowerShell 7.
- **Lesson recorded for the authoring standard:** a green Pester run and a clean VSAE seal prove the
  XML, not the product. Every probe must be executed at least once under `pwsh -File` with its
  literal `<Arguments>` before a release is cut; a probe smoke test that does this is the next test
  investment.
