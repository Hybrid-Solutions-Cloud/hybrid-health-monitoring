---
title: Prerequisites
description: Everything that must be present in the management group before you import Hyper-V Private Cloud Monitoring, including the exact Microsoft and vendor management packs each capability requires.
---

# Prerequisites for Hyper-V Private Cloud Monitoring

Work through this page **before** importing anything. Most failed imports are caused by a missing
prerequisite management pack, and SCOM reports that as an unhelpful "cannot resolve reference" error
rather than telling you what to download.

The dependency tables on this page are **generated directly from the management pack source** by
`tools/scom/Export-MpDependencies.ps1`. They cannot drift from what the packs actually require — a
CI check fails the build if they do.

::: tip Only install what you need
The four **core** packs are always required. The nine **capability** packs are optional and each one
adds its own prerequisites. If you are not running Storage Spaces Direct, you do not need the S2D
packs. Skip to [Choose your capabilities](#choose-your-capabilities) to work out your shortlist first,
then obtain only the prerequisites on that list.
:::

---

## Before anything else: get the packs from the right place

Download the sealed release from the [downloads page](../downloads/hyper-v-private-cloud.md) or
from `docs/public/downloads/hyper-v-private-cloud/1.0.6.0/`.

::: danger Do not import from a local build directory
If you build from source, `src/hyper-v/scom-mp/out/development/` may contain a **partial** build.
A partial build is missing `Presentation`, which all nine capability packs reference — so every
capability import fails even though your management group is configured correctly.

Check `build-receipt.json` in that folder. If it says `"complete": false`, do not import from it.
Only artifacts with `"sealed": true` from a completed release are importable.
:::

---

## The fast path: one command

Every external management pack this product needs can be downloaded, extracted, and imported by
one script, straight from the publishers' official links (nothing is redistributed):

```powershell
# on a management server or SCOM-console machine, in PowerShell 7:
iwr https://labs.hybridsolutions.cloud/hybrid-health-monitoring/downloads/hyper-v-private-cloud/tools/Install-HyperVPrivateCloudPrerequisites.ps1 -OutFile Install-HyperVPrivateCloudPrerequisites.ps1
./Install-HyperVPrivateCloudPrerequisites.ps1 -Import

# or only what you use, e.g. a clustered SAN deployment:
./Install-HyperVPrivateCloudPrerequisites.ps1 -Capability Cluster, CSV -Import
```

Run it as a **file** (as shown), not pasted line-by-line into a console — interactive PowerShell
splits multi-line blocks. Without `-Import` it still downloads and extracts everything; you then
import the `management-packs` folder from the console yourself.

Then, in order:

1. **PowerShell 7 (machine-wide MSI) on every Hyper-V host** —
   [download](https://github.com/PowerShell/PowerShell/releases/latest) and install the `win-x64.msi`.
   The per-user or Store install does not work; every workflow launches
   `%ProgramFiles%\PowerShell\7\pwsh.exe` by absolute path.
2. **SCOM agent on every host**, and on cluster nodes tick **Allow this agent to act as a proxy**.
3. For a new installation, import the four **core** packs and every **capability** pack you use. For
   an upgrade, replace every installed `HyperVPrivateCloud.*` pack; do not upgrade only the core.
4. Apply solution overrides (see [the download page](../downloads/hyper-v-private-cloud.md)):
   `./Install-HyperVPrivateCloudOverrides.ps1 -Import`

::: details Why can't the SCOM console just resolve these itself?
The console's "resolve" only works for packs in Microsoft's online catalog, and these
infrastructure packs are not published there — they ship as Download Center MSIs. The script above
is the resolve button this product actually needed.
:::

If you would rather click, these are the exact downloads the script uses:

| Needed for | Package | Get it |
|---|---|---|
| Cluster capability | Windows Server Cluster MP 10.1.0.0 | [page](https://www.microsoft.com/en-us/download/details.aspx?id=54701) · [direct MSI](https://download.microsoft.com/download/b/d/5/bd59d8e4-4bf7-4dac-819a-1ac12e21c965/Microsoft%20SC%20MP%20for%20WS%20Cluster%202016%20and%201709%20Plus.msi) |
| Cluster capability (CSV) | Windows Server 2016+ MP 10.1.2.2 | [page](https://www.microsoft.com/en-us/download/details.aspx?id=54303) · [direct MSI](https://download.microsoft.com/download/c0becab2-ada7-435e-9215-42ef7dd44727/Microsoft%20System%20Center%20Management%20Pack%20for%20Windows%20Server%202016%20and%201709%20Plus.msi) |
| S2D capability | Storage Spaces Direct MP 1.0.47.4 | [page](https://www.microsoft.com/en-us/download/details.aspx?id=100782) · [direct MSI](https://download.microsoft.com/download/7/0/5/70509486-2d0f-4e53-a99f-f6db413e7df6/Microsoft%20System%20Center%20Management%20Pack%20for%20StorageSpacesDirect.msi) |
| SDN capability | SDN Monitoring MP 10.0.0.2 | [page](https://www.microsoft.com/en-us/download/details.aspx?id=54300) · [direct MSI](https://download.microsoft.com/download/a/3/0/a30bf7cc-78c9-4702-b3f2-3859ca824dc5/Microsoft%20System%20Center%20Management%20Pack%20for%20SDN%20Monitoring.msi) |
| File Services capability | File and iSCSI Services MP 10.1.0.4 | [page](https://www.microsoft.com/en-us/download/details.aspx?id=57594) · [direct MSI](https://download.microsoft.com/download/a/0/7/a071e8d0-d188-4ed8-8a8c-84dfdc1ac675/Microsoft%20SCMP%20for%20File%20and%20iSCSI%20Services%202016%20and%20above.msi) |
| VMM capability | VMM console MPs 11.19.0.3 | your VMM installation media (`ManagementPacks` folder) |
| Pure Storage capability (optional) | FlashArray MP 2.0.120.0 | [GitHub release](https://github.com/PureStorage-Connect/SCOM-Management-Pack/releases/tag/v2.0.120.0) — not supported on SCOM 2025 |

Extract each MSI (or install it and collect the `.mp` files) and import them **before** the
matching Hyper-V Private Cloud capability pack. Core needs none of these.

---

## Summary

| # | Prerequisite | Why it's needed | Blocking / Recommended |
|---|---|---|---|
| 1 | **SCOM 2019, 2022, or 2025** management group with the Operations console | Target platform. One capability (Pure Storage) is not supported on 2025 — see gotchas. | Blocking |
| 2 | **Data Warehouse role** installed and healthy | The `Monitoring` pack references `Microsoft.SystemCenter.DataWarehouse.Library`. Import fails without it. | Blocking |
| 3 | **PowerShell 7, installed machine-wide via MSI**, on every monitored Hyper-V host | Every discovery and monitoring workflow launches `%ProgramFiles%\PowerShell\7\pwsh.exe` by absolute path. | Blocking (see gotchas — fails silently) |
| 4 | **SCOM agent deployed and healthy** on every Hyper-V host to be monitored | Discovery is agent-hosted. | Blocking |
| 5 | **Base SCOM management packs** (`System.Library`, `Microsoft.Windows.Library`, `Microsoft.SystemCenter.Library`, and related) | Referenced by the core packs. Present in any default installation — no action needed. | Auto / no action |
| 6 | **Capability prerequisite management packs** — the Microsoft and vendor packs listed below | Each optional capability hard-references vendor packs that are **not** redistributed in the HCS bundles. | Blocking, per capability |
| 7 | **Run As configuration** for VMM, SDN, and Pure Storage capabilities | Those capabilities read from external control planes using dedicated Run As profiles. | Blocking, per capability |
| 8 | **Windows features and PowerShell modules** on the hosts, per capability | Workflows call native cmdlets — for example Network ATC requires the `NetworkATC` module. | Blocking, per capability |

---

## External management pack prerequisites

These are the management packs you must **obtain and import yourself** before the corresponding HCS
pack will import. They are not redistributed in the HCS ZIP bundles.

Versions shown are the **minimum** each pack hard-references. Importing a newer version is fine.

<!-- BEGIN GENERATED: external-dependencies -->
| Management pack | Minimum version | Publisher token | Obtain from | Required by |
|---|---|---|---|---|
| `Microsoft.Storage.Library` | 1.0.0.0 | `31bf3856ad364e35` | [Download](https://www.microsoft.com/en-us/download/details.aspx?id=100782) | S2D |
| `Microsoft.SystemCenter.VirtualMachineManager.Discovery` | 11.19.0.3 | `31bf3856ad364e35` | [Official media](https://learn.microsoft.com/en-us/system-center/vmm/) | VMM |
| `Microsoft.SystemCenter.VirtualMachineManager.Library` | 11.19.0.3 | `31bf3856ad364e35` | [Official media](https://learn.microsoft.com/en-us/system-center/vmm/) | VMM |
| `Microsoft.SystemCenter.VirtualMachineManager.Monitoring` | 11.19.0.3 | `31bf3856ad364e35` | [Official media](https://learn.microsoft.com/en-us/system-center/vmm/) | VMM |
| `Microsoft.SystemCenter.VirtualMachineManager.PRO.V2.Library` | 10.25.1200.0 | `31bf3856ad364e35` | [Official media](https://learn.microsoft.com/en-us/system-center/vmm/) | VMM |
| `Microsoft.Windows.10.SDNMonitoring` | 10.0.0.2 | `31bf3856ad364e35` | [Download](https://www.microsoft.com/en-us/download/details.aspx?id=54300) | SDN |
| `Microsoft.Windows.Cluster.Management.Library` | 10.1.0.0 | `31bf3856ad364e35` | [Download](https://www.microsoft.com/en-us/download/details.aspx?id=54701) | Cluster |
| `Microsoft.Windows.FileServices` | 10.1.0.3 | `31bf3856ad364e35` | [Download](https://www.microsoft.com/en-us/download/details.aspx?id=57594) | FileServices |
| `Microsoft.Windows.FileServices.SMB.2016` | 10.1.0.4 | `31bf3856ad364e35` | [Download](https://www.microsoft.com/en-us/download/details.aspx?id=57594) | FileServices |
| `Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect` | 1.0.0.0 | `31bf3856ad364e35` | [Download](https://www.microsoft.com/en-us/download/details.aspx?id=100782) | S2D |
| `Microsoft.Windows.Server.ClusterSharedVolumeMonitoring` | 10.1.2.2 | `31bf3856ad364e35` | [Download](https://www.microsoft.com/en-us/download/details.aspx?id=54303) | Cluster |
| `PureStorageFlashArray` | 2.0.120.0 | `a9d994eedb5e7179` | [Download](https://github.com/PureStorage-Connect/SCOM-Management-Pack/releases/tag/v2.0.120.0) | PureStorage |
<!-- END GENERATED: external-dependencies -->

::: info Hard references vs. download packages
The table above lists what SCOM **enforces at import time**. The Microsoft download packages
generally contain additional companion packs (presentation, images, localisation) which you should
import together with the referenced ones. For example the SDN download includes
`Microsoft.Windows.10.SDNMonitoring.Images`, and the Storage Spaces Direct download ships
`Microsoft.Windows.Server.Storage.Visualization.Library` alongside the two packs referenced here.
Import the full downloaded package — it is simpler and avoids partial-import problems.
:::

---

## Choose your capabilities

Work out which capabilities apply to your environment, then obtain only their prerequisites.

| Capability pack | Import it when | External prerequisites to obtain first |
|---|---|---|
| **Cluster** | Hyper-V hosts are in a failover cluster | Windows Server Cluster MPs ([id=54701](https://www.microsoft.com/en-us/download/details.aspx?id=54701)) and Cluster Shared Volume monitoring ([id=54303](https://www.microsoft.com/en-us/download/details.aspx?id=54303)) |
| **Storage** | You want SAN/HBA and multipath storage health | None beyond the SCOM base packs. Requires Multipath-IO, a vendor DSM, and an HBA driver exposing `MSFC_FibrePortHBAAttributes` on the hosts |
| **S2D** | Storage is Storage Spaces Direct | Storage Spaces Direct MP `1.0.47.4` ([id=100782](https://www.microsoft.com/en-us/download/details.aspx?id=100782)) |
| **PureStorage** | Backing storage is a Pure Storage FlashArray | Pure Storage FlashArray MP `2.0.120.0` ([GitHub release](https://github.com/PureStorage-Connect/SCOM-Management-Pack/releases/tag/v2.0.120.0)). **Also requires the Storage capability pack.** Purity 5.3.0+ |
| **FileServices** | VMs run over SMB / Scale-Out File Server | Windows Server File & iSCSI Services MPs ([id=57594](https://www.microsoft.com/en-us/download/details.aspx?id=57594)) |
| **PhysicalNetwork** | You want physical switch and port correlation | None beyond the SCOM base packs. Requires SCOM network discovery configured against your switches via SNMP |
| **NetworkATC** | Hosts are Windows Server 2025 with Network ATC intents | None. Requires Windows Server **2025** with the `NetworkATC`, `Hyper-V`, `Failover-Clustering`, `Data-Center-Bridging`, and `FS-SMBBW` features and the `NetworkATC` PowerShell module |
| **SDN** | You run Microsoft Software Defined Networking | Windows Server SDN Monitoring MPs ([id=54300](https://www.microsoft.com/en-us/download/details.aspx?id=54300)) — import **both** the monitoring and `.Images` packs |
| **VMM** | Hosts are managed by System Center VMM | VMM management packs from your [System Center VMM installation media](https://learn.microsoft.com/en-us/system-center/vmm/) |

---

## Run As configuration

Three capabilities read from an external control plane and need credentials configured **before**
their discoveries will return data. Import will succeed without these, but the capability will stay
empty — which is harder to diagnose than a failed import.

| Capability | Run As profile | Required rights |
|---|---|---|
| **VMM** | `Microsoft.SystemCenter.VirtualMachineManager.2012.VMMServerConnectionRunAsProfile` | VMM **Read-Only Administrator**, scoped to every monitored host group, cloud, and library server |
| **SDN** | `Microsoft.Windows.10.SDNMonitoring.NCRunAsProfile` | Member of the Network Controller Clients Kerberos group; the Network Controller REST certificate must be trusted on the management server |
| **PureStorage** | `PureStorage.FlashArray.FlashArrayAdminAccount` | A FlashArray API token with read access |

---

## What each pack requires

Per-pack view of the same data — useful when a single import fails and you need to know which
external pack that specific import was waiting on.

<!-- BEGIN GENERATED: per-pack-dependencies -->
| # | Management pack | External prerequisites |
|---:|---|---|
| 1 | `HyperVPrivateCloud.Library` | _none beyond the SCOM base packs_ |
| 2 | `HyperVPrivateCloud.Discovery` | _none beyond the SCOM base packs_ |
| 3 | `HyperVPrivateCloud.Monitoring` | _none beyond the SCOM base packs_ |
| 4 | `HyperVPrivateCloud.Presentation` | _none beyond the SCOM base packs_ |
| 5 | `HyperVPrivateCloud.Capability.Cluster` | `Microsoft.Windows.Cluster.Management.Library` 10.1.0.0<br>`Microsoft.Windows.Server.ClusterSharedVolumeMonitoring` 10.1.2.2 |
| 6 | `HyperVPrivateCloud.Capability.FileServices` | `Microsoft.Windows.FileServices` 10.1.0.3<br>`Microsoft.Windows.FileServices.SMB.2016` 10.1.0.4 |
| 7 | `HyperVPrivateCloud.Capability.NetworkATC` | _none beyond the SCOM base packs_ |
| 8 | `HyperVPrivateCloud.Capability.PhysicalNetwork` | _none beyond the SCOM base packs_ |
| 9 | `HyperVPrivateCloud.Capability.S2D` | `Microsoft.Storage.Library` 1.0.0.0<br>`Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect` 1.0.0.0 |
| 10 | `HyperVPrivateCloud.Capability.SDN` | `Microsoft.Windows.10.SDNMonitoring` 10.0.0.2 |
| 11 | `HyperVPrivateCloud.Capability.Storage` | _none beyond the SCOM base packs_ |
| 12 | `HyperVPrivateCloud.Capability.VMM` | `Microsoft.SystemCenter.VirtualMachineManager.Library` 11.19.0.3<br>`Microsoft.SystemCenter.VirtualMachineManager.Discovery` 11.19.0.3<br>`Microsoft.SystemCenter.VirtualMachineManager.Monitoring` 11.19.0.3<br>`Microsoft.SystemCenter.VirtualMachineManager.PRO.V2.Library` 10.25.1200.0 |
| 13 | `HyperVPrivateCloud.Capability.PureStorage` | `PureStorageFlashArray` 2.0.120.0 |
<!-- END GENERATED: per-pack-dependencies -->

---

## Import order

Import in this order. Each pack's first-party dependencies are satisfied by everything above it, so
following this list top to bottom never produces an unresolved reference. Skip any capability you
are not using — nothing below a capability depends on it, with the single exception of Pure Storage,
which requires the Storage capability.

Import all external prerequisite packs from the table above **before** starting this sequence.

<!-- BEGIN GENERATED: import-order -->
```text
 1. HyperVPrivateCloud.Library
 2. HyperVPrivateCloud.Discovery
 3. HyperVPrivateCloud.Monitoring
 4. HyperVPrivateCloud.Presentation
 5. HyperVPrivateCloud.Capability.Cluster
 6. HyperVPrivateCloud.Capability.FileServices
 7. HyperVPrivateCloud.Capability.NetworkATC
 8. HyperVPrivateCloud.Capability.PhysicalNetwork
 9. HyperVPrivateCloud.Capability.S2D
10. HyperVPrivateCloud.Capability.SDN
11. HyperVPrivateCloud.Capability.Storage
12. HyperVPrivateCloud.Capability.VMM
13. HyperVPrivateCloud.Capability.PureStorage
```
<!-- END GENERATED: import-order -->

---

## Common gotchas

### PowerShell 7 must be the machine-wide MSI install

Every workflow launches PowerShell by absolute path:

```text
%ProgramFiles%\PowerShell\7\pwsh.exe
```

A Microsoft Store / MSIX install, a `.zip` extraction, a user-scoped install, or PowerShell 7
installed to a custom directory **does not satisfy this**. The packs import successfully and
discoveries appear healthy, but no data is ever returned — the failure is at runtime, not at import,
so it does not surface as an obvious error.

Verify on each host:

```powershell
Test-Path "$env:ProgramFiles\PowerShell\7\pwsh.exe"
```

### Pure Storage is not supported on SCOM 2025

The Pure Storage FlashArray management pack `2.0.120.0` is certified by the vendor for SCOM 2016,
2019, and 2022 only. It is **not** supported on SCOM 2025. If your management group is 2025, do not
import the PureStorage capability pack — the underlying vendor pack it depends on has not been
certified for that platform.

### Cluster requires a base library the download page does not name prominently

The Cluster capability references `Microsoft.Windows.Cluster.Library` at version **6.0.6278.0** — an
older base library distinct from `Microsoft.Windows.Cluster.Management.Library` `10.1.0.0`. The
Microsoft download bundle normally includes both, but if you have imported cluster packs
selectively in the past you may have the management library without the base library.

### Cluster nodes need agent proxy enabled

The cluster-wide monitors, the CSV capacity rules and the cluster relationship discovery
target `HyperVPrivateCloud.Capability.Cluster.ClusterRole`, which is hosted by the cluster core
virtual server (`Microsoft.Windows.Cluster.VirtualServer`) — the same object Microsoft's own
Cluster and CSV packs use. A node can only submit discovery data for an object it does not host
itself when **Allow this agent to act as a proxy** is enabled on every cluster node. Microsoft's
Cluster pack already requires this, so an existing cluster deployment normally has it; if the
`ClusterRole` object never appears, the proxy setting is the first thing to check.

### File Services pins two packs at two different versions

The download is presented as a single "File & iSCSI Services" package, but the capability references
two distinct packs at two distinct versions: `Microsoft.Windows.FileServices` **10.1.0.3** and
`Microsoft.Windows.FileServices.SMB.2016` **10.1.0.4**. Import the whole downloaded package.

### Network ATC is Windows Server 2025 only

The Network ATC capability has no external management pack dependency, but its workflows call the
`NetworkATC` PowerShell module, which exists only on Windows Server 2025. On earlier hosts the pack
imports and discovers nothing.

---

## Pre-flight checklist

**Management group**

- [ ] SCOM 2019, 2022, or 2025; Data Warehouse role healthy
- [ ] If SCOM 2025 — Pure Storage capability excluded from the plan
- [ ] Agents deployed and healthy on all Hyper-V hosts

**Hosts**

- [ ] PowerShell 7 installed machine-wide via MSI at `%ProgramFiles%\PowerShell\7\pwsh.exe`
- [ ] Windows features present for each capability you selected
- [ ] For Network ATC — hosts are Windows Server 2025

**Packs**

- [ ] Downloaded the sealed release, not a local build (`"complete": true`)
- [ ] Every external prerequisite pack from the table above imported and healthy
- [ ] Import order understood; core packs first

**Credentials**

- [ ] Run As profiles configured for VMM, SDN, and/or Pure Storage if those capabilities are in scope

---

## If an import still fails

| SCOM error mentions | Cause | Fix |
|---|---|---|
| `HyperVPrivateCloud.Presentation` | You imported from a partial local build, or skipped a core pack | Import the four core packs in order from the sealed release |
| `HyperVPrivateCloud.Library` | Core library not imported first | Import `Library` before anything else |
| `Microsoft.Windows.Cluster.*` | Windows Server Cluster MPs missing | Download and import [id=54701](https://www.microsoft.com/en-us/download/details.aspx?id=54701) |
| `Microsoft.Windows.Server.ClusterSharedVolumeMonitoring` | CSV monitoring MP missing | Download and import [id=54303](https://www.microsoft.com/en-us/download/details.aspx?id=54303) |
| `Microsoft.Storage.Library` or `...StorageSpacesDirect` | S2D MP missing | Download and import [id=100782](https://www.microsoft.com/en-us/download/details.aspx?id=100782) |
| `Microsoft.Windows.FileServices*` | File Services MPs missing | Download and import [id=57594](https://www.microsoft.com/en-us/download/details.aspx?id=57594) |
| `Microsoft.Windows.10.SDNMonitoring` | SDN MPs missing | Download and import [id=54300](https://www.microsoft.com/en-us/download/details.aspx?id=54300), both packs |
| `Microsoft.SystemCenter.VirtualMachineManager.*` | VMM MPs missing | Import from the SCVMM 2025 media |
| `PureStorageFlashArray` | Vendor MP missing, or SCOM 2025 | Import the vendor MP; on SCOM 2025 exclude this capability |
| A pack imports but stays empty | Runtime prerequisite, not an import problem | Check PowerShell 7 path, Windows features, and Run As profiles |
| A prerequisite **is** imported but the error persists | **Public key token mismatch.** A re-sealed or community-modified copy satisfies the pack ID but not the publisher token, and SCOM reports it as missing | Check the token in Administration → Management Packs → Properties against the table above. Replace it with the publisher's original |

::: tip Let SCOM fetch the Microsoft prerequisites for you
When you import from disk, the console offers an **Online Catalog Connection** prompt. Answering
**Yes** lets SCOM resolve missing dependencies from Microsoft's own management pack catalog — all the
Microsoft packs above are in it. This needs internet access from the console; on an air-gapped
management group, download them manually as described above.

This is Microsoft resolving its own packs. Nothing in this product downloads or imports a publisher's
management pack on your behalf — importing one can overwrite a pack you already depend on, and sealed
management packs cannot be downgraded afterwards.
:::

::: warning Before you uninstall
The VMM, SDN, and Pure Storage capabilities define Run As profiles. SCOM records those in
`Microsoft.SystemCenter.SecureReferenceOverride`, which will block removal of the capability pack
until the references are cleared. Plan removal accordingly rather than discovering it mid-uninstall.
:::

---

## Next steps

Once every box above is ticked, continue to the
[management pack guide](management-pack-guide.md) for the import procedure, tuning, and upgrade
steps.

## References

- [Download Hyper-V Private Cloud Monitoring](../downloads/hyper-v-private-cloud.md)
- [Management pack administration guide](management-pack-guide.md)
- [Dependency and ownership contract](../design/hyper-v/v2-dependency-and-ownership-contract.md) — design rationale for every dependency above
