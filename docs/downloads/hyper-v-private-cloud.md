---
title: Download Hyper-V Private Cloud Monitoring
description: Sealed SCOM Management Packs, public override packs, manifests, and checksums for Hyper-V Private Cloud Monitoring.
---

# Download Hyper-V Private Cloud Monitoring

Sealed SCOM Management Packs for Hyper-V private cloud infrastructure. The release contains 13
product packs: four always-required packs plus nine independently selectable capability packs.
The primary deployment ZIP upgrades all 12 non-PureStorage solution packs together. Pure Storage
remains separately selectable because it requires the vendor Management Pack.

::: tip Read the prerequisites first
The Microsoft and vendor Management Packs each capability requires are **not** redistributed here,
and a missing one is the most common cause of a failed import. Work through the
[prerequisites](../hyper-v/prerequisites.md) before downloading anything.
:::

## Current release: 1.3.2.0 — Private Cloud Powered by Hyper-V: A 360° View

`1.3.2.0` is the current production release. Every one of the 13 sealed product MPs has version `1.3.2.0`,
delivering the full 360° Private Cloud Distributed Application service model. This includes complete
fabric modeling across physical server chassis/hardware, top-of-rack data switches, out-of-band management switches,
perimeter firewalls, Opengear out-of-band console servers, DHCP/IPAM, management domain services (Active Directory,
DNS resolution, and PXE/WDS bare-metal deployment), central deep-troubleshooting operator tasks, and the streamlined 2-pack override model.
All 13 product Management Packs are sealed with the permanent public key token `54d0fb1159995c86`, verified by Microsoft VSAE,
strong-name checked, and covered by the published SHA-256 manifest. The release catalog contains 13
sealed Management Packs and 2 canonical override packs: 165 unit monitors, 114
dependency roll-ups, 80 rules, 24 discoveries, 118 views, 69 operator tasks,
and 240 knowledge articles across host, VM, Failover Clustering, CSV, Storage Spaces Direct, SAN
(Fibre Channel, iSCSI, MPIO), SMB/SOFS, Network ATC, physical networking, SDN host binding, VMM and
Pure Storage. Cluster-wide facts are evaluated once per cluster, host-wide facts once per host, and
one probe run per host feeds every per-VM, per-LUN, per-session, per-port and per-intent monitor.

Management Packs are named for the product — `HyperVPrivateCloud.Library`,
`HyperVPrivateCloud.Capability.Cluster`, and so on. Publisher attribution is carried in the sealed
pack `Company` and `Copyright` metadata rather than in the pack ID.

## Download now

- **[Download the 12-pack solution upgrade](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Deployment-1.3.2.0.zip)** — all four core packs plus Cluster, Storage, S2D, File Services, Network ATC, Physical Network, SDN, and VMM, all at `1.3.2.0`. It contains no override MPs.
- **[Download the complete package](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Complete.zip)** — archive containing all available product packs and optional starter templates; do not bulk-import its contents.
- [Download the core-only bundle](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Core.zip) — Library, Discovery, Monitoring, and Presentation for deployments that intentionally use no optional capabilities.
- [Download canonical override templates](/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Overrides.zip) — Discovery and Monitoring override templates; select and review one Discovery/Monitoring pair only.
- [Download SHA-256 checksums](/downloads/hyper-v-private-cloud/latest/SHA256SUMS.txt)
- [View the release manifest](/downloads/hyper-v-private-cloud/latest/release-manifest.json)
- [View the public asset manifest](/downloads/hyper-v-private-cloud/latest/release-assets.json)

The immutable versioned files are also retained under
[`1.3.2.0`](/downloads/hyper-v-private-cloud/1.3.2.0/release-assets.json). The `latest` directory
serves the same exact bytes and changes only when a newer validated version is published.
The previous releases stay under [`1.0.7.0`](/downloads/hyper-v-private-cloud/1.0.7.0/release-assets.json) and [`1.0.6.0`](/downloads/hyper-v-private-cloud/1.0.6.0/release-assets.json).

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
