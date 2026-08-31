---
title: Hyper-V Management Pack administration guide
description: Public operator guide for building, installing, validating, tuning, upgrading, and removing the Hyper-V SCOM Management Pack.
---

# Hyper-V Management Pack administration guide

This guide explains how Hyper-V Private Cloud Monitoring is installed, tuned, validated,
upgraded, and removed. Version `1.0.0.0` is permanently sealed with public key token
`54d0fb1159995c86` and published as repository-hosted Management Packs, public overrides,
manifests, checksums, and profile bundles.

**[Download version 1.0.0.0 now](../downloads/hyper-v-private-cloud.md).** Once imported,
the [operations guide](operations-guide.md) covers day-two use: console layout, tuning, tasks.
 Import exactly one
deployment profile's reviewed Discovery and Monitoring override pair. The former Hyper-V `0.1.0`
lab preview is superseded and is not compatible with this signing identity.

## What the download contains

| Deliverable | Purpose |
|---|---|
| Sealed product MPs | Four core MPs and nine separately installable capability adapters |
| Management Pack guide | Prerequisites, import, verification, tuning, upgrade, rollback, removal, and troubleshooting |
| Monitoring catalog | Workflow IDs, targets, defaults, overrideable parameters, knowledge, and evidence |
| Override starter files | Generator and separate customer-owned Discovery and Monitoring output for Lab, Standard, and Strict |
| Release record | Version matrix, dependencies, checksums, changes, known issues, and profile changes |

The sealed MPs are product-owned. Every active override is stored in customer-owned, unsealed XML.

## Dependency profile

The four required core MPs have no optional Cluster, CSV, S2D, SAN, Pure, SDN, or VMM dependency.
Each supported capability is a separate sealed adapter. Publisher-owned prerequisite MPs are not
redistributed in the HCS download and must be installed before the corresponding adapter.

### PowerShell 7 execution prerequisite

Every first-party script runs in an explicit PowerShell 7 process. Install a supported
machine-wide PowerShell 7 MSI on every Hyper-V agent and on any management server that executes a
server-side capability workflow. The first release requires the normal MSI path:
`%ProgramFiles%\PowerShell\7\pwsh.exe`.

Use Microsoft's current MSI deployment guidance. For an interactive Windows Server installation
where `winget` is available:

```powershell
winget install --id Microsoft.PowerShell --source winget --installer-type wix
```

For controlled server deployment, download the signed x64 MSI from the official PowerShell release
and deploy it machine-wide without changing the installation directory. Store/MSIX, ZIP,
user-scoped, and relocated installations do not satisfy this release contract. Keep PowerShell 7
serviced according to Microsoft's support lifecycle.

After importing the core MPs, run **Collect Hyper-V diagnostic and PowerShell runtime summary**
against a discovered host. Do not approve the installation unless the result shows:

- `PSEdition : Core`;
- `PowerShellProcessPath : C:\Program Files\PowerShell\7\pwsh.exe`;
- a supported `PowerShellVersion`; and
- `AutomationAssemblyLocation` beneath the same PowerShell 7 installation.

The MP does not fall back to Windows PowerShell. A missing or relocated executable produces a
workflow failure that must be corrected before monitoring can be considered healthy. See
[ADR 0047](../design/decisions/0047-hyper-v-v2-explicit-powershell-7-execution.md) for the execution
and security contract and Microsoft's
[PowerShell installation guidance](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows).

Each optional capability's PowerShell modules must also load successfully in PowerShell 7. The
capability prerequisites below are additive to this common prerequisite.

The authored `Capability.Cluster` adapter requires these prerequisites before import:

| Prerequisite | Minimum | Purpose |
|---|---:|---|
| Microsoft Windows Server Cluster 2016 and above MPs | `10.1.0.0` | Authoritative cluster, node, role/group, network, and leaf health |
| Microsoft Windows Server OS/CSV MPs | `10.1.2.2` | Authoritative Cluster Shared Volume objects, health, and performance |
| Library and Presentation | Matching product version | DA relationships, rollup targets, and common console folders |
| Failover Clustering management tools | Matching Windows Server | Local, read-only topology queries used by the HCS relationship adapter |

Install the Hyper-V and Failover Clustering roles with their management tools on participating
Windows Server hosts:

```powershell
Install-WindowsFeature Hyper-V -IncludeManagementTools
Install-WindowsFeature Failover-Clustering -IncludeManagementTools
```

If the clustering role is already present without its PowerShell module, install the missing
feature explicitly:

```powershell
Install-WindowsFeature RSAT-Clustering-PowerShell
```

The HCS adapter does not replace or duplicate Microsoft cluster monitoring. It submits key-based
relationships to Microsoft objects, rolls their health into the private-cloud DA, and adds an HCS
integration-pipeline monitor. Microsoft remains the leaf-alert authority.

The authored `Capability.Storage` adapter has these host prerequisites:

| Prerequisite | When required | Purpose |
|---|---|---|
| Windows Storage PowerShell module | Always | Disk, partition, volume, and VHDX-to-LUN correlation |
| Multipath-IO plus an approved DSM | Multipathed SAN | Path inventory and redundancy health |
| Windows iSCSI PowerShell module | iSCSI SAN | Session and connection discovery and health |
| HBA driver exposing `MSFC_FibrePortHBAAttributes` | Fibre Channel SAN | FC port identity and operational state |

Install Multipath-IO where the approved storage design requires it:

```powershell
Install-WindowsFeature Multipath-IO -IncludeManagementTools
```

The Management Pack never enables automatic claiming or changes MPIO policy. Configure MSDSM or
the vendor DSM according to the array vendor's supported host-integration guide. A missing optional
transport is Not Applicable when no disk uses it; a visible iSCSI/FC disk without the required
query or MPIO capability is reported as a configuration or redundancy problem.

The authored `Capability.S2D` adapter requires Microsoft's Storage Spaces Direct Management Pack
package `1.0.47.4` and its bundled `Microsoft.Storage.Library`. Import and validate the complete
Microsoft bundle before the HCS adapter; the adapter will not rediscover or replace Microsoft
storage objects. The S2D package's Cluster and Windows Server prerequisites must also be present,
and the Microsoft pack must already discover its subsystem, nodes, disks, pools, virtual disks,
volumes, and file shares.

The HCS adapter references the lowest compatible Microsoft MP identity (`1.0.0.0`) while requiring
the inspected `1.0.47.4` package as the supported minimum. It contributes DA membership, health
rollup, query-pipeline coverage, and views only. Microsoft S2D faults, ongoing jobs, leaf monitors,
alerts, and performance rules remain authoritative.

The authored `Capability.PureStorage` adapter has these prerequisites and support boundaries:

| Prerequisite | Minimum | Purpose |
|---|---:|---|
| Pure Storage FlashArray MP | `2.0.120.0` | Authoritative array, controller, host, port, volume, pod, health, alert, and performance objects |
| SCOM | 2016, 2019, or 2022 | Vendor-documented support lane for the inspected Pure MP release |
| Library, Presentation, and Storage | Matching product version | Private-cloud relationships, common folders, and Windows SAN identities |
| Pure host IQN/WWN and volume serial inventory | Exact values | Deterministic correlation to Windows iSCSI/FC initiators and HCS logical units |

Import and configure the vendor MP first, then verify that it discovers the FlashArray. The HCS
adapter uses already-discovered SCOM objects through the Operations Manager SDK. It does not use
the Pure Run As account, call the FlashArray REST API, modify the array, or duplicate vendor leaf
alerts. A Pure array with no exact HCS host or volume identity match is Not Applicable. An
ambiguous identity is deliberately left uncorrelated.

Pure has not published support evidence for SCOM 2025 for this vendor MP release. Consequently,
the Pure adapter is not supported on SCOM 2025 unless a later Pure package is separately inspected,
tested, and added to the release support matrix.

The authored `Capability.FileServices` adapter requires Microsoft's Windows Server File & iSCSI
Services package `10.1.0.4`. Import the complete Microsoft bundle and confirm that its File Server
and SMB service objects are healthy before importing the HCS adapter. Hyper-V compute hosts require
the Hyper-V and `SmbShare` PowerShell modules. Clustered SOFS deployments also require the Microsoft
Cluster/CSV packages and the optional HCS Cluster capability; nonclustered SMB deployments do not.

The adapter creates stable projections only for SMB shares that actually back an attached VM disk,
their selected Multichannel/RDMA paths, and share-to-VHDX/VM mappings. It requires an active SMB
connection and continuous availability. RDMA enforcement defaults off because not every supported
SMB design requires SMB Direct; set `RequireRdma` only for a validated RDMA/DCB design. Microsoft
remains authoritative for File Server, SMB service, witness, resume-key, firewall, and clustered
continuous-availability alerts.

The authored `Capability.PhysicalNetwork` adapter requires SCOM network monitoring to have already
discovered the switches that carry Hyper-V traffic. Use the built-in network libraries shipped with
the installed SCOM release; the HCS MP references only public types present since SCOM 2016. SCOM's
network discovery account and SNMP credentials remain owned by SCOM and are never copied into an
HCS Run As profile.

On each host, the adapter relates external Hyper-V virtual switches to the existing
`Microsoft.Windows.ComputerNetworkAdapter` objects by the exact `Get-NetAdapter` `DeviceID` and MAC
address representation used by Microsoft's Windows Server discovery.
The built-in SCOM network merge then owns connection and peer topology to discovered switch ports.
After import, open the SCOM network diagram and verify every participating host adapter reaches the
expected switch and port. Missing or ambiguous paths must be fixed in SCOM network discovery; HCS
does not guess a switch from an IP address, interface name, or partial MAC address.

The authored `Capability.NetworkATC` adapter is initially supported for Windows Server 2025
Hyper-V failover clusters that meet Microsoft's Network ATC requirements. It is a local Windows
feature integration and has no external Microsoft Management Pack dependency. Import the matching
Library and Presentation MPs first.

| Prerequisite | Requirement | Purpose |
|---|---|---|
| Windows Server | 2025 on every participating cluster node | Supported Hyper-V Network ATC baseline |
| Physical adapters | Symmetric make, model, speed, configuration, names, and Up state across nodes | Stable cluster-wide intent application |
| `NetworkATC` | Installed with management tools | `Get-NetIntent` and `Get-NetIntentStatus` discovery and health |
| `Hyper-V` and `Failover-Clustering` | Installed with management tools | Supported virtualization and cluster topology |
| `Data-Center-Bridging` and `FS-SMBBW` | Installed where required by the Network ATC design | QoS, RDMA, and SMB Direct support |

Install the supported feature set on each participating node:

```powershell
Install-WindowsFeature NetworkATC, Hyper-V, Failover-Clustering, Data-Center-Bridging, FS-SMBBW -IncludeManagementTools
```

The adapter discovers the expected intent request separately from each node's actual status. It
requires `ConfigurationStatus = Success`, `ProvisioningStatus = Completed`, and no error for
Healthy state. Active convergence is Warning for up to 30 minutes by default; failed or prolonged
convergence is Critical. Missing/down adapters are Critical, and storage intents require RDMA by
default. Override `RequireRdmaForStorage` only for a documented nested or non-RDMA test design.

`RequireNetworkATC` defaults to `false`. A host with no Network ATC feature or intent is therefore
Not Applicable and treated as `ManualOrExternal`. Set it to `true` only on groups where Network ATC
is the declared host-network authority; missing capability or intent then becomes Critical. The
Management Pack is read-only and never adds, sets, removes, updates, retries, or remediates an
intent or restarts a service.

Network ATC may coexist with Windows Server SDN: ATC can own host adapters, SET switches, and
intent while Network Controller owns overlay policy and SDN resources. VMM may orchestrate either
layer. Do not disable ATC solely because SDN or VMM is installed; prevent only duplicate ownership
and duplicate health paths for the same resource.

The authored `Capability.SDN` adapter requires Microsoft's Windows Server SDN MP `10.0.0.2`.
Install and configure the Microsoft product first:

1. Import `Microsoft.Windows.10.SDNMonitoring` and
   `Microsoft.Windows.10.SDNMonitoring.Images` from the official package.
2. Add the Network Controller nodes as agentless-managed computers in SCOM.
3. Create a Run As account whose identity is a member of the Network Controller Clients Kerberos
   Security Group, then associate it with Microsoft's **SDN Monitoring Account** profile.
4. Trust the Network Controller REST X.509 public certificate in the Local Computer trusted-root
   store on the SCOM management server.
5. Confirm that Microsoft's SDN stamp, controller, host, network, MUX, and gateway objects are
   discovered before importing the HCS SDN capability.

The HCS adapter does not receive the Run As credential and never calls Network Controller REST.
It adds read-only host-binding evidence, fills verified service-rollup gaps, attaches Microsoft's
authoritative SDN groups to the private-cloud Management and Networking branches, and provides 16
curated views under **Hyper-V Private Cloud > Networking > Software Defined Networking**. The
local `NcHostAgent` `HostId` is displayed as evidence but is not guessed into a Microsoft SDN Host
relationship because Microsoft uses a different `ResourceId` key for that class.

Microsoft's setup instructions and supported Windows Server/SCOM matrix are on the
[Windows Server SDN MP download page](https://www.microsoft.com/en-us/download/details.aspx?id=54300).

### Virtual Machine Manager capability

The initial `Capability.VMM` support lane is System Center 2025 VMM using the exact Management
Packs shipped with the installed product. Microsoft couples these packs to the VMM build; do not
substitute a VMM 2019/2022 package or assume a later update is compatible merely because its IDs
look similar.

Before importing the HCS VMM capability:

1. Integrate VMM 2025 with a supported Operations Manager management group by using Microsoft's
   VMM integration wizard.
2. Confirm that the matching VMM Library, Discovery, Monitoring, and PRO v2 Library MPs are
   imported and that Microsoft VMM management servers, hosts, clouds, and VMs are discovered.
3. Confirm that the VMM console installed on each VMM management server matches the VMM service
   build and that the `VirtualMachineManager` PowerShell module is available.
4. Configure Microsoft's **VMM Server Connection Run As Profile** with a dedicated account that
   has at least the VMM Read-Only Administrator role across every monitored host group, cloud, and
   library server. Distribute that account only to the VMM management-server targets.
5. Import the sealed HCS `Capability.VMM` MP after the four HCS core MPs.

The adapter creates a **VMM fabric** Distributed Application root, relates Microsoft's authoritative
servers, hosts, and private clouds to the HCS service graph, and adds the VMM-specific WinRM and
agent-version health path without duplicating Microsoft's CPU, memory, Hyper-V service, VM, cloud,
storage, alert, performance, dashboard, or report workflows. It also fills three verified gaps:
logical networks, network sites, and recent failed-job health.

The failed-job monitor queries `Get-SCJob` every five minutes. Its default lookback is 24 hours and
one failed job is Critical; override `JobLookbackHours` and `FailedJobCriticalCount` through a
customer Monitoring Overrides MP when a different operational policy is required. Review failed
steps and error codes in the VMM Jobs workspace. HCS never retries or repairs a job.

The VMM folder provides fabric-service, server, cloud, host-group, host-cluster, Hyper-V host, VM,
VM-network, logical-network, network-site, switch, storage-pool, active-alert, and performance
views. Microsoft's richer Fabric, VM, Host, Network, and Storage dashboards remain in the native
VMM console area and remain Microsoft-owned.

The VMM adapter is governed-sealed and included in the download. Its representative VMM 2025
runtime certification remains post-installation operator work; do not enable it in production until
that topology, health, outage, upgrade, and removal validation is complete in pre-production.

See Microsoft's [VMM and Operations Manager integration guidance](https://learn.microsoft.com/en-us/system-center/vmm/monitors-ops-manager?view=sc-vmm-2025)
and [VMM role guidance](https://learn.microsoft.com/en-us/system-center/vmm/manage-account?view=sc-vmm-2025).

## Before installation

1. Confirm that the SCOM, Windows Server, Hyper-V, Failover Clustering, networking, storage, and
   optional System Center Virtual Machine Manager versions appear in the release support matrix.
2. Confirm that required Microsoft Management Pack libraries and minimum versions are installed.
3. Review the monitoring catalog, default-enabled workflows, expected data volume, and known issues.
4. Export and archive existing customer Management Packs and record the current management-group
   configuration.
5. Test the release in a representative pre-production SCOM management group.

Do not use a production management group as the first import target.

## Install the sealed product MPs

For the first installation, import the core packs in dependency order:

1. `HyperVPrivateCloud.Library`;
2. `HyperVPrivateCloud.Discovery`;
3. `HyperVPrivateCloud.Monitoring`; and
4. `HyperVPrivateCloud.Presentation`.

Then import only the capability MPs selected by the deployment profile, after importing each
capability's Microsoft or vendor prerequisites. The complete ZIP is a distribution archive, not an
instruction to enable every adapter in every environment.

If a release uses a Management Pack bundle, the release record will state which dependencies remain
separate prerequisites. Use the Operations Manager import review to resolve every dependency before
committing the import. Do not import any customer override MP until its referenced sealed MP is
present.

Microsoft documents the console and shell procedures in
[Import, export, and remove a Management Pack](https://learn.microsoft.com/en-us/system-center/scom/manage-mp-import-remove-delete?view=sc-om-2025).

## Verify the initial import

Wait for configuration distribution and then verify:

- the expected standalone hosts or clusters are discovered once with stable identity;
- host, cluster, virtual machine, storage, and network relationships match the approved topology;
- each Hyper-V Distributed Application has the expected dynamic membership;
- monitoring-pipeline health is not stale or failed;
- state, alert, performance, event, task, and diagram views open without errors; and
- HealthService, operational database, data warehouse, and alert volumes remain within the release
  budget.

Do not compensate for missing or duplicate topology by changing monitoring thresholds. Resolve the
discovery problem first.

## Create customer override MPs

Create two unsealed Management Packs in the Operations console:

| Customer-owned MP | Stores |
|---|---|
| `<Organization>.HyperVPrivateCloud.Overrides.<DeploymentProfile>.<Tier>.Discovery` | Discovery schedules, supported scope settings, and discovery-targeting groups |
| `<Organization>.HyperVPrivateCloud.Overrides.<DeploymentProfile>.<Tier>.Monitoring` | Monitor/rule thresholds, timing, enablement, collection settings, and monitoring-targeting groups |

In the Administration workspace, right-click **Management Packs**, select **Create Management
Pack**, and assign the organization's approved ID, display name, version, and description. The
destination file must be customer-owned and unsealed.

Never select the Default Management Pack. Microsoft states that installed unsealed system MPs
should not be used for customer settings and recommends a dedicated unsealed override MP for each
sealed MP being customized. See
[Create a Management Pack for overrides](https://learn.microsoft.com/en-us/system-center/scom/manage-mp-create-unsealed-mp?view=sc-om-2025).

::: warning Your overrides carry your organization's prefix — the shipped ones do not
The override packs in `Hyper-V-Private-Cloud-Monitoring-Overrides.zip` are named
`HyperVPrivateCloud.Overrides.<Profile>.<Tier>.<Kind>` with **no organization prefix**. They are
starting points published alongside the product, not your production overrides.

**Do not edit them in place.** They are unsealed, so the console will let you — but a later release
republishes the same pack IDs and your changes are lost. Instead, either create your own packs as
described above, or generate a customer-owned set:

```powershell
./src/hyper-v/scom-mp/tools/New-HyperVPrivateCloudOverrideManagementPacks.ps1 `
    -OrganizationId 'Contoso' -OrganizationName 'Contoso Ltd' `
    -DeploymentProfile ClusteredS2D -TuningTier Standard `
    -OutputPath 'D:\overrides'
```

That produces `Contoso.HyperVPrivateCloud.Overrides.ClusteredS2D.Standard.Discovery` and its
Monitoring pair — owned by you, upgrade-safe, and unambiguous next to the shipped packs.
:::

## Create a discovery override

1. In the Authoring workspace, open **Management Pack Objects** and **Object Discoveries**.
2. Locate the documented Hyper-V discovery by its display name and stable workflow ID.
3. Choose the appropriate class, group, or specific object target.
4. Select only the parameters that must change and keep every value inside its documented range.
5. Save the change to the customer Discovery Overrides MP.
6. Allow configuration to distribute, then validate discovery data, relationships, DA membership,
   workflow health, and execution cost.
7. Export and archive the approved override MP.

To disable a discovery, create an explicit `Enabled = False` override in the Discovery Overrides MP.
Do not assume already discovered objects will disappear. Review Microsoft's
[object-discovery override guidance](https://learn.microsoft.com/en-us/system-center/scom/manage-apply-overrides-object-discovery?view=sc-om-2025)
before considering removal of disabled class instances.

## Create a monitor or rule override

1. In the Authoring workspace, open **Management Pack Objects**, then select **Monitors** or
   **Rules**.
2. Locate the documented workflow and verify its target, default, unit, state behavior, and alert or
   collection effect.
3. Prefer **For a group** for an operational tier or policy cohort. Use a class only for universal
   policy and a specific object only for a reviewed exception.
4. Select the individual parameters to override.
5. Save the change to the customer Monitoring Overrides MP.
6. Validate both the intended condition and recovery, including alert opening, suppression,
   auto-resolution, health rollup, and data volume where applicable.
7. Export and archive the approved override MP.

When disabling a monitor or rule, use an explicit `Enabled = False` override and choose the correct
destination MP. Do not use a console shortcut that obscures where the change is stored. See
[Best practices for configuring overrides](https://learn.microsoft.com/en-us/troubleshoot/system-center/scom/best-practices-configure-overrides).

## Choose a tuning template

First select the deployment profile whose capabilities exactly match the sealed packs being
installed. Profiles range from `Standalone` through cluster/SAN/Pure/S2D/SMB, Network ATC, SDN,
VMM, and `CompletePrivateCloud`; the complete composition table is in the
[override architecture](../design/hyper-v/override-and-tuning-architecture.md#deployment-profiles).
Then select one tuning tier:

| Profile | Choose it when | Do not choose it when |
|---|---|---|
| Lab | Running bounded functional, fault, transition, or diagnostic tests | The environment is production or representative data volume has not been reviewed |
| Standard | Establishing the normal production starting point | Local topology or response requirements clearly differ from the documented assumptions |
| Strict | Protecting explicitly designated critical services with tested response capacity | The goal is simply to generate more alerts or lower every threshold |

Generate a customer-owned pair with:

```powershell
./src/hyper-v/scom-mp/tools/New-HyperVPrivateCloudOverrideManagementPacks.ps1 `
    -DeploymentProfile ClusteredS2D `
    -TuningTier Standard `
    -OrganizationId Contoso `
    -OrganizationName 'Contoso' `
    -Version '1.0.0.0' `
    -ProductVersion '1.0.0.0' `
    -PublicKeyToken '54d0fb1159995c86' `
    -OutputPath './out/contoso-overrides'
```

`Version` belongs to the customer-owned override MPs. `ProductVersion` must exactly match the
installed sealed Hyper-V Private Cloud MPs, and `PublicKeyToken` must match their signing identity.
Neither product fact has a default because guessing produces unresolved references at import time.
The product version and token above are the facts for release `1.0.0.0`; confirm them against the
governed release manifest before generating files for a later release.

The catalog explicitly names every workflow, target class, local module, property, and
configuration parameter. It applies shared acquisition settings consistently across every monitor
using the same data source to preserve cookdown. The Standard generated Monitoring MP also includes
a worked all-hosts group in that same unsealed MP and uses it for core host monitoring and
performance collection. A custom profile can define different same-MP Discovery or Monitoring
groups; generation fails on cross-unsealed-MP group references.

The repository's 66 `.xml.example` source files remain generator drift evidence. The
[public overrides ZIP](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Overrides.zip)
contains the 66 import-ready XML files generated for product `1.0.0.0` and token
`54d0fb1159995c86`.

Then:

1. Read the deployment-profile manifest and change log for the exact product version.
2. Review both generated Discovery and Monitoring files.
3. Replace the example organization identity with the customer's approved identity.
4. Remove settings that are not intentionally adopted.
5. Validate XML references and import the files only in pre-production.
6. Exercise normal, failure, recovery, maintenance, migration, and failover scenarios.
7. Promote the resulting customer-owned files through the customer's change process.

Never import multiple deployment profiles or tuning tiers for the same environment, and never
treat Lab values as a production shortcut.

## Review effective configuration

An imported override is not proof that the intended value is effective. Review:

- the target class, group membership, and specific instances;
- other class, group, and instance overrides that can apply;
- the destination override MP and its version;
- the workflow's effective configuration on representative agents;
- HealthService events or monitoring-pipeline health for rejected or stale configuration; and
- resulting state, alerts, collections, DA rollup, and runtime cost.

Record the reason, owner, evidence, approval date, and review date for every production deviation
from Standard. Company knowledge can document local operational context without modifying sealed
product knowledge.

## Upgrade safely

1. Read the release notes, dependency matrix, monitoring-catalog changes, and tuning-profile diff.
2. Export both customer override MPs and retain the currently installed product artifacts.
3. Import the newer sealed MPs in dependency order in pre-production.
4. Leave the customer override MPs in place and review unresolved, retired, or changed workflow
   references.
5. Repeat representative discovery, health, alert, DA, performance, and scale tests.
6. Promote the same signed product artifacts and approved customer overrides to production.
7. Verify effective configuration and record the installed versions.

An Operations Manager Management Pack downgrade is not treated as a routine rollback. The release
must provide a tested recovery procedure; removal and reimport can affect configuration, objects,
and historical data and therefore require a separately approved change.

## Remove the product

Removal is dependency-sensitive and potentially destructive. Test the exact release procedure in
an isolated management group before production. The expected dependency order is:

1. export and archive the customer override MPs;
2. remove customer Monitoring Overrides;
3. remove customer Discovery Overrides;
4. remove optional Reporting and Presentation;
5. remove Monitoring;
6. remove Discovery; and
7. remove Library.

Operations Manager blocks removal while referencing MPs remain. Removing MPs can also remove
configuration and affect discovered objects or stored data. Review the product release guide and
Microsoft's import/removal documentation before proceeding.

## Common mistakes

| Mistake | Safer practice |
|---|---|
| Saving to the Default Management Pack | Create the matching customer Discovery or Monitoring Overrides MP |
| Combining all product overrides in one file | Keep Discovery and Monitoring overrides separate so lifecycle operations do not remove unrelated policy |
| Overriding individual objects at scale | Create an intentional group and document its membership logic |
| Lowering a threshold without duration or recovery analysis | Tune threshold, sampling, duration, and hysteresis as one state contract |
| Disabling discovery to fix a monitor | Correct discovery only when the object should not exist; tune monitoring when it should exist but use different policy |
| Importing a template without review | Copy, rename, trim, test, and own the resulting unsealed files |
| Editing or resealing the product MP | Leave signed product artifacts unchanged and use supported overrides |
| Testing only alert creation | Validate recovery, closure, rollup, maintenance behavior, and data volume too |

## Related design

- [Override and tuning architecture](../design/hyper-v/override-and-tuning-architecture.md)
- [Management Pack structure](../design/hyper-v/management-pack-structure.md)
- [Monitoring catalog and threshold policy](monitoring-catalog.md)
- [Validation and release architecture](../design/hyper-v/validation-and-release.md)
