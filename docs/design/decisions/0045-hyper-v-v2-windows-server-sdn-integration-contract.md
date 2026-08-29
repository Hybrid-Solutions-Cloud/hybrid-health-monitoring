# ADR 0045 — Hyper-V v2 Windows Server SDN integration contract

**Status:** Accepted

**Date:** 2026-08-28

**Decision owners:** Repository owner and maintainers

## Context

Microsoft publishes a supported Windows Server Software Defined Networking Management Pack. The
inspected `Microsoft.Windows.10.SDNMonitoring` `10.0.0.2` pack already owns Network Controller
REST discovery, its Run As profile, the SDN stamp and leaf topology, 78 unit monitors, 22 dependency
monitors, 45 rules, 15 views, alerts, and performance collection. Reimplementing that work would
create competing identities, credentials, probes, and alerts.

The private-cloud suite still needs to place authoritative Microsoft SDN health in its Management
and Networking service branches. Inspection also found two specific rollup gaps: Network
Controller node `SecurityState` is not rolled into the Microsoft controller group, and the
Microsoft stamp rollup does not include the gateway pool group.

A Hyper-V host can expose local SDN binding evidence in the `NcHostAgent` `HostId` registry value
and the `NcHostAgent` and `SlbHostAgent` services. Microsoft documents that local `HostId` as the
Network Controller server `InstanceId`. The Microsoft SCOM SDN Host class, however, is keyed by the
Network Controller resource `ResourceId`. Those identifiers must not be treated as interchangeable.

Network ATC and Windows Server SDN are not inherently exclusive. Network ATC can own host physical
adapter, SET switch, and intent configuration while Network Controller owns overlay and SDN policy.
Microsoft's Windows Server hardware-validation guidance explicitly identifies the Network ATC
Compute-intent switch as the SDN switch in that topology.

## Decision

Ship `HybridSolutionsCloud.HyperVPrivateCloud.Capability.SDN` as an optional sealed adapter with a
hard dependency on `Microsoft.Windows.10.SDNMonitoring` `10.0.0.2`. Operators must import and fully
configure both Microsoft SDN MPs, the documented Run As account/profile, Network Controller node
management, and certificate trust before importing the HCS adapter.

Microsoft remains authoritative for every SDN stamp, controller, host, virtual network, ACL,
network interface, MUX, gateway, network connection, BGP, discovery, credential, leaf monitor,
alert, performance rule, and native view. The HCS adapter must not query Network Controller REST,
use the Microsoft Run As credential, submit Microsoft-owned leaf objects with guessed keys, or
create duplicate symptom alerts.

HCS may add only:

1. one hosted, read-only `HostBinding` evidence object carrying the local Network Controller
   `HostId` and host-agent service states;
2. relationships from the HCS Management and Networking branches to Microsoft's fixed-key stamp
   and group objects;
3. one integration-health monitor for missing or degraded local host-binding prerequisites;
4. the verified missing Network Controller security rollup and private-cloud service-impact
   rollups; and
5. curated SDN views beneath the Hyper-V Private Cloud console root.

The local `HostId` is diagnostic evidence only. The adapter must not fabricate a relationship to a
Microsoft SDN Host unless a future supported contract supplies an unambiguous `ResourceId` mapping.

Network authority is layered, not a single mutually exclusive enum. The product may simultaneously
install Physical Network, Network ATC, SDN, and VMM capability packs when each owns a distinct
layer. The topology must avoid enrolling the same object in duplicate health paths, but it must not
disable legitimate ATC host-network monitoring merely because SDN overlay management is present.

## Options considered

### Reimplement SDN discovery and monitoring in HCS

Rejected. It duplicates Microsoft's supported REST, credential, topology, health, alert, and
performance implementation and materially increases security and compatibility risk.

### Correlate a local host directly to the Microsoft SDN Host by `HostId`

Rejected. The local value represents Network Controller `InstanceId`; the Microsoft class key is
the resource `ResourceId`. A plausible-looking but false relationship is worse than an explicit
uncorrelated state.

### Make Network ATC and SDN mutually exclusive

Rejected. They can be authoritative at different layers in a supported deployment. Exclusivity is
required only for duplicate ownership of the same resource or health path.

## Consequences

- The HCS capability is small, read-only, and aligned with Microsoft's supported SDN model.
- The Microsoft SDN MP setup is a mandatory, documented prerequisite rather than hidden HCS
  credential handling.
- Private-cloud Management health includes controller availability, configuration, performance,
  and certificate security; Networking includes hosts, virtual networks, ACLs, interfaces, MUXes,
  and gateways.
- Local binding failures are actionable without inventing a Microsoft Host identity.
- Network ATC, SDN, VMM, and physical-network adapters can coexist when their ownership layers and
  health membership are explicit.
- Representative labs must prove Microsoft discovery, Run As and certificate configuration,
  branch population, controller/security and gateway rollup, host-agent failure/recovery, and clean
  capability removal.

## Related decisions

- [ADR 0025 — Hyper-V network-management authority](0025-hyper-v-network-management-authority.md)
- [ADR 0040 — Hyper-V v2 Microsoft S2D and SDN ownership](0040-hyper-v-v2-microsoft-s2d-and-sdn-ownership.md)
- [ADR 0043 — Hyper-V v2 package and deployment profile architecture](0043-hyper-v-v2-package-and-deployment-profile-architecture.md)
- [ADR 0044 — Hyper-V v2 Network ATC monitoring contract](0044-hyper-v-v2-network-atc-monitoring-contract.md)

## Sources

- [Windows Server SDN Management Pack 10.0.0.2](https://www.microsoft.com/en-us/download/details.aspx?id=54300)
- [Troubleshoot the Windows Server SDN stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)
- [Deploy an SDN infrastructure in VMM](https://learn.microsoft.com/en-us/system-center/vmm/deploy-sdn?view=sc-vmm-2025)
- [Network Controller on Service Fabric](https://learn.microsoft.com/en-us/windows-server/networking/sdn/technologies/network-controller/network-controller-service-fabric)
- [Network Controller on Failover Clustering](https://learn.microsoft.com/en-us/windows-server/networking/sdn/technologies/network-controller/network-controller-failover-clustering)
- [Host networking with Network ATC](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/network-atc)
- [Windows Server 2025 Azure Stack HCI networking test](https://learn.microsoft.com/en-us/windows-hardware/test/hlk/testref/device.network.lan.azurestack-testing-server-2025)
