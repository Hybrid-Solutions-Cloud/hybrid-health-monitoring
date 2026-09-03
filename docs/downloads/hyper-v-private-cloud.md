---
title: Download Hyper-V Private Cloud Monitoring
description: Sealed SCOM Management Packs, public override packs, manifests, and checksums for Hyper-V Private Cloud Monitoring.
---

# Download Hyper-V Private Cloud Monitoring

Sealed SCOM Management Packs for Hyper-V private cloud infrastructure — four required core packs,
nine optional capability packs, and public override starters for 11 deployment profiles.

::: tip Read the prerequisites first
The Microsoft and vendor Management Packs each capability requires are **not** redistributed here,
and a missing one is the most common cause of a failed import. Work through the
[prerequisites](../hyper-v/prerequisites.md) before downloading anything.
:::

## Current release: 1.0.3.0

`1.0.3.0` is an additive, in-place corrective upgrade over `1.0.2.0`. Live SCOM 2025 certification
found two discovery blockers: the registry seed could not create `HostRole` before topology
supplied its boundary, and valid S2D/VMM relationship discovery data could be rejected when the
PowerShell child process did not terminate explicitly with exit code zero. Both are corrected and
guarded by regression tests. All 13 product Management Packs
are sealed with the permanent public key token `54d0fb1159995c86`, verified by Microsoft VSAE,
strong-name checked, and covered by the published SHA-256 manifest. The release contains 13 sealed
Management Packs, 66 public override packs, and 14 deterministic bundles: 162 unit monitors, 111
dependency roll-ups, 80 rules, 22 discoveries, 116 views, 63 operator tasks plus 4 console tasks,
and 234 knowledge articles across host, VM, Failover Clustering, CSV, Storage Spaces Direct, SAN
(Fibre Channel, iSCSI, MPIO), SMB/SOFS, Network ATC, physical networking, SDN host binding, VMM and
Pure Storage. Cluster-wide facts are evaluated once per cluster, host-wide facts once per host, and
one probe run per host feeds every per-VM, per-LUN, per-session, per-port and per-intent monitor
([ADR 0053](../design/decisions/0053-management-pack-review-and-runtime-correctness.md),
[ADR 0054](../design/decisions/0054-the-real-1000-version-reset.md)).

Management Packs are named for the product — `HyperVPrivateCloud.Library`,
`HyperVPrivateCloud.Capability.Cluster`, and so on. Publisher attribution is carried in the sealed
pack `Company` and `Copyright` metadata rather than in the pack ID.

## Download now

- **[Download the complete package](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Complete.zip)** — all four core MPs, all nine capability MPs, and all 66 public override MPs.
- [Download the four core MPs](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Core.zip) — Library, Discovery, Monitoring, and Presentation.
- [Download all public overrides](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Overrides.zip) — 11 deployment profiles with Lab, Standard, and Strict Discovery/Monitoring pairs.
- [Download SHA-256 checksums](/downloads/hyper-v-private-cloud/latest/SHA256SUMS.txt)
- [View the release manifest](/downloads/hyper-v-private-cloud/latest/release-manifest.json)
- [View the public asset manifest](/downloads/hyper-v-private-cloud/latest/release-assets.json)

The immutable versioned files are also retained under
[`1.0.3.0`](/downloads/hyper-v-private-cloud/1.0.3.0/release-assets.json). The `latest` directory
serves the same exact bytes and changes only when a newer validated version is published.
The previous release stays under [`1.0.2.0`](/downloads/hyper-v-private-cloud/1.0.2.0/release-assets.json).
Engineering builds published briefly during 2026-08-30/31 were withdrawn before any deployment
([ADR 0054](../design/decisions/0054-the-real-1000-version-reset.md)).

## Apply a tuning profile in one command

After the core and capability packs are in, apply one deployment profile's tuning tier without
digging through the zip:

```powershell
iwr https://labs.hybridsolutions.cloud/hybrid-health-monitoring/downloads/hyper-v-private-cloud/tools/Install-HyperVPrivateCloudOverrides.ps1 -OutFile Install-HyperVPrivateCloudOverrides.ps1
./Install-HyperVPrivateCloudOverrides.ps1 -DeploymentProfile ClusteredSAN -TuningTier Standard -Import
```

Run it as a file (not pasted line-by-line). Pick the profile matching the capability packs you
imported; import exactly one Discovery + Monitoring pair per management group. `Standard` is the
coded defaults made explicit; `Lab` is forgiving; `Strict` is tight.

## Deployment-profile bundles

Use a profile bundle when you want only the sealed MPs and six starter override files for one
topology. Import exactly one override tier's Discovery and Monitoring pair after reviewing it.

| Profile | Download |
|---|---|
| Standalone | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-Standalone.zip) |
| Clustered SAN | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-ClusteredSAN.zip) |
| Clustered Pure Storage | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-ClusteredPure.zip) |
| Clustered S2D | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-ClusteredS2D.zip) |
| Hybrid SAN and S2D | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-HybridSANAndS2D.zip) |
| Hybrid Pure and S2D | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-HybridPureAndS2D.zip) |
| Hyper-V over SMB | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-HyperVOverSMB.zip) |
| Network ATC | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-NetworkATC.zip) |
| SDN enabled | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-SDNEnabled.zip) |
| VMM managed | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-VMMManaged.zip) |
| Complete private cloud | [Download](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Profile-CompletePrivateCloud.zip) |

## Before import

The HCS ZIPs do not redistribute Microsoft, VMM, or Pure Storage prerequisite Management Packs.
Install only the capability adapters your environment uses, and satisfy their publisher-owned
dependencies first. Review the [administration guide](../hyper-v/management-pack-guide.md) for the
dependency matrix and import order.

SCOM runtime validation is intentionally performed after download and installation in the
operator's isolated management group. Use the included diagnostics and the repository's
certification collector to record that evidence; any verified defect is corrected in a
version-increased release.
