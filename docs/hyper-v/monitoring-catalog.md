---
title: Hyper-V monitoring catalog policy
description: Research schema, prioritization policy, and threshold principles for the Hyper-V SCOM Management Pack.
---

# Hyper-V monitoring catalog policy

This page is both the phase-one signal policy and the development implementation catalog. The
authored catalog below is complete for the first functional build. The broader candidate inventory
remains open because “technically observable” is intentionally larger than “safe to enable by
default.” Lab evidence can still change defaults before a signed release.

## Authored coverage — Hyper-V Private Cloud Monitoring (development for the next release)

Counts below are read from the built packs on 2026-08-31 after the full pack review
([ADR 0053](../design/decisions/0053-management-pack-review-and-runtime-correctness.md)). Every unit
monitor and every alerting rule carries a knowledge article; every threshold is an overridable
parameter; monitors marked *disabled* stay in the pack for identity stability and are documented as
superseded.

| Pack | Unit monitors | Dependency roll-ups | Rules | Discoveries | Views |
|---|---|---|---|---|---|
| Monitoring (host + per-VM) | 39 (4 disabled, superseded) | 39 | 42 (24 performance, 8 event collection, 10 event alert) | — | — |
| Discovery / Library / Presentation | — | — | — | 3 | 18 |
| Capability.Storage (SAN, FC, iSCSI, MPIO) | 25 (5 disabled: 1 by design, 4 superseded) | 4 | 7 | 1 | 6 |
| Capability.Cluster (Failover Clustering, CSV) | 16 (13 once per cluster) | 8 | 5 | 2 | 8 |
| Capability.S2D | 16 (1 disabled) | 7 | 5 (2 disabled) | 7 | 11 |
| Capability.NetworkATC | 16 | 4 | 0 | 1 | 7 |
| Capability.SDN (host side only) | 15 (1 disabled) | 15 | 0 | 1 | 16 |
| Capability.VMM | 13 | 10 | 6 | 3 | 20 |
| Capability.FileServices (SMB / SOFS) | 12 | 3 | 9 | 2 | 7 |
| Capability.PhysicalNetwork | 9 (1 disabled, no LLDP data) | 2 | 6 | 1 | 8 |
| Capability.PureStorage | 1 | 4 | 0 | 1 | 11 |
| **Total** | **162** | **96** | **80** | **22** | **112** |

The Distributed Application (`HyperVPrivateCloud.Service`, one per cluster or standalone host) has
seven branches. Each branch rolls up the monitors of its own domain — Storage carries VM virtual-disk
availability, latency and queue plus SAN, S2D, SMB and Pure objects; Networking carries VM network
connectivity, virtual switches, physical adapters, Network ATC intents and the SDN host binding;
Availability carries expected state, heartbeat, Replica and the cluster objects; Management carries
VMMS, Host Compute, the hypervisor and VMM; Monitoring Pipeline carries probe and capability health —
and every branch rolls Availability, Performance and Configuration into the service. The
`Hyper-V Private Cloud Objects` group contains everything inside any Distributed Application and
backs the **All Active Alerts** view.

Cluster-wide facts are evaluated **once per cluster**, not once per node: the 13 cluster-scoped
monitors (CSV state, free space, redirected access, quorum, node state, network state, group
failures), the two CSV capacity rules and the relationship discovery target
`HyperVPrivateCloud.Capability.Cluster.ClusterRole`, hosted by the cluster core virtual server so the
workflows run on the node that owns the core group and fail over with it. Only the node-local CSV
latency and queue-depth monitors stay on the per-host role. This needs agent proxy on every cluster
node, as Microsoft's Cluster pack already does.

Host-wide facts are evaluated **once per host**: the storage iSCSI/MPIO event-count monitors and the
Network ATC ETS/QoS monitors target the host role (one probe run, one alert), the Physical Network
link monitors watch only vSwitch-uplink and intent adapters by default, and the File Services link
to Microsoft's SMB service objects is an opt-in discovery (`MicrosoftSmbLink`, disabled by default)
because it requires every SMB file server to be SCOM-managed.

### Operator tasks

Every pack carries a task runner (one PowerShell 7 script per capability, `-Action` selects the
task) so operators can diagnose and, where labelled **Remediation**, act from the console without
leaving SCOM. Read-only tasks change nothing; remediation tasks are separate elements the console
confirms before running, and their knowledge states the blast radius. `Parameter` is overridable at
run time where a task needs a name (VM, CSV, node, virtual disk, target IQN, intent).

| Target | Read-only | Remediation |
|---|---|---|
| Hyper-V host | VM inventory · host headroom · Hyper-V event tail · live-migration settings and recent migrations · virtual switch / SET / uplink configuration · pending reboot · monitoring pipeline self-test · Hyper-V BPA · diagnostic summary | restart VMMS · restart Host Compute Service |
| Virtual machine | detail (config, integration services, vNICs, VHD chain, checkpoints) · performance snapshot · Replica status | start · shut down · save · resume · restart · merge checkpoints · create checkpoint · resume replication · live migrate to best node |
| Failover cluster | cluster summary (quorum, nodes, networks, roles, CSV state) · cluster log · validate network/S2D | move CSV coordinator · drain node · resume node · clear quarantine · start cluster role |
| Storage Spaces Direct | health report and faults · storage jobs · disk reliability counters · capacity | repair virtual disk · retire physical disk · storage maintenance mode on/off · reattach detached virtual disk |
| SAN (FC / iSCSI / MPIO) | MPIO path report · iSCSI initiator report · Fibre Channel port report · SAN disks and latency | rescan storage · reconnect iSCSI target |
| SMB / SOFS | SMB client and share report · SMB latency and connectivity events | — |
| Network ATC | intent status · RDMA / DCB / SMB Direct health | retry intent on this node |
| Physical network | adapter inventory · adapter errors and discards · switch uplinks and team members | — |
| VMM | failed jobs · host status · agent versions · library status | refresh host in VMM |
| SDN host binding | host agent status · certificate status · host agent events | restart host agents |
| Console tasks | Remote Desktop to host · Hyper-V Manager · Failover Cluster Manager · VM Connect | — |

Two recoveries ship **disabled** (restart VMMS when its monitor is critical; resume a paused VM when
the expected-state monitor is critical) and one diagnostic runs automatically (VM health detail on
expected-state failure).

Known limitations carried into the next major release are listed in ADR 0053: per-instance probe
fan-out and in-script thresholds in the older capability monitors (cookdown), host-wide facts still
evaluated per LUN/session/intent in the Storage and Network ATC packs, and the inert VLAN-mismatch
monitor.

## Superseded baseline catalog (`HybridSolutionsCloud.HyperV`)

All nine stateful monitors target the discovered Hyper-V host role and share one parameter-identical
probe for SCOM cookdown. Their alerts auto-resolve. `NotApplicable` is healthy only for explicitly
inapplicable topology, such as CSV on a standalone host or Network ATC where another network
authority is selected.

| Monitor | Dimension | Default | Starting policy |
|---|---|---|---|
| VMMS service | Availability | On | Critical when `vmms` is not running |
| Failover-cluster node membership | Availability | On | Critical when any cluster node is not Up; N/A on standalone hosts |
| Expected VM state | Availability | On | Critical when an automatic-start VM is unexpectedly stopped or failed |
| Hyper-V Replica | Availability | On | Worst reported Replica health; warning does not become critical |
| Network ATC intent | Configuration | On | Critical for unsuccessful required host intent; N/A where Network ATC is not selected for that host group, including manual or VMM-owned host configuration |
| Available host memory | Performance | On | 4096 MB warning, 2048 MB critical; absolute reserve, not percent used |
| Hypervisor processor | Performance | On | 80% warning, 90% critical |
| CSV health and capacity | Availability | On | Offline/redirected is critical; 15%/10% free-space bands |
| Monitoring pipeline | Availability | On | Critical when the shared probe fails or returns invalid data |

The Monitoring MP also provides ten non-alerting dependency monitors. They roll host state into
Compute, Virtual Machines, Storage, Network, and Monitoring Pipeline components and then roll each
component into the platform-owned Hyper-V service Distributed Application.

| Performance collection | Default |
|---|---|
| Hyper-V logical processor total run time; host available memory; Dynamic Memory balancer available memory; memory pages input/sec; physical network bytes/sec; physical-disk read/write latency | On |
| Per-VM virtual processor, root virtual processor, virtual-network-adapter bytes/sec, and physical-disk read/write queue length | Off because these are high-cardinality or topology-sensitive |

Four enabled event rules cover Failover Clustering events 5120 and 5142 for CSV access loss, event
1135 for node removal, and events 1069/1205 for resource or role failure. A read-only diagnostic
task returns host, VM, switch, and Replica summary data. Ten views cover service health, host and
object inventory, alerts, performance, and events.

::: warning Earlier baseline defaults
These values describe the superseded `HybridSolutionsCloud.HyperV` baseline, not the current product.
For Hyper-V Private Cloud Monitoring, use the release manifest and the explicit
`src/hyper-v/scom-mp/v2/templates/overrides/tuning-catalog.json` contract. All defaults remain
overrideable and require representative operator validation before production enablement.
:::

## Required coverage

| Domain | Candidate coverage |
|---|---|
| Platform and topology | OS and role version, host identity, standalone/cluster membership, VM ownership, entity keys, and relationships |
| Host availability | Computer/agent reachability, Hyper-V services, Cluster service where applicable, role and feature state, restart/reboot state |
| CPU and scheduler | Hypervisor logical/root/virtual processor runtime, guest/hypervisor split, dispatch/wait behavior, interrupts, DPC, NUMA, and allocation configuration |
| Memory | Host available memory, root reserve, committed memory, paging, dynamic-memory balancer state, VM assigned/demand/pressure, and NUMA compatibility |
| VM health | State, status, heartbeat/integration services, configuration, generation/version, automatic actions, checkpoints, uptime, and critical events |
| Failover Cluster | Cluster and node state, quorum/witness, groups, resources, clustered VM roles, ownership, failover behavior, networks, and validation findings |
| CSV | State, pause, redirected I/O, ownership, free space, I/O latency/throughput/errors, cache use, and relevant events |
| Storage | Physical/logical volumes, SMB/SAN/virtual FC where applicable, VHD/VHDX metadata, capacity, latency, queues, errors, fragmentation, QoS, and differencing chains |
| Networking | Layered physical, host-intent, virtualization, and overlay monitoring: Network ATC intent/status/drift where supported; physical adapters, teams/SET, virtual switches, extensions, ports, VM adapters, VLAN/QoS, VMQ, vRSS, SR-IOV, bandwidth, queues, errors, and drops; VMM orchestration and SDN policy/topology where present |
| Mobility | Live migration, storage migration, drain, placement, compatibility, authentication, duration, throughput, and failure events |
| Replica and recovery | Replication state/health, lag, frequency, errors, relationship, last successful replication, and RPO policy |
| Configuration and reliability | Time synchronization, updates, pending reboot, driver/firmware facts exposed by Windows, unexpected role drift, and reliability events |
| Monitoring pipeline | Discovery and workflow failures, timeouts, script errors, stale data, agent health, cardinality, data volume, and duplicate-event behavior |

Guest application and workload health is excluded. Host-observable VM state and integration-service
health remain in scope because they describe whether the virtualization platform is delivering the
VM service.

## Raw inventory row

Every technically available candidate must record:

| Field | Meaning |
|---|---|
| Platform version | Windows Server, Hyper-V, SCOM, cluster level, and optional SCVMM version tested |
| Topology applicability | Standalone, clustered, shared-nothing, CSV, SMB, SAN, Replica, or other supported variant |
| Entity | Exact object the signal describes and the stable correlation key |
| Category | Metric, performance counter, event/log, state, service, configuration, capacity, relationship, or synthetic test |
| Source | Counter path, log/provider/event, PowerShell property, CIM/WMI class/property, registry value, or test |
| Semantics | Units, instance behavior, aggregation, reset/wrap behavior, missing-data meaning, and known caveats |
| Access and cost | Required privilege/Run As, interval, expected cardinality, agent cost, network volume, and database volume |
| Evidence | Source URL or MP element plus fixture, command, observed result, and capture date |
| Disposition | Unreviewed, candidate, duplicate, unsupported, unstable, too costly, or excluded |

## Curated monitoring row

Candidates that survive research add the authoring contract:

| Field | Required decision |
|---|---|
| Health dimension | Availability, Performance, Configuration, Security, or no health impact |
| SCOM implementation | Target class and discovery, unit/aggregate/dependency monitor, rule, task, or view |
| Default | ON monitor, OFF monitor, collection rule, diagnostic/on-demand, or excluded |
| Severity and rollup | Warning/Critical behavior, alert priority, parent impact, and dependency suppression |
| Condition | State/event expression or numeric/baseline condition with warning and critical bands |
| Time behavior | Sample interval, consecutive samples or duration, hysteresis, reset/recovery, and alert closure |
| Operational knowledge | Probable causes, validation steps, remediation, escalation, and related performance views |
| Confidence | High, medium, or low with the exact evidence that supports the decision |

## Selection classes

| Class | Default behavior | Use when |
|---|---|---|
| Must monitor | Enabled and health-impacting | A supported, actionable failure threatens availability, data integrity, or cluster/VM service delivery |
| Should monitor | Usually enabled; tuning may be expected | A sustained condition predicts material degradation and has a credible operator response |
| Could monitor | Authored disabled with overrides | Value depends heavily on topology, workload, hardware, or local policy |
| Collect only | Performance/event rule without health impact | Trend and diagnosis value is high but a universal alert threshold is not defensible |
| Diagnostic | On-demand task or troubleshooting view | Collection is expensive, high-volume, privileged, or useful only after another symptom |
| Excluded | No shipped workflow | The signal is unsupported, redundant, unactionable, application-specific, unstable, or too costly |

## Threshold policy

Thresholds are conditions over time, not isolated numbers. Each threshold decision includes the
counter semantics, entity, topology, warning and critical bands, sample interval, duration or
consecutive samples, recovery condition, hysteresis, dependency behavior, maintenance suppression,
and evidence confidence.

Microsoft's Hyper-V guidance supplies several useful starting points:

| Signal | Published guidance | Research use |
|---|---|---|
| Hypervisor logical processor total runtime | More than 90% indicates an overloaded host | Candidate critical threshold; duration and recovery require lab validation |
| Physical NIC throughput | At least 90% of capacity indicates a network bottleneck | Capacity-relative candidate; link speed and multi-NIC topology must be handled |
| Physical disk read/write latency | Consistently more than 50 ms indicates a storage bottleneck | Candidate critical band; storage class and aggregation must be considered |
| Host memory | Evaluate `Memory\Available MBytes` and `Hyper-V Dynamic Memory Balancer(*)\Available Memory` when memory is low | Use available/reserve and pressure evidence; no universal utilization percentage is supplied |
| SCOM consecutive performance samples | Two or three samples is typical | Starting noise-control pattern, not a universal requirement |
| SCOM performance sampling | Five to fifteen minutes is typical | Starting interval range; availability events may require much faster detection |

Current Veeam ONE documentation is retained as an external benchmark, not a Microsoft support
contract. Its Hyper-V defaults include 15-minute CPU bands of 75%/85%, host memory-pressure bands of
90%/100%, VM memory-pressure bands of 110%/125%, CSV or local-volume free-space bands of 10%/5%, and
storage-latency bands of 40/80 ms. Threshold research must reconcile those values with Microsoft semantics and
our own lab evidence before any become defaults.

::: warning Should host memory alert at 75%?
Not by itself. A host at 75% used memory can be healthy, while another host at a lower percentage can
be unable to satisfy VM demand or preserve the management partition. The default design should
combine available memory or host reserve, Hyper-V dynamic-memory pressure, paging evidence, and
sustained duration. A percentage may remain useful for capacity trending or an optional policy tier,
but it is not accepted as the sole phase-one health condition.
:::

## Microsoft Hyper-V 2019 MP boundary

The Microsoft System Center 2019 Management Pack for Hyper-V is a research source, not part of this
product's dependency model. Reference analysis may extract useful entity concepts, monitoring scenarios,
signals, thresholds, alert knowledge, and lessons from its guide and exported elements. Every reused
idea must be checked against current Windows Server behavior, current Microsoft documentation, and
our lab results.

The new Management Pack will not import, extend, override, or require the Microsoft Hyper-V 2019
MP. It will define and ship its own supported classes, discoveries, monitors, rules, knowledge, and
views. Research must document semantic provenance, but implementation must use this project's own
namespaces and independently validated workflows.

## Noise and recovery rules

- State and authoritative failure events can alert quickly; resource pressure generally must be
  sustained.
- Warning and Critical entry bands need lower recovery bands or another hysteresis mechanism.
- A parent dependency failure should suppress predictable child symptoms where SCOM targeting and
  health rollup permit it.
- Planned VM state, cluster maintenance, node drain, backup/checkpoint activity, and migration must
  not look like unplanned failure.
- Missing data must resolve to a documented state such as Unknown or monitoring failure, not silently
  to Healthy.
- High-cardinality counters can be diagnostic or collected selectively even when they are valuable.
- Percentage capacity thresholds should be paired with absolute reserve where scale makes percentage
  alone misleading.

## Initial authoritative sources

- [Microsoft: detecting bottlenecks in a virtualized environment](https://learn.microsoft.com/en-us/windows-server/administration/performance-tuning/role/hyper-v-server/detecting-virtualized-environment-bottlenecks)
- [Microsoft: Hyper-V memory performance](https://learn.microsoft.com/en-us/windows-server/administration/performance-tuning/role/hyper-v-server/memory-performance)
- [Microsoft: Hyper-V storage I/O performance](https://learn.microsoft.com/en-us/windows-server/administration/performance-tuning/role/hyper-v-server/storage-io-performance)
- [Microsoft: Hyper-V network I/O performance](https://learn.microsoft.com/en-us/windows-server/administration/performance-tuning/role/hyper-v-server/network-io-performance)
- [Microsoft: troubleshoot Hyper-V VM performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)
- [Microsoft: manage Cluster Shared Volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)
- [Microsoft: Operations Manager process-monitoring sample and interval behavior](https://learn.microsoft.com/en-us/system-center/scom/process-monitoring-template?view=sc-om-2025)
- [Microsoft: System Center 2019 Management Pack for Hyper-V](https://www.microsoft.com/en-us/download/details.aspx?id=101312)
- [Veeam ONE: Microsoft Hyper-V alarm catalog](https://helpcenter.veeam.com/docs/one/userguide/hyperv_alarms_events.html)
