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

## Current release: 1.4.0.0

All 13 product Management Packs are sealed with the permanent public key token
`54d0fb1159995c86`, verified by Microsoft VSAE, strong-name checked, and covered by the published
SHA-256 manifest. The release contains 13 sealed Management Packs, 66 public override packs, and 14
deterministic bundles: 162 unit monitors, 96 dependency roll-ups, 80 rules, 21 discoveries,
112 views, 63 operator tasks plus 4 console tasks, and 234 knowledge articles across host, VM,
Failover Clustering, CSV, Storage Spaces Direct, SAN (Fibre Channel, iSCSI, MPIO), SMB/SOFS,
Network ATC, physical networking, SDN host binding, VMM and Pure Storage.

`1.4.0.0` supersedes `1.3.0.0`: host-wide facts (iSCSI/MPIO event counts, Network ATC ETS and QoS
policy) are evaluated once per host instead of once per session, LUN or intent; the Physical Network
link monitors watch only vSwitch-uplink and intent adapters by default; and the File Services link to
Microsoft's SMB service objects is an opt-in discovery, so a NAS-backed deployment no longer loses
its whole File Services topology to an unresolvable host reference.
`1.3.0.0` superseded `1.2.0.0`: cluster-wide facts (CSV state, quorum, node, network and role
state) are now evaluated once per cluster on a cluster-hosted role instead of once per node, and the
four original storage availability monitors plus the inert VLAN-mismatch monitor ship disabled as
superseded. The [`1.2.0.0`](/downloads/hyper-v-private-cloud/1.2.0.0/release-assets.json) and
[`1.1.0.0`](/downloads/hyper-v-private-cloud/1.1.0.0/release-assets.json) files stay published as
release evidence.

::: danger 1.0.0.0 is superseded and must not be deployed
The full pack review recorded in
[ADR 0053](../design/decisions/0053-management-pack-review-and-runtime-correctness.md) found four
runtime defects that stopped every `1.0.0.0` probe and discovery script before its first statement.
That release could never have monitored a real host. Its files stay under
[`1.0.0.0`](/downloads/hyper-v-private-cloud/1.0.0.0/release-assets.json) as release evidence only.
If it was imported, upgrade in place to `1.4.0.0`: every element ID is preserved, so overrides carry
forward.
:::

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
[`1.4.0.0`](/downloads/hyper-v-private-cloud/1.4.0.0/release-assets.json). The `latest` directory
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
