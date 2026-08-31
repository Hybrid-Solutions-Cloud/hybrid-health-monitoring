---
title: Hyper-V governed release runbook
description: Permanent sealing, repository publication, checksum verification, and post-install SCOM validation for Hyper-V Private Cloud Monitoring.
---

# Hyper-V governed release runbook

The repository is the canonical distribution surface. Production assets are committed beneath
`docs/public/downloads/hyper-v-private-cloud/` so the source repository and public documentation
site serve the same exact bytes. A GitHub Release may mirror those files, but it is not required.

## Permanent signing identity

All 13 product MPs use the permanent public key token `54d0fb1159995c86`. The private key is stored
as the Key Vault secret `hcs-hybrid-health-monitoring-scom-release-private-key`; it is never
committed, logged, placed in an artifact, or retained in a developer directory.

An approved maintainer or protected Windows runner may retrieve the key only to a unique temporary
file. The release host requires PowerShell 7, Git, Visual Studio 2022 MSBuild, Microsoft VSAE,
FASTSEAL, the SCOM SDK assemblies installed with VSAE, and the .NET Framework strong-name utility.
Delete the temporary key in a `finally` block after packaging, whether the build succeeds or fails.

## Offline production build

The release does not require a SCOM management-group connection. It requires the permanent key and
curated directories containing the exact supported Microsoft and vendor prerequisite `.mp` and
`.mpb` files.

From a clean `main` worktree, run:

```powershell
./src/hyper-v/scom-mp/tools/New-HyperVPrivateCloudReleasePackage.ps1 `
  -Version 1.0.0.0 `
  -SigningKeyPath '<TEMPORARY_KEY_PATH>' `
  -DependencyPath '<CURATED_DEPENDENCY_DIRECTORY_1>','<CURATED_DEPENDENCY_DIRECTORY_2>' `
  -OutputPath '<EMPTY_OUTPUT_DIRECTORY>' `
  -BuildMode Release `
  -ApprovedReleaseSigningIdentity

./src/hyper-v/scom-mp/tools/Test-HyperVPrivateCloudReleasePackage.ps1 `
  -PackagePath '<EMPTY_OUTPUT_DIRECTORY>' `
  -RequireReleaseEligible
```

Release mode fails closed on a dirty source tree, unknown source commit, absent dependency,
publisher identity mismatch, invalid loose-MP strong name, VSAE verification failure, incorrect
product token, missing override, unsafe archive path, checksum mismatch, or signing-key leakage.

## Repository publication

Copy the complete validated `assets` directory without rebuilding it to:

```text
docs/public/downloads/hyper-v-private-cloud/1.0.0.0/
```

Copy the current public entry assets to:

```text
docs/public/downloads/hyper-v-private-cloud/latest/
```

The current directory must contain at least:

- `Hyper-V-Private-Cloud-Monitoring-Complete.zip`;
- `Hyper-V-Private-Cloud-Monitoring-Core.zip`;
- `Hyper-V-Private-Cloud-Monitoring-Overrides.zip`;
- `release-manifest.json`;
- `release-assets.json`; and
- `SHA256SUMS.txt`.

The versioned directory retains all 13 individual sealed MPs and all deployment-profile bundles.
Never regenerate only the `latest` copy: both paths must originate from the same validated output.

After committing and pushing, require the repository CI build to pass, then download the complete
ZIP from the public site and compare its SHA-256 value to the committed checksum catalog.

## Post-install operator validation

SCOM validation follows publication. It is not a prerequisite for producing the complete signed
download. In an isolated management group, import the exact published bytes, select one matching
Discovery/Monitoring override pair, and run
`tests/integration/Get-HyperVPrivateCloudCertificationSnapshot.ps1` with a reviewed expectation.

The collector writes an unapproved evidence draft covering repeatable identity, topology,
workflow, Distributed Application, view, alert, and PowerShell-runtime facts. Operators separately
exercise fault/recovery, scale, upgrade, override, removal, and Default Management Pack protection.
Any verified defect is corrected through a version-increased patch release; published sealed
assemblies are never edited in place.

Microsoft documents the Management Pack lifecycle in
[Management Pack lifecycle](https://learn.microsoft.com/en-us/system-center/scom/manage-mp-lifecycle)
and import behavior in
[Import, export, and remove an Operations Manager Management Pack](https://learn.microsoft.com/en-us/system-center/scom/manage-mp-import-remove-delete).
