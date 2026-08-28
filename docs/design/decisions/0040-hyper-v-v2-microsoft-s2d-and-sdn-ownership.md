# ADR 0040 — Hyper-V v2 Microsoft S2D and SDN object ownership

**Status:** Accepted

**Date:** 2026-08-28

**Decision owners:** Repository owner and maintainers

**Supersedes:** [ADR 0039](0039-hyper-v-v2-external-object-ownership.md)

## Context

ADR 0039 correctly chose a standalone core plus optional dependency adapters, and correctly made
Microsoft's current Failover Cluster and CSV objects authoritative. It incorrectly classified S2D
topology as an HCS-owned gap and left the SDN contract pending because those Microsoft packages had
not yet been inspected.

Direct inspection of Microsoft's sealed packages changed the evidence:

- Storage Spaces Direct MP `1.0.47.4` exposes public storage subsystem, node, physical disk, pool,
  virtual disk, volume, and file-share classes. Its public base library keys arrays, disks, nodes,
  pools, volumes, and shares by `UniqueID`; the pack also supplies topology relationships,
  discoveries, health monitors, performance rules, and presentation.
- Windows Server SDN MP `10.0.0.2` exposes public stamp, Network Controller node, host, virtual
  network, ACL, network interface, load-balancer MUX, virtual gateway, connection, BGP router/peer,
  gateway-pool, and gateway classes. Non-singleton resources use public `Id` keys and the pack
  supplies hosting relationships, health monitoring, collection, and views.

Creating parallel HCS classes for these same resources would fragment Health Explorer, alerts,
performance, diagrams, maintenance, and upgrade behavior. Making either package a core dependency
would prevent standalone and non-S2D/non-SDN environments from importing the base product.

## Decision

Keep the **Hyper-V Private Cloud Monitoring** product identity, console root **Hyper-V Private
Cloud**, new namespace `HybridSolutionsCloud.HyperVPrivateCloud`, and standalone-core plus optional
adapter architecture established by ADR 0039.

Make Microsoft's supported S2D and SDN objects authoritative:

- The optional S2D adapter requires Microsoft Storage Spaces Direct package `1.0.47.4` or a later
  lab-certified compatible version. It relates Microsoft S2D objects to Microsoft cluster/CSV
  objects, Hyper-V storage mappings, VHDX/VM impact, SAN coexistence, and the HCS service model.
- The optional SDN adapter requires Microsoft Windows Server SDN package `10.0.0.2` or a later
  lab-certified compatible version. It relates Microsoft SDN objects to Hyper-V hosts/VMs,
  physical networking, VMM fabric where present, and the HCS service model.
- HCS does not rediscover or duplicate any S2D or SDN resource already represented by a stable
  public Microsoft class. HCS may add only verified missing concepts, cross-domain correlations,
  monitoring-coverage state, and private-cloud service-impact relationships.
- External Microsoft leaf monitors remain the alert authority. HCS dependency rollups do not
  generate duplicate symptom alerts.
- S2D and SAN are independent capabilities and may be enabled simultaneously.

The same rule remains in force for Cluster, CSV, VMM, Pure Storage, SOFS/SMB, and physical network
dependencies: use supported public vendor objects for the same real resource, and isolate each
optional dependency in an adapter MP.

## Options considered

### Duplicate S2D and SDN topology in HCS packs

| Dimension | Assessment |
|---|---|
| Coverage | Can fill gaps but duplicates the primary resource model |
| Operator experience | Split health, alerts, performance, and diagrams |
| Upgrade safety | High collision and identity-drift risk |
| Recommendation | Rejected |

### Make Microsoft S2D and SDN packages core dependencies

| Dimension | Assessment |
|---|---|
| Import simplicity | One fixed graph |
| Standalone/non-S2D/non-SDN support | Unnecessarily blocked |
| Removal and upgrade coupling | High |
| Recommendation | Rejected |

### Optional adapters over Microsoft-owned objects

| Dimension | Assessment |
|---|---|
| Object identity | Authoritative and traversable |
| Standalone support | Preserved |
| Optional capability lifecycle | Independently installable/removable |
| Engineering effort | Requires explicit relationships and compatibility tests |
| Recommendation | Accepted |

## Trade-off analysis

The adapter model produces more sealed artifacts and requires a versioned compatibility matrix,
but it avoids two monitoring products claiming the same resource. It also lets customers install
only the capabilities they operate while retaining one private-cloud DA and console experience.

## Consequences

- ADR 0039 is superseded in full; its general adapter decision is carried forward here.
- The v2 S2D and SDN packs cannot import until their matching Microsoft prerequisites are present.
- Core compute remains usable with neither prerequisite installed.
- HCS S2D/SDN development starts with gap and relationship analysis, not replacement discovery.
- Presentation and DA population that reference Microsoft S2D or SDN types must live in or behind
  the corresponding optional adapter.
- Import, upgrade, side-by-side, missing-dependency, and removal tests are required for both
  adapters before release.

## Action items

1. Encode both verified packages, public classes, and acquisition links in the dependency contract.
2. Inventory existing Microsoft workflows before authoring any HCS S2D or SDN monitor.
3. Define and test only missing correlations, coverage monitors, and service-impact rollups.
4. Validate S2D alone, SAN alone, and simultaneous SAN/S2D operation.
5. Validate SDN with and without VMM integration and with missing optional dependencies.

## References

- [V2 dependency and ownership contract](../hyper-v/v2-dependency-and-ownership-contract.md)
- [Storage Spaces Direct Management Pack 1.0.47.4](https://www.microsoft.com/en-us/download/details.aspx?id=100782)
- [Windows Server SDN Management Pack 10.0.0.2](https://www.microsoft.com/en-us/download/details.aspx?id=54300)
- [Windows Server Cluster Management Pack 10.1.0.0](https://www.microsoft.com/en-us/download/details.aspx?id=54701)
- [Windows Server Operating System Management Pack 10.1.2.2](https://www.microsoft.com/en-us/download/details.aspx?id=54303)

## Related decisions

- [ADR 0022 — SCOM Management Pack packaging boundaries](0022-scom-management-pack-packaging-boundaries.md)
- [ADR 0027 — Hyper-V SCOM Management Pack decomposition](0027-hyper-v-scom-management-pack-decomposition.md)
- [ADR 0028 — Hyper-V object and discovery architecture](0028-hyper-v-object-and-discovery-architecture.md)
- [ADR 0029 — Hyper-V health, alert, and DA rollup](0029-hyper-v-health-alert-and-da-rollup.md)
