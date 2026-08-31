---
title: Operations guide
description: Day-two operations for the Azure Local SCOM pack - console layout, what runs by default, tuning with the Lab/Standard/Strict profiles, and how to read health.
---

# Operating the Azure Local SCOM pack

This page is for the operator running the Azure Local pack day to day. For installation and
dependencies see the [prerequisites](prerequisites.md) and the
[management pack guide](management-pack-guide.md); for what is monitored and why, the
[monitoring catalog](monitoring-catalog.md).

::: warning Lab-preview baseline
This product is a sealed **lab preview**, not a production release: it passes VSAE/SDK
verification and offline tests but has not completed governed release signing or SCOM lab
certification. Operate it in pre-production only, and expect thresholds marked *provisional* to
move before release.
:::

## The console layout

Everything lives under **Monitoring → Hybrid Solutions Cloud - Azure Local**:

| Folder | Views |
|---|---|
| **Health services** | *Azure Local service health* — the Distributed Application state view. Start here. |
| **Inventory** | *Azure Local nodes*, *Deployments*, *Storage pools*, *Volumes and CSVs*, *Physical disks*, *Network ATC intents*, *Solution updates*, *Arc integrations*, *VM-management infrastructure*, *Monitoring pipeline*. |
| **Operations** | *Active alerts*, *Performance*, *Events*. |

The Distributed Application groups its domains as **Compute**, **Storage**, **Network**,
**Azure Integration**, **Lifecycle**, and **Monitoring Pipeline** — a red branch points at its own
domain, not a global echo.

## What runs by default

All fourteen monitors ship enabled — cluster service, node membership, quorum, CPU pressure,
available memory, Health Service faults, storage pool, volume/CSV, physical disk aggregate,
Network ATC, Azure registration/connection, Arc/MOC platform services, solution update, and the
monitoring pipeline. Alerting monitors auto-resolve their alerts; CPU, memory, and the disk
aggregate stay visible in Health Explorer without paging by default.

Performance collection ships enabled for processor load, available memory, network throughput,
physical-disk read/write throughput and latency, and logical-disk free space.

### Deliberately disabled (enable by override after verifying counters exist in your estate)

| Rule | Why it waits |
|---|---|
| *Collect Azure Local node network output queue* | Counter existence and cardinality vary by NIC stack. |
| *Collect Azure Local physical disk queue length* | High-cardinality; enable once you have a use for it. |
| *Collect Azure Local CSV read throughput* / *…write throughput* | Verify the CSV counter set on your build first. |

Enable via Authoring → Rules → Overrides → `Enabled` = True, saved to your custom override
management pack (never the Default Management Pack).

## Tuning

The preview ships **Lab, Standard, and Strict** override profiles as separate Discovery and
Monitoring XML files — import exactly **one profile's pair** per management group (they are in the
lab-preview ZIP). Standard mirrors the coded defaults; Lab loosens the provisional thresholds for
test rigs; Strict tightens them.

For a single change, override the monitor's parameter (CPU/memory/capacity thresholds are all
overridable) to your custom MP. Thresholds documented as *provisional* in the
[catalog](monitoring-catalog.md) are the ones expected to move with lab evidence — record any
override you make there so it can inform the release defaults.

## Day-two flow

1. *Azure Local service health* view → red branch → **Health Explorer** → state-change context and
   knowledge.
2. Run **Show Azure Local diagnostic summary** on the node — the pack's built-in diagnostic task —
   for a one-shot report of cluster, storage, ATC, Arc and pipeline state.
3. **Monitoring pipeline red = fix that first**: it means the pack's own probes failed on that node
   (PowerShell execution, module availability, timeouts); the Operations Manager event log on the
   node carries the exact error. Distrust the other views on that node until it is green.
4. **Azure Integration / Lifecycle branches** reflect Azure-side state (registration, Arc/MOC
   services, solution updates). They can go red while on-premises workloads are perfectly healthy —
   triage them as connectivity/agent problems, not cluster problems.
5. Use SCOM **maintenance mode** on node objects for planned Azure Local servicing; solution-update
   activity is expected to surface in the Lifecycle branch while an update runs.

## Feeding the release gate

This preview exists to gather lab evidence. When a monitor is noisy, wrong, or silent during an
induced fault, capture the Health Explorer context and the event log extract — those observations
are exactly what moves the product from lab preview to certified release.
