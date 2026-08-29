---
title: Hyper-V v2 governed release runbook
description: Protected-runner procedure for sealing, validating, publishing, and verifying Hyper-V Private Cloud Monitoring v2.
---

# Hyper-V v2 governed release runbook

The production release is created only by
`.github/workflows/release-hyper-v-v2.yml`. Do not seal a public build from a developer workstation,
publish transient Test-mode output, replace an existing release, or upload assets by hand.

## Protected environment

Create the GitHub environment `hyper-v-scom-production-release` with required reviewers and prevent
unreviewed branches from deploying. Its self-hosted Windows runner uses the labels `Windows`, `X64`,
and `scom-mp-release` and requires:

- PowerShell 7, Git, GitHub CLI, Azure CLI, Visual Studio 2022 MSBuild, Microsoft VSAE, FASTSEAL,
  the SCOM SDK assemblies installed with VSAE, and the .NET Framework strong-name utility;
- GitHub Actions Runner `2.327.1` or later for the Node 24 action runtime;
- local read access to a curated dependency tree containing the exact Microsoft and vendor `.mp`
  and `.mpb` inputs approved for the release; and
- outbound access to Azure Key Vault, GitHub Actions, and GitHub Releases.

Configure these environment values without committing their contents:

| Kind | Name | Purpose |
|---|---|---|
| Secret | `AZURE_CLIENT_ID` | OIDC application or managed-identity client ID |
| Secret | `AZURE_TENANT_ID` | Microsoft Entra tenant used by Azure Login |
| Secret | `AZURE_SUBSCRIPTION_ID` | Subscription containing the release Key Vault |
| Variable | `HCS_KEY_VAULT_NAME` | Governed Key Vault name |
| Variable | `HYPERV_SCOM_SIGNING_SECRET_NAME` | Base64-encoded permanent `.snk` secret name |
| Variable | `HYPERV_SCOM_RELEASE_DEPENDENCY_PATHS` | Semicolon-separated runner-local dependency directories |

Use workload-identity federation. Do not store an Azure client secret in GitHub. Grant the identity
only the Key Vault secret-read permission required for the signing key. The workflow materializes
the key at a unique path under runner temp, never includes it in an artifact, and deletes it in an
`always()` cleanup step.

## Evidence receipt

Copy `src/hyper-v/scom-mp/v2/release/release-evidence.example.json` to a version-specific tracked
receipt only after all ten gates have representative evidence. Set `approved=true`, record the
exact 40-character source commit, version, approval time, evidence locations, and approvers. The
packager rejects a receipt for another version or commit and rejects a dirty worktree.

The evidence must cover PowerShell runtime, clean import, topology, health and alerts, Distributed
Application and views, capability integrations, scale, upgrade and overrides, dependency-safe
removal, and Default Management Pack protection. VSAE results do not substitute for these labs.
Run `tests/integration/Get-HyperVPrivateCloudCertificationSnapshot.ps1` with a reviewed expectation
file in every representative lane to collect the repeatable read-only portion. Its generated draft
always remains `approved=false`; merge it with fault, recovery, scale, lifecycle, and before/after
evidence only after a human has reviewed the complete lane.

## Release execution

1. Accept every release-required ADR, including the permanent signing-identity decision.
2. Provision and back up the permanent key in Key Vault without writing it into the repository or a
   developer workspace.
3. Approve and commit the evidence receipt and final release notes on `main`.
4. Run **Release Hyper-V Private Cloud Monitoring v2** manually from `main`, supplying the
   four-part product version and repository-relative evidence and release-note paths.
5. Approve the protected environment deployment.
6. Retain the workflow run and its 90-day exact-asset artifact with the release record.

The workflow fails closed if the runner, dependency identities, publisher signatures, loose-MP
strong names, evidence, source commit, key identity, VSAE verification, sealed artifacts, override
inventory, checksums, or release eligibility do not match. It refuses to overwrite an existing
tag. On success it creates `hyper-v-private-cloud-v<version>`, marks it latest, uploads every asset,
and verifies the stable latest-download URLs.

## Publication verification

Before changing the public site to **Download now**, independently verify:

- `Hyper-V-Private-Cloud-Monitoring-Complete.zip`;
- `Hyper-V-Private-Cloud-Monitoring-Core.zip`;
- `Hyper-V-Private-Cloud-Monitoring-Overrides.zip`;
- `release-manifest.json`; and
- `SHA256SUMS.txt`

under `https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/latest/download/`.
Download the complete bundle on a clean machine, validate its checksum, and repeat the clean SCOM
import smoke test against the exact published bytes. Only then replace the lab-preview site action
with the stable v2 **Download now** link.

Microsoft documents OIDC access to Key Vault in
[Integrate Azure Key Vault into a GitHub Actions workflow](https://learn.microsoft.com/en-us/azure/developer/github/github-actions-key-vault),
and GitHub documents the `GH_TOKEN` requirement for
[using GitHub CLI in workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli).
