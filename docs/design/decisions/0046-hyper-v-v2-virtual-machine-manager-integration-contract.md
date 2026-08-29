# ADR 0046 — Hyper-V v2 Virtual Machine Manager integration contract

- **Status:** Accepted
- **Date:** 2026-08-28
- **Decision owners:** Hybrid Solutions Cloud maintainers

## Context

Hyper-V Private Cloud Monitoring must represent environments managed by System Center Virtual
Machine Manager without creating a second VMM inventory or duplicating Microsoft alerts. Microsoft
documents that VMM and Operations Manager integration imports VMM-build-specific Management Packs,
populates objects through the Operations Manager SDK, and requires matching VMM/Operations Manager
components. The VMM 2025 installation media ships its Management Packs under
`C:\Program Files\Microsoft System Center\Virtual Machine Manager\ManagementPacks`.

The official System Center 2025 media was downloaded and hash-checked against Microsoft's published
SHA-256 value. Direct sealed-package inspection established this public contract:

| Management Pack | Version | Public key token |
|---|---:|---|
| `Microsoft.SystemCenter.VirtualMachineManager.Library` | `11.19.0.3` | `31bf3856ad364e35` |
| `Microsoft.SystemCenter.VirtualMachineManager.Discovery` | `11.19.0.3` | `31bf3856ad364e35` |
| `Microsoft.SystemCenter.VirtualMachineManager.Monitoring` | `11.19.0.3` | `31bf3856ad364e35` |
| `Microsoft.SystemCenter.VirtualMachineManager.PRO.V2.Library` | `10.25.1200.0` | `31bf3856ad364e35` |

The inspected VMM model owns management servers, private clouds, host groups, host clusters,
Hyper-V hosts, virtual machines, VM networks, virtual switches and ports, pools, fabric health,
alerts, performance, dashboards, reporting, and PRO integration. Its public model does not expose
logical networks, logical network definitions (network sites), or VMM jobs as SCOM classes or
workflows.

Microsoft documents `Get-SCLogicalNetwork`, `Get-SCLogicalNetworkDefinition`, `Get-SCVMNetwork`,
and `Get-SCJob` as supported VMM read cmdlets. Microsoft also documents that the VMM Read-Only
Administrator role can view object properties, status, and job status within its assigned scope.

## Decision

Ship `HybridSolutionsCloud.HyperVPrivateCloud.Capability.VMM` as an optional, sealed, thin adapter
for the exact inspected System Center 2025 VMM contract.

Microsoft VMM Management Packs remain authoritative for every object and workflow they publish.
The HCS adapter:

- creates no replacement VMM server, cloud, host group, cluster, host, VM, VM network, virtual
  switch, port, pool, or storage class;
- never reads the VMM database directly;
- never restarts, repairs, retries, or changes VMM or fabric configuration;
- creates a VMM-fabric service root and its standard HCS Distributed Application branches;
- relates exact Microsoft VMM servers, Hyper-V hosts, private clouds, and VM networks into that
  service graph and into matching local Hyper-V host or cluster boundaries;
- projects only the verified missing `LogicalNetwork` and `NetworkSite` objects, keyed by VMM
  server and VMM GUID;
- queries recent jobs with `Get-SCJob` and alerts only on `Failed` status during an overrideable
  lookback period; and
- rolls Microsoft VMM server/cloud health and only the VMM-specific host WinRM and VMM-agent
  version monitors into HCS health. It does not roll up Microsoft's duplicate host CPU, memory,
  or Hyper-V service monitors.

VMM queries run through Microsoft's public
`Microsoft.SystemCenter.VirtualMachineManager.2012.VMMServerConnectionRunAsProfile`. The assigned
account must have at least VMM Read-Only Administrator access across every monitored host group,
cloud, and library server. VMM administrator access is required to configure the Microsoft
integration, but it is not the runtime permission baseline for HCS read workflows.

The first adapter support lane is System Center 2025 VMM with the exact identities above. VMM
Management Packs are build-coupled, so compatibility with VMM 2019, 2022, or a later 2025 update
must not be inferred from similar element IDs. Each lane requires separate package inspection,
VSAE resolution, representative import, topology, fault, upgrade, and removal certification.

## Consequences

- Operators receive VMM fabric service health, private-cloud traversal, logical networks, network
  sites, VM networks, failed jobs, topology views, active-alert views, and performance views under
  the Hyper-V Private Cloud console root.
- Microsoft dashboards remain installed and supported in Microsoft's native VMM console folder;
  HCS provides ordinary state, alert, and performance views without copying their dashboard
  definitions.
- A failed VMM connection or missing matching console/module is Critical and actionable. A failed
  job is Critical by default; its lookback window and critical count are customer overrides.
- The `ClusterNames` property is used only for exact private-cloud-to-cluster correlation. Its
  delimiter and lifecycle behavior remain a representative-lab release gate. Standalone VMM hosts
  are correlated by the shared hosted Windows Computer identity instead of cloud-name inference.
- HCS Hyper-V VM IDs are not assumed to equal VMM database IDs. Direct HCS-to-VMM VM identity
  merging is deferred until a representative lab proves a stable equality contract.
- The adapter can be omitted without affecting standalone or non-VMM-managed Hyper-V monitoring.

## Rejected alternatives

### Recreate the complete VMM fabric through PowerShell or SQL

Rejected because Microsoft already owns the supported SDK population, topology, monitoring,
maintenance integration, reports, and dashboards. A second model would create duplicate objects,
alerts, security paths, and incompatible lifecycle behavior. Direct VMM database access is also not
part of this product contract.

### Depend only on the VMM library and synthesize Microsoft concrete objects

Rejected because concrete objects are populated by the build-matched Discovery pack through the
Operations Manager SDK. Synthesizing them would risk incorrect hosting and key chains.

### Ignore logical networks, network sites, and jobs

Rejected because they are material private-cloud operator surfaces and are verified gaps in the
inspected SCOM projection. Supported read cmdlets and a least-privilege VMM role provide a bounded,
read-only way to fill those gaps.

### Support every VMM release from one inspected package

Rejected because Microsoft explicitly couples the Management Packs to the installed VMM build.
Sharing a namespace or element ID is not proof of binary or runtime compatibility.

## Validation gates

1. Resolve and verify the adapter against the exact sealed VMM 2025 packages and OM2022 authoring
   libraries, then transiently seal and strong-name verify it.
2. Import Microsoft VMM integration first, configure the public VMM Run As profile with a scoped
   read-only account, and import the HCS adapter afterward.
3. Prove VMM server, host, cloud, logical-network, network-site, and VM-network discovery and
   lifecycle behavior in a representative SCOM 2025/VMM 2025 management group.
4. Prove failed-job detection, recovery after the lookback window, permission failure, VMM outage,
   management-server failover, and no-remediation behavior.
5. Prove local standalone/cluster DA correlation, VMM fabric DA population, cloud `ClusterNames`
   parsing, coexistence with Network ATC and SDN, upgrade, removal, and historical-data behavior.
6. Do not claim VMM 2019, VMM 2022, or future VMM 2025 build support until its exact package and
   representative runtime lane passes the same gates.

## Sources

- [Integrate VMM with Operations Manager](https://learn.microsoft.com/en-us/system-center/vmm/monitors-ops-manager?view=sc-vmm-2025)
- [Monitor VMM fabric in Operations Manager](https://learn.microsoft.com/en-us/system-center/scom/fabric-monitoring?view=sc-om-2025)
- [System Center VMM release build versions](https://learn.microsoft.com/en-us/system-center/vmm/release-build-versions?view=sc-vmm-2025)
- [Install VMM 2025 and verify media checksum](https://learn.microsoft.com/en-us/system-center/vmm/install?view=sc-vmm-2025)
- [`Get-SCLogicalNetwork`](https://learn.microsoft.com/en-us/powershell/module/virtualmachinemanager/get-sclogicalnetwork?view=systemcenter-ps-2025)
- [`Get-SCLogicalNetworkDefinition`](https://learn.microsoft.com/en-us/powershell/module/virtualmachinemanager/get-sclogicalnetworkdefinition?view=systemcenter-ps-2025)
- [`Get-SCVMNetwork`](https://learn.microsoft.com/en-us/powershell/module/virtualmachinemanager/get-scvmnetwork?view=systemcenter-ps-2025)
- [`Get-SCJob`](https://learn.microsoft.com/en-us/powershell/module/virtualmachinemanager/get-scjob?view=systemcenter-ps-2025)
- [Manage VMM roles and permissions](https://learn.microsoft.com/en-us/system-center/vmm/manage-account?view=sc-vmm-2025)
