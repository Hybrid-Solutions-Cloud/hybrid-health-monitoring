---
title: Hyper-V SCOM Management Pack
description: SCOM Management Pack for standalone, clustered, and supported SCVMM-managed Hyper-V environments.
---

# Hyper-V SCOM Management Pack

The Hyper-V SCOM Management Pack is the committed delivery surface for this platform track. It can
reuse research and engineering practices, but its runtime health model is authored independently
for the Hyper-V topology approved by the research and ADR gates.

## Implemented scope

| Capability | Implementation |
|---|---|
| Topology | Stable classes and relationships for approved standalone, clustered, and SCVMM-managed configurations |
| Discovery | Supported PowerShell 7+ and CIM/WMI discovery workflows with offline fixtures |
| Health | Availability, performance, configuration, and management domain service rollups |
| Monitoring | Unit, aggregate, and dependency monitors plus event and performance collection rules |
| Distributed Application | A Hyper-V-owned service root for every supported cluster or standalone host, with dynamic component membership, rollup, views, reports, dashboards, and SLO targeting |
| Customization | Separate customer-owned Discovery and Monitoring override MPs (`HyperVPrivateCloud.Discovery.Overrides` and `HyperVPrivateCloud.Monitoring.Overrides`) |
| Operations | State, alert, performance, and topology views with central operations diagnostic tasks |
| Release contract | Four required core MPs, nine optional capability MPs, starter override packs, manifests, and release checksums |

## Delivery state

Version `1.3.5.0` is permanently sealed, offline verified, and published in this repository. Its
public key token is `54d0fb1159995c86`.

**[Download Hyper-V Private Cloud Monitoring now](../downloads/hyper-v-private-cloud.md).**

The earlier Hyper-V `0.1.0` lab preview is superseded and must not be mixed with the current product because it has
a different signing identity and product namespace. Representative SCOM runtime and lifecycle
certification is performed after the operator installs the exact published bytes.

The comprehensive implemented design is available in the
[Hyper-V SCOM architecture map](../design/hyper-v/scom-mp.md). It covers package decomposition,
classes and relationships, staged discovery, workflows and cookdown, health and alerts, dynamic DA
membership and rollup, authoring standards, least privilege, operability, testing, and release.

The design strictly defines the sealed-versus-unsealed boundary. Discovery and Monitoring each
have a corresponding customer-owned override MP; the Default Management Pack is never used. See
the [override and tuning architecture](../design/hyper-v/override-and-tuning-architecture.md) and
the public [Management Pack administration guide](management-pack-guide.md).

The Management Pack will not inherit Azure Local-only assumptions such as solution updates, DCMA,
or the Azure Local ARM resource model. It will include Network ATC discovery and health for eligible
Windows Server 2025 Datacenter Hyper-V clusters while preserving explicit coverage for non-ATC and
SCVMM/SDN-managed networking.

The Microsoft Hyper-V 2019 Management Pack is a research reference only. This product will not
import, extend, override, or require it; useful monitoring ideas must be revalidated and implemented
independently in this project's own Management Pack.

## Phase one — implemented catalog and continuing research

The first functional MP is authored. The exhaustive inventory and evidence program continues to
refine released defaults, add lower-cardinality object monitoring, and decide which broader
candidates belong in later releases.
Twelve child Tasks separate topology, Windows Server, Hyper-V/VM, clustering/CSV, storage/Replica,
networking, prior Microsoft MP research, SCOM workflow mapping, threshold engineering, lab
validation, final catalog curation, and comprehensive architecture validation.

- [Research plan](monitoring-research.md)
- [Monitoring catalog and threshold policy](monitoring-catalog.md)
- [Comprehensive SCOM architecture](../design/hyper-v/architecture.md)
- [Distributed Application design](../design/hyper-v/distributed-application.md)
- [Management Pack administration guide](management-pack-guide.md)

The research records everything technically observable, but only actionable and supportable signals
ship enabled by default.

## Why the SCOM design is reusable

The reusable parts are substantial: class and relationship conventions, discovery workflows,
monitor types, health dimensions, rollup rules, override strategy, signing, tests, and operator
views. The platform-specific parts remain the entity inventory, discovery data sources, signal
catalog, thresholds, support matrix, and Distributed Application implementation. Research and
engineering methods can be reused; no Azure Local runtime MP is referenced.
