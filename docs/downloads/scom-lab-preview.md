---
title: Download SCOM Management Pack lab previews
description: Download the sealed Azure Local and Hyper-V SCOM Management Pack suites for controlled lab evaluation.
---

# Download the SCOM Management Pack lab previews

::: warning Hyper-V preview superseded
The Hyper-V `0.1.0` preview below is retained only for historical lab reproduction. Use the
[permanently sealed Hyper-V Private Cloud Monitoring v2 download](hyper-v-private-cloud-v2.md) for
all new Hyper-V installations. The two versions have different namespaces and signing identities
and must not be mixed.
:::

The first sealed Azure Local and Hyper-V Management Pack suites are available as version `0.1.0`
lab previews. Each ZIP contains Library, Discovery, Monitoring, Presentation, and optional
Reporting Management Packs, all three official override profiles, import order, and SHA-256
checksums.

- [Download Azure Local SCOM 0.1.0 lab preview](https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/download/scom-lab-preview-v0.1.0/HybridSolutionsCloud.AzureLocal.SCOM-0.1.0-lab-preview.zip)
- [Download Hyper-V SCOM 0.1.0 lab preview](https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/download/scom-lab-preview-v0.1.0/HybridSolutionsCloud.HyperV.SCOM-0.1.0-lab-preview.zip)
- [Download SHA-256 checksums](https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/download/scom-lab-preview-v0.1.0/SHA256SUMS.txt)
- [View the GitHub prerelease](https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/tag/scom-lab-preview-v0.1.0)

::: danger Lab use only
These files use the transient development public key token `14a10c8275285f00`. They are sealed and
pass Microsoft VSAE/SDK and strong-name verification, but they are not governed-release-signed,
production-certified, or supported as a production release. Import them only into an isolated or
approved pre-production SCOM 2022 management group.
:::

Customer override Management Packs bind to the sealed product identity. Overrides created against
this preview may need to be rebuilt after the permanent release identity is established.

## Choose one official override profile

Each product ZIP contains official first-party Lab, Standard, and Strict profile directories.
Every profile contains separate Discovery and Monitoring override XML files that can be imported
by any evaluator. Import exactly one profile for a product:

| Profile | Intended use |
|---|---|
| Lab | Accelerated functional, failure, and recovery testing only |
| Standard | Normal starting policy for representative evaluation |
| Strict | Explicitly designated critical environments with tested response capacity |

Do not combine profiles. Their policies overlap by design.

## Import order

Import only one platform suite unless the management group is intentionally validating
coexistence. Within each suite, import:

1. Library;
2. Discovery;
3. Monitoring;
4. Presentation; and
5. optional Reporting.

Then import the Discovery and Monitoring override XML files from exactly one selected profile.

Confirm that the required Microsoft SCOM dependencies are already installed. Read the notice and
verify the checksums included in the ZIP before import.

For detailed procedures, see the [Azure Local administration guide](../scom-mp/management-pack-guide.md)
or [Hyper-V administration guide](../hyper-v/management-pack-guide.md).
