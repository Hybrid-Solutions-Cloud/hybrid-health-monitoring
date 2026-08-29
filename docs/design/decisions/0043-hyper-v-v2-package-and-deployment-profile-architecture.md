# ADR 0043 — Hyper-V v2 package and deployment profile architecture

**Status:** Accepted

**Date:** 2026-08-28

**Amended:** 2026-08-29 — align generated overrides with the accepted two-file profile boundary

**Decision owners:** Repository owner and maintainers

**Supersedes for v2:** [ADR 0027](0027-hyper-v-scom-management-pack-decomposition.md)

## Context

The `0.1` preview uses five product MPs. V2 must remain useful on a standalone host while adding
optional Cluster/CSV, SAN, Pure, S2D, SOFS, Network ATC, physical network, SDN, and VMM
integrations. Putting every dependency in one library or presentation MP would make all optional
products mandatory. Splitting every capability into separate library/discovery/monitoring/
presentation artifacts would create an unmanageable import graph.

The release must also include usable Lab, Standard, and Strict unsealed override MPs. An override
MP that references an absent optional capability cannot import, so one universal override artifact
would recreate the same all-or-nothing dependency problem.

## Decision

Create v2 under `src/hyper-v/scom-mp/v2/` and namespace
`HybridSolutionsCloud.HyperVPrivateCloud`. Preserve the preview source unchanged outside that v2
root for compatibility and migration testing.

Ship four required sealed core MPs:

1. `HybridSolutionsCloud.HyperVPrivateCloud.Library`
2. `HybridSolutionsCloud.HyperVPrivateCloud.Discovery`
3. `HybridSolutionsCloud.HyperVPrivateCloud.Monitoring`
4. `HybridSolutionsCloud.HyperVPrivateCloud.Presentation`

Ship independently optional sealed capability MPs:

- `Capability.Cluster`
- `Capability.Storage`
- `Capability.PureStorage`
- `Capability.S2D`
- `Capability.FileServices`
- `Capability.NetworkATC`
- `Capability.PhysicalNetwork`
- `Capability.SDN`
- `Capability.VMM`
- optional `Reporting`

Each capability MP may contain its public types, discoveries, monitoring, relationships, DA
membership, views, tasks, and knowledge. This keeps its external references and lifecycle inside
one sealed boundary. Capability classes and relationships are still immutable after release.

The required Presentation MP defines the console root, required folders, core DA classes/branches,
and core views only. Optional capability MPs add their own folders/views beneath the public root and
populate the appropriate existing DA branch. The required Presentation MP never references an
optional external class.

Generate overrides by **tuning tier plus selected capability set**. Every release includes public,
unsealed Lab, Standard, and Strict Discovery/Monitoring pairs for every supported deployment
profile. Each generated pair references only the core, selected capability, and exact external
context MPs needed by that profile. Operators import exactly one profile/tier pair. Customer mode
creates the same two-file boundary with organization-owned IDs. No override targets the Default
Management Pack.

Publish profile manifests for:

- Standalone Hyper-V;
- Clustered SAN;
- Clustered S2D;
- Hybrid SAN and S2D;
- Hyper-V over SMB/SOFS;
- Network ATC;
- VMM-managed; and
- SDN-enabled.

Profiles are packaging/import manifests, not sealed configuration policies. They list HCS files,
external prerequisites/acquisition links, import order, selected public override files, and
checksums. Microsoft/vendor prerequisite binaries are not redistributed unless their license
explicitly permits it.

## Options considered

### One large sealed suite with every dependency

| Dimension | Assessment |
|---|---|
| Import graph | Simple but all-or-nothing |
| Standalone support | Blocked by unrelated prerequisites |
| Upgrade/removal | Highly coupled |
| Recommendation | Rejected |

### Four artifacts per capability

| Dimension | Assessment |
|---|---|
| Isolation | Maximum |
| Artifact and override count | Excessive |
| Operator usability | Poor |
| Recommendation | Rejected |

### Four core MPs plus one MP per capability

| Dimension | Assessment |
|---|---|
| Standalone support | Preserved |
| Optional dependencies | Isolated |
| Import and servicing complexity | Moderate and explicit |
| Recommendation | Accepted |

## Trade-off analysis

Capability MPs mix element categories that the core keeps separate, but their dependency and
removal boundary is more important than uniform artifact shape. Machine-readable manifests and
profile-driven packaging make the larger artifact set operable and testable.

## Consequences

- V2 is additive and side-by-side at the source/artifact identity level; preview IDs are not
  renamed or repurposed.
- Optional adapters can be installed, upgraded, or removed only in documented dependency order.
- The complete product download contains all HCS sealed artifacts, but profile manifests make
  clear which subset applies to each topology.
- Release automation must build, verify, seal, checksum, and test every supported profile graph.
- Public override artifacts are real importable MPs, generated from source and drift-tested.
- The source tree commits 66 placeholder-bearing examples: 11 profiles times three tiers times
  separate Discovery and Monitoring MPs. Governed release packaging emits corresponding
  import-ready XML with real product identity values.
- The website's latest download must provide both the complete bundle and profile-specific import
  instructions; it must not label an incomplete subset as the complete product.

## Action items

1. Add the machine-readable artifact and deployment-profile contract.
2. Scaffold deterministic v2 build inputs under `src/hyper-v/scom-mp/v2/`.
3. Extend override generation for selected capabilities and same-MP group targets.
4. Add graph tests for every profile, missing prerequisite, and dependency-safe removal order.
5. Build and seal each artifact with one governed signing identity and publish checksums.

## Related decisions

- [ADR 0022 — SCOM Management Pack packaging boundaries](0022-scom-management-pack-packaging-boundaries.md)
- [ADR 0031 — Hyper-V Management Pack authoring toolchain](0031-hyper-v-mp-authoring-toolchain.md)
- [ADR 0040 — Hyper-V v2 Microsoft S2D and SDN object ownership](0040-hyper-v-v2-microsoft-s2d-and-sdn-ownership.md)
- [ADR 0041 — Hyper-V v2 Pure Storage integration](0041-hyper-v-v2-pure-storage-integration.md)
- [ADR 0042 — Hyper-V v2 file services and physical network ownership](0042-hyper-v-v2-file-services-and-physical-network-ownership.md)
