# ADR 0039 — Hyper-V v2 external object ownership and optional dependencies

**Status:** Accepted

**Date:** 2026-08-28

**Decision owners:** Repository owner and maintainers

## Context

The Hyper-V preview independently discovers a cluster boundary and Cluster Shared Volumes while
declaring no dependency on the Microsoft Cluster or Windows Server CSV Management Packs. That is
self-contained, but it duplicates resources already modeled and monitored by Microsoft's current
supported packs and prevents native traversal from the HCS service into those objects.

V2 must be comprehensive for standalone, clustered SAN, S2D, mixed SAN/S2D, VMM, SDN, and vendor
storage environments without forcing every optional product into every installation. Released
preview element IDs are immutable, so the redesign cannot silently rebase or rename those classes.

Direct inspection of Microsoft's sealed packages confirmed that the current Cluster MP exposes
public cluster node, group, network, resource, service, and containment contracts, while the
current Windows Server OS package exposes public CSV objects and monitoring. The built-in Cluster
Library alone does not provide that complete model.

## Decision

Create v2 as **Hyper-V Private Cloud Monitoring**, with console root **Hyper-V Private Cloud** and
new internal namespace `HybridSolutionsCloud.HyperVPrivateCloud`.

The core compute product retains only built-in SCOM dependencies. Optional adapter/capability MPs
take explicit dependencies on supported sealed Microsoft or vendor MPs and add HCS-owned
relationships, service projections, rollups, views, and missing domain objects.

The Failover Cluster adapter requires the Microsoft Windows Server Cluster 2016 and above package,
minimum `10.1.0.0`. The CSV adapter requires the Windows Server Operating System 2016 and above
package including `Microsoft.Windows.Server.ClusterSharedVolumeMonitoring`, minimum `10.1.2.2`.
V2 reuses their public cluster, node, network, resource, disk, and CSV identities rather than
creating competing copies.

HCS owns only missing concepts and explicit service-impact correlations, including the private
cloud service boundary, Hyper-V-specific VM/host/network projections, S2D objects not exposed by
the inspected packs, SAN path-to-LUN-to-volume-to-VHDX-to-VM maps, and optional vendor/VMM/SDN
adapters. SAN and S2D discovery are independent and can operate simultaneously.

## Options considered

### Self-contained duplicate topology

| Dimension | Assessment |
|---|---|
| Standalone import | Simple |
| Console topology | Duplicate cluster and CSV objects |
| Service traversal | HCS-only; disconnected from Microsoft/vendor views |
| Lifecycle risk | High because two discoveries own the same real resources |

### Hard-wire every dependency into one product

| Dimension | Assessment |
|---|---|
| Coverage | Broad when every prerequisite is installed |
| Standalone import | Poor; unrelated products become mandatory |
| Upgrade/removal | Large coupled dependency graph |
| Vendor extensibility | Poor |

### Core plus explicit capability adapters

| Dimension | Assessment |
|---|---|
| Coverage | Broad and composable |
| Standalone import | Preserved |
| Object ownership | Uses authoritative sealed public contracts |
| Engineering effort | Higher; requires correlation and per-adapter testing |

## Trade-off analysis

Adapters require more packages and a stronger compatibility matrix, but they preserve authoritative
object identity and keep optional products optional. This produces a better SCOM operator
experience than duplicate topology and avoids turning Pure, VMM, SDN, S2D, or Failover Clustering
into universal prerequisites.

## Consequences

- V2 is a new product namespace; preview migration is explicit rather than an in-place rename.
- Clustered installs must import the documented Microsoft prerequisites first.
- The full package can include multiple sealed MPs, but the base installation remains useful on a
  standalone host.
- Presentation and DA population for optional domains live behind the same optional dependency.
- External leaf monitors remain alert owners; HCS rollups normally do not generate duplicate
  symptom alerts.
- VMM, SDN, Pure, SOFS, and physical-network contracts remain gated until their exact public
  classes, keys, versions, and support statements are inspected.

## Action items

1. Implement the v2 core and compatibility detector in the new namespace.
2. Implement Cluster and CSV adapters against the verified Microsoft contracts.
3. Complete and record VMM, SDN, Pure, SOFS, and physical-network contract spikes.
4. Add dependency-graph CI checks and representative import/upgrade/removal labs for every adapter.
5. Publish prerequisite acquisition links, supported versions, import order, checksums, and
   migration instructions with the sealed release.

## References

- [V2 dependency and ownership contract](../hyper-v/v2-dependency-and-ownership-contract.md)
- [Microsoft Management Packs](https://learn.microsoft.com/en-us/system-center/scom/management-pack-list?view=sc-om-2025)
- [Monitoring Failover Cluster with Operations Manager](https://learn.microsoft.com/en-us/system-center/scom/manage-monitor-clusters-overview?view=sc-om-2025)
- [Windows Server Cluster 2016 and above MP](https://www.microsoft.com/en-us/download/details.aspx?id=54701)
- [Windows Server Operating System 2016 and above MP](https://www.microsoft.com/en-us/download/details.aspx?id=54303)

## Related decisions

- [ADR 0022 — SCOM Management Pack packaging boundaries](0022-scom-management-pack-packaging-boundaries.md)
- [ADR 0027 — Hyper-V SCOM Management Pack decomposition](0027-hyper-v-scom-management-pack-decomposition.md)
- [ADR 0028 — Hyper-V object and discovery architecture](0028-hyper-v-object-and-discovery-architecture.md)

