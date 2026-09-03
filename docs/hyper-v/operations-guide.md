---
title: Operations guide
description: Day-two operations for the Hyper-V Private Cloud Monitoring SCOM pack - the console layout, discoveries, overrides and tuning tiers, tasks, recoveries, and how to read health.
---

# Operating Hyper-V Private Cloud Monitoring

This page is for the operator who has the packs [imported](prerequisites.md) and now runs them
day to day: where things live in the console, what runs by default, how to tune it, and what to do
when something goes red. For what is monitored and why, see the
[monitoring catalog](monitoring-catalog.md); for installation, the
[prerequisites](prerequisites.md) and the [administration guide](management-pack-guide.md).

## The console layout

Everything lives under **Monitoring → Hyper-V Private Cloud**:

| Folder | What you find there |
|---|---|
| **Overview** | **Solution Health** and three nested Distributed Application diagrams — **Solution Diagram** (the entire private cloud), **Hyper-V Fabric Diagram** (every cluster and host across all sites with their VMs, storage and networking), **Management Stack Diagram** (host management services, VMM, SDN, monitoring pipeline) — plus the per-boundary **Private Cloud Diagram** and **All Active Alerts**. Start here every morning. |
| **Compute** | Host state, host performance, and Hyper-V event views. |
| **Virtual Machines** | Per-VM runtime state, performance, and replica views. |
| **Availability** | Failover cluster, node, network, group, CSV and cluster-role state views. |
| **Storage** | SAN LUNs, attachments, iSCSI sessions, FC ports, S2D, SMB and Pure views. |
| **Networking** | Physical adapters, virtual switches, Network ATC intents, SDN host state. |
| **Management Infrastructure** | Dedicated private cloud management domain views: Active Directory trust/channel, DNS services and name resolution, and bare-metal deployment (PXE/WDS). |
| **Monitoring Pipeline** | The product watching itself — probe and capability health. If this folder is unhealthy, distrust the rest until it is fixed. |
| **Operations** | Task-oriented views for day-two work. |

Three enterprise-wide Distributed Applications exist exactly once: **Hyper-V Private Cloud** (the
whole solution) contains **Hyper-V Fabric** and **Management Stack**. Beneath the fabric, one
per-boundary DA (`Hyper-V Private Cloud - <cluster or host>`) exists per cluster or standalone
host, and its seven branches each roll up their own domain — so a red Storage branch means storage,
not an echo of some unrelated monitor. The Management Stack collects every boundary's Management
and Monitoring Pipeline branches, which is where VMM and SDN objects surface.

## What runs by default

Everything ships enabled except the items listed below — no switches to flip on day one:

- The **registry seed** finds Hyper-V hosts, the **topology discovery** (30 min) maintains hosts,
  VMs, disks, adapters and replicas, and each imported **capability discovery** (4 h) maintains its
  own objects. VM runtimes follow live migration within one topology cycle.
- **Cluster-wide facts run once per cluster** on a cluster-role object hosted by the cluster's core
  group. It appears on whichever node owns the core group and fails over with it. If the cluster
  role object never appears: enable **agent proxy** on every cluster node (Administration →
  Agent Managed → Properties → Security).
- **Host-wide and per-instance facts run as one probe per host** per interval — one PowerShell 7
  process feeds every per-VM, per-LUN, per-session, per-port and per-intent monitor. If PowerShell 7
  (machine-wide MSI) is missing on a host, *everything* on that host stays grey — that is the first
  thing the Monitoring Pipeline folder will tell you.

### Deliberately disabled (enable by override only when the note applies)

| Item | Why it ships disabled |
|---|---|
| `MicrosoftSmbLink` discovery (File Services) | Links SMB shares to Microsoft's own SMB service objects. Enable **only** when every SMB file server backing VM storage is itself a SCOM-managed Windows server; otherwise the whole discovery batch is rejected (event 10801). |
| Recovery: *Restart VMMS when the management service monitor is critical* | Automatic service restarts are an operational policy decision. Enable when you want hands-off recovery. |
| Recovery: *Resume the VM when its expected-state monitor is critical* | Same policy decision, per VM. |
| A handful of superseded monitors (host CPU/memory/paging, VM memory pressure, four v1 storage availability monitors, VLAN mismatch) | Each is replaced by a better monitor; the knowledge article on the disabled monitor names its successor. Never enable both. |

To enable any of these: right-click the object type's monitor/discovery (or use Authoring →
Management Pack Objects), **Overrides → Override the …**, tick `Enabled` = True, and save to your
**custom override management pack** — never the Default Management Pack.

## Tuning: overrides

### Apply solution overrides (the supported way)

Import the canonical Discovery + Monitoring override pair:

```powershell
iwr https://labs.hybridsolutions.cloud/hybrid-health-monitoring/downloads/hyper-v-private-cloud/tools/Install-HyperVPrivateCloudOverrides.ps1 -OutFile Install-HyperVPrivateCloudOverrides.ps1
./Install-HyperVPrivateCloudOverrides.ps1 -Import
```

The solution ships two starter override management packs:
- **`HyperVPrivateCloud.Discovery.Overrides`** — controls discovery cadences, intervals, and scopes.
- **`HyperVPrivateCloud.Monitoring.Overrides`** — provides a visible, versionable baseline for monitor and rule thresholds across the private cloud fabric.

To customize for your organization, generate organization-prefixed packs (`<Org>.HyperVPrivateCloud.Discovery.Overrides` and `<Org>.HyperVPrivateCloud.Monitoring.Overrides`) using `New-HyperVPrivateCloudOverrideManagementPacks.ps1`.

### Change a single threshold

Every threshold is an overridable parameter — nothing is hard-coded in scripts:

1. Health Explorer on the object (or Authoring → Monitors), find the monitor.
2. Overrides → **Override the Monitor** → *For all objects of class…* (or a group/specific object).
3. Change the parameter (`WarningThreshold`, `ReadLatencyCriticalMs`, `MinimumPathCount`, …) and
   save to your custom override MP.

Two things worth knowing:

- Overriding a threshold **for one specific object** gives that object its own probe run
  (cookdown splits for it alone); class-wide overrides keep the one-probe-per-host model intact.
  Either is fine — just know that per-object overrides multiply probe processes if you make many.
- Intervals follow the same rule. The topology discovery's 30-minute interval is the documented
  exception to the 4-hour discovery default — it must chase live migration; slow it down only if
  you accept stale VM placement.

### Alert volume

Alerts are generated at each monitor's configured state (most at Error, availability-critical ones
noted in their knowledge). To silence a monitor for a subset of objects, override `Enabled` or the
alert severity for a **group** rather than disabling the monitor outright. Event-based alert rules
(live migration failures, hypervisor-not-running) suppress on event number and VM, so a storm of
identical failures produces one alert with a repeat count.

## Tasks: your first responders

63 agent tasks ship with the packs. The naming is a contract: **"Show …"** tasks are read-only
diagnostics — safe anytime; **"Remediation: …"** tasks change state and say exactly what they do.
Select an object (host, VM, cluster, disk…) and the matching tasks appear in the Tasks pane.

A field-tested triage flow:

1. Alert fires → open **Health Explorer** → read the state change context (every monitor carries
   the probe's detail message) and the knowledge article's operator response.
2. Run the relevant **Show** task on the object (for example *Show MPIO path report*,
   *Show S2D health report and faults*, *Show virtual machine detail*, *Show Network ATC intent
   status*) — output lands right in the console.
3. Fix by hand or run the matching **Remediation** task (*Rescan storage*, *Repair a virtual disk*,
   *Resume this node with failback*, *Restart the Virtual Machine Management Service*, …).

Console shortcuts on host and VM objects: **Remote Desktop to the Hyper-V host**, **Open Hyper-V
Manager**, **Open Failover Cluster Manager**, **Connect to the virtual machine console**.

The *Capture VM health detail on state change* diagnostic runs automatically when a VM's
expected-state monitor trips, so the alert already contains a fresh snapshot before you look.

### Operator Hub: Deep troubleshooting & diagnostic tasks

Operators can diagnose host connectivity, directory services, and network fabric issues directly from SCOM without remoting into nodes:

| Task | Target | What it tests & returns |
|---|---|---|
| **Test Active Directory domain and secure channel** | Host | Runs `Test-ComputerSecureChannel -Verbose`, identifies PDC emulator, domain forest functional level, and local AD site membership. |
| **Test DNS configuration and name resolution** | Host | Audits configured client adapter DNS servers, tests forward queries, and verifies Active Directory domain controller SRV records (`_ldap._tcp.dc._msdcs.<domain>`). |
| **Test TCP port connectivity** | Host | Fast TCP socket probe against default gateway (HTTP/HTTPS/SMB), DC core services (RPC 135, LDAP 389, LDAPS 636, Kerberos 88, SMB 445, WinRM 5985), and optional custom target passed in the Parameter field (`host:port`). |
| **Test bare-metal PXE and WDS deployment services** | Host | Validates `WDSServer` service status, active UDP listeners on PXE/TFTP ports (67, 68, 69, 4011), and checks the `REMINST` remote installation share. |
| **Discover Top-of-Rack switch LLDP and CDP neighbors** | Host | Queries CIM `MSFT_NetLldpAgent`, physical adapter driver properties, and ARP/NDP tables to discover connected ToR switch port ID, switch chassis ID, and system description. |
| **Show Priority Flow Control and RDMA pause counters** | Host | Queries RDMA activity, PFC pause frames, DCB traffic classes, and QoS policy drop counters for deep lossless RoCEv2 fabric troubleshooting. |

## Reading health like the pack means it

- **VM availability is policy-aware.** A VM is only "expected Running" when Hyper-V auto-starts it,
  when *StartIfRunning* applies and it was running, or when its cluster group is Online. A VM you
  shut down on purpose evaluates *Not applicable*, not red. Every migration window is tolerated —
  a moved VM reports benignly until the next topology pass, no alert storm.
- **NotApplicable is healthy by design.** A host without iSCSI, a VM without Dynamic Memory, a
  non-clustered host — their irrelevant monitors stay green rather than nagging.
- **Monitoring Pipeline red = fix the plumbing first.** It means a probe itself failed (module
  missing, PowerShell 7 absent, timeout). The probe scripts log to the Operations Manager event log
  with source names starting `HyperVPrivateCloud.` and event IDs in the 8200–8900 range; the event
  text is the exact exception. Run *Run the monitoring pipeline self-test* on the host.
- **Maintenance:** put the **host object** (or the whole cluster's objects) in SCOM maintenance
  mode before planned work; the cluster tasks (*Drain this node*, *Resume this node with failback*)
  pair with it. Storage maintenance for S2D nodes has its own tasks so disks don't alert while a
  node is deliberately down.

## Quick answers

| I want to… | Do this |
|---|---|
| See every alert in one place | Overview → **All Active Alerts** |
| Know why a monitor is red | Health Explorer → state change events → detail message + knowledge |
| Turn on the SMB↔Microsoft link | Override `Enabled` on the *MicrosoftSmbLink* discovery (read its knowledge first) |
| Auto-restart VMMS on failure | Enable the *Restart VMMS…* recovery by override |
| Loosen a latency threshold | Override the monitor's `…CriticalMs`/`…WarningMs` parameter to your custom MP |
| Slow discovery in a big estate | Override `IntervalSeconds` on the capability discoveries (keep topology at 30 min) |
| Prove a host's probes work | Task: *Run the monitoring pipeline self-test* |
| Check my import is complete | Every folder above populates within ~35 minutes of agent assignment; Monitoring Pipeline goes green first |
