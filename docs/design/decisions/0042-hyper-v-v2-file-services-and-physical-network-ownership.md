# ADR 0042 — Hyper-V v2 file services and physical network ownership

**Status:** Accepted

**Date:** 2026-08-28

**Decision owners:** Repository owner and maintainers

## Context

Hyper-V private clouds can place VMs on Scale-Out File Server (SOFS) shares and depend on physical
switches, interfaces, ports, VLANs, and links. V2 needs those objects in its storage/network views
and Distributed Application without duplicating current Microsoft monitoring.

Direct inspection of Microsoft Windows Server File & iSCSI Services package `10.1.0.4` found public
File Server, File Server service, SMB service, clustered SMB service, and iSCSI Target service
classes. The package supplies SMB service, firewall, clustered continuous-availability, witness,
resume-key, VSS agent, and iSCSI Target monitoring, but no concrete SOFS role, individual SMB share,
SMB Multichannel/RDMA path, or share-to-VHDX/VM class model.

Direct inspection of the OM2022 built-in network libraries found public network node/switch,
adapter/interface/port, VLAN, and connection classes. Microsoft keys nodes by `DeviceKey`, hosted
adapters by `Key`, and provides public topology relationships including node-to-adapter,
VLAN-to-adapter, adapter peer, and network-connection-to-`System.NetworkAdapter`. Microsoft
documentation confirms that network discovery correlates network ports to connected servers.

## Decision

Use the Microsoft File & iSCSI and built-in SCOM network objects as the authoritative identities.

The optional **SMB/SOFS Integration** adapter requires Microsoft Windows Server File & iSCSI
Services package `10.1.0.4` and the matching Microsoft Cluster package for clustered deployments.
It reuses Microsoft File Server/SMB service health and Microsoft cluster groups/resources. HCS may
define only missing SOFS service projections, continuously available share instances,
Multichannel/RDMA path facts, share-to-VHDX/VM mappings, coverage state, and service-impact
relationships.

The optional **Physical Network Integration** adapter uses the built-in, matching-SCOM network
libraries. It reuses Microsoft nodes, switches, ports/interfaces, VLANs, connections, server-port
correlation, health, and performance. HCS adds private-cloud membership and dependency rollup to
hosts, host NICs, vSwitches, cluster/storage/live-migration networks, and the DA.

HCS does not submit a duplicate network node, switch, interface, port, VLAN, File Server, SMB
service, or iSCSI Target service. Existing Microsoft leaf monitors remain alert owners. Missing or
ambiguous physical correlation is Unknown/Not Monitored, never a guessed healthy relationship.

## Options considered

### Rediscover file services and network devices in HCS packs

| Dimension | Assessment |
|---|---|
| Independence | High |
| Duplicate objects and alerts | High |
| Credential and scale burden | High |
| Recommendation | Rejected |

### Use only external dashboards with no HCS relationships

| Dimension | Assessment |
|---|---|
| Duplicate monitoring | Avoided |
| Private-cloud service impact | Missing |
| End-to-end diagrams | Incomplete |
| Recommendation | Rejected |

### Reuse Microsoft objects and fill topology gaps

| Dimension | Assessment |
|---|---|
| Object identity | Authoritative |
| SOFS share-to-VM visibility | Added by HCS |
| Physical switch service impact | Added through existing topology plus HCS membership |
| Recommendation | Accepted |

## Trade-off analysis

The adapter model requires Microsoft prerequisites and conditional DA population, but it retains
the health and scale behavior already shipped with SCOM. HCS engineering is limited to the missing
private-cloud topology and coverage semantics.

## Consequences

- SOFS and physical networking remain optional; neither blocks standalone core import.
- The base presentation MP cannot reference these external classes directly.
- SOFS share discovery must use stable UNC/server/share identity and reconcile ownership changes.
- Host-to-switch diagrams use Microsoft-discovered topology. If no supported correlation exists,
  operators receive a coverage state and may supply an explicit mapping in a customer-owned
  discovery override MP.
- SNMP credentials remain in SCOM Run As accounts; HCS does not copy or store them.
- Performance collection and port monitoring defaults remain Microsoft-owned and are tuned only in
  a separate customer override MP.

## Action items

1. Encode exact package/MP/class/relationship contracts in the dependency manifest.
2. Define SOFS share, Multichannel/RDMA path, VHDX, and VM mapping identities.
3. Define DA membership over existing network connection and adapter relationships.
4. Test standalone SMB, clustered SOFS, node failover, share loss, witness loss, RDMA path loss,
   switch/port loss, missing SNMP, ambiguous correlation, and removal.

## References

- [Windows Server File & iSCSI Services MP 10.1.0.4](https://www.microsoft.com/en-us/download/details.aspx?id=57594)
- [Monitoring networks by using Operations Manager](https://learn.microsoft.com/en-us/system-center/scom/manage-monitor-networkdevice-overview?view=sc-om-2025)
- [Discover network devices in Operations Manager](https://learn.microsoft.com/en-us/system-center/scom/manage-monitor-networkdevice-discover?view=sc-om-2025)
- [V2 dependency and ownership contract](../hyper-v/v2-dependency-and-ownership-contract.md)

## Related decisions

- [ADR 0025 — Hyper-V network-management authority](0025-hyper-v-network-management-authority.md)
- [ADR 0040 — Hyper-V v2 Microsoft S2D and SDN object ownership](0040-hyper-v-v2-microsoft-s2d-and-sdn-ownership.md)
- [ADR 0041 — Hyper-V v2 Pure Storage integration](0041-hyper-v-v2-pure-storage-integration.md)
