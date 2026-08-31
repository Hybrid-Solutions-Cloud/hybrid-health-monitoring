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

## Current release: 1.0.0.0

All 13 product Management Packs are sealed with the permanent public key token
`54d0fb1159995c86`, verified by Microsoft VSAE, strong-name checked, and covered by the published
SHA-256 manifest. The release contains 13 sealed Management Packs, 66 public override packs, and 14
deterministic bundles.

Management Packs are named for the product — `HyperVPrivateCloud.Library`,
`HyperVPrivateCloud.Capability.Cluster`, and so on. Publisher attribution is carried in the sealed
pack `Company` and `Copyright` metadata rather than in the pack ID.

::: warning Upgrading from 2.0.0.0 is not an in-place upgrade
The earlier `2.0.0.0` package used `HybridSolutionsCloud.HyperVPrivateCloud.*` identities. SCOM
treats a renamed Management Pack as an unrelated pack, so the old packs must be **removed** before
these are imported — which discards stored overrides and accumulated health state.

Export any customer-owned override Management Packs first, then re-apply them against the new pack
IDs after importing. Reasoning and detail in
[ADR 0049](../design/decisions/0049-product-named-management-pack-identity.md).

The version line restarts at `1.0.0.0` because this is a new pack identity with no prior release.
:::

## Download now

- **[Download the complete package](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Complete.zip)** — all four core MPs, all nine capability MPs, and all 66 public override MPs.
- [Download the four core MPs](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Core.zip) — Library, Discovery, Monitoring, and Presentation.
- [Download all public overrides](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Overrides.zip) — 11 deployment profiles with Lab, Standard, and Strict Discovery/Monitoring pairs.
- [Download SHA-256 checksums](/downloads/hyper-v-private-cloud/latest/SHA256SUMS.txt)
- [View the release manifest](/downloads/hyper-v-private-cloud/latest/release-manifest.json)
- [View the public asset manifest](/downloads/hyper-v-private-cloud/latest/release-assets.json)

The immutable versioned files are also retained under
[`1.0.0.0`](/downloads/hyper-v-private-cloud/1.0.0.0/release-assets.json). The `latest` directory
serves the same exact bytes and changes only when a newer validated version is published.

The superseded [`2.0.0.0`](/downloads/hyper-v-private-cloud/2.0.0.0/release-assets.json) assets are
retained unchanged as release evidence. They carry the previous
`HybridSolutionsCloud.HyperVPrivateCloud.*` identities and should not be imported for a new
deployment.

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
