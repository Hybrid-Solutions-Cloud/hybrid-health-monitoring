# ADR 0048 — Hyper-V v2 governed sealing and release assets

- **Status:** Accepted
- **Date:** 2026-08-29
- **Decision owners:** Hybrid Solutions Cloud maintainers

## Context

Hyper-V Private Cloud Monitoring v2 has four required core Management Packs, nine optional
capability Management Packs, 11 deployment profiles, and separate Lab, Standard, and Strict
Discovery/Monitoring starter override MPs. Source XML, schema verification, and transient test
sealing do not create a public product. A public release needs one permanent strong-name identity,
sealed binary assets, import-ready override XML, dependency inventory,
checksums, and stable download names.

The earlier cross-track signing ADR 0016 proposed Azure Local-specific vaults and identities that
do not exist in the current HCS governance boundary. Hyper-V v2 is an independent runtime product
and cannot silently reuse Azure Local's signing identity. This ADR refines ADR 0016 for Hyper-V v2
only; it does not decide Azure Local's future release identity.

Microsoft's installed VSAE toolchain exposes `SealMp`, which invokes `FASTSEAL.exe`. Repeated seals
of identical XML with the same key produce equivalent assembly identity and valid signatures, but
not byte-identical files: FASTSEAL writes a new PE timestamp and module identity. Deterministic ZIP
creation therefore makes a package repeatable for one immutable set of sealed inputs; it cannot
make two independent FASTSEAL compilations byte-identical. Release provenance and published
SHA-256 hashes are required instead of claiming reproducible binary resealing.

## Decision

### Permanent product identity

Hyper-V Private Cloud Monitoring v2 receives one permanent strong-name key pair that signs all 13
authored product MPs and every later compatible release. The Key Vault secret name is
`hcs-hybrid-health-monitoring-scom-release-private-key` in the HCS platform vault. The binary key
is stored as an encoded secret because VSAE requires an exportable `.snk` file; it is not described
as HSM-backed. The secret value never enters source control, release assets, workflow logs, or a
persistent workspace path.

The permanent identity was provisioned with public key token `54d0fb1159995c86`. An approved
maintainer or protected Windows release runner may retrieve the key only into a temporary path,
seal the approved source, validate and publish the assets, and delete the local key immediately.
PR and ordinary development builds use transient test identities and can never be presented as the
stable repository-hosted package.

Creating the permanent key and first secret version is a human-approved, one-time release action.
The public key token produced by that action becomes an immutable product identity. Rotation means
a new product identity and explicit migration, not a routine credential rollover.

### Fail-closed release pipeline

`New-HyperVPrivateCloudReleasePackage.ps1` is the canonical sealing and packaging entry point. It:

1. rejects a signing key stored anywhere under the repository;
2. derives the public key token from the supplied key before building product references;
3. builds all authored product XML with one version and token;
4. resolves each referenced publisher dependency from sealed `.mp` assemblies or publisher `.mpb`
   bundles by ID and signing token at the declared minimum version or higher;
5. records the publisher source filename, SHA-256 hash, and contained identity, then verifies each
   source MP through Microsoft VSAE in dependency order;
6. seals only through VSAE `SealMp` with delay signing disabled;
7. verifies every resulting strong name and token;
8. generates all 66 public, unsealed override MPs with the exact product version and token;
9. emits individual `.mp` files, core/complete/override ZIPs, and all 11 deployment-profile ZIPs;
10. records prerequisite identities and SHA-256 hashes and rejects any key material in output.

Test mode may skip VSAE only to exercise packaging. It writes `releaseEligible=false`. Release
mode cannot skip VSAE and requires an approved permanent-signing assertion and a clean, recorded
source commit. `Test-HyperVPrivateCloudReleasePackage.ps1 -RequireReleaseEligible` is a mandatory
publication gate. SCOM runtime certification occurs after publication in the operator's isolated
management group; it is not required to produce or host the complete signed package.

### Stable public assets

The repository stores versioned public assets under
`docs/public/downloads/hyper-v-private-cloud/<version>/` and the current public set under
`docs/public/downloads/hyper-v-private-cloud/latest/`. Required assets are:

- `Hyper-V-Private-Cloud-Monitoring-Complete.zip`;
- `Hyper-V-Private-Cloud-Monitoring-Core.zip`;
- `Hyper-V-Private-Cloud-Monitoring-Overrides.zip`;
- one `Hyper-V-Private-Cloud-Monitoring-Profile-<profile>.zip` per deployment profile;
- all 13 sealed product `.mp` files;
- `release-manifest.json`, `release-assets.json`, and `SHA256SUMS.txt`.

Microsoft and vendor prerequisite MPs are identified in the release manifest but are not
redistributed. Operators obtain them from their publishers and import them before the matching HCS
capability MP.

## Consequences

- A customer gets both complete and minimum/profile-specific packages rather than an undifferentiated
  source archive.
- Public override starters are import-ready and bound to the actual signed product identity, while
  remaining unsealed and customer-owned.
- The pipeline cannot publish a transient seal merely because schema and strong-name checks pass.
- Losing the permanent private key prevents compatible upgrades. Access, backup, recovery, and
  audit policy must be approved before the first release.
- Independent FASTSEAL runs are provenance-equivalent but not byte-identical. The release retains
  one immutable set of sealed binaries and publishes their checksums.
- External dependency acquisition and representative SCOM certification remain explicit gates;
  the packager fails when a compatible prerequisite is absent.
- Microsoft's VSAE verifier cannot consume `.mpb` files as sealed-reference inputs. The packager
  therefore authenticates bundle identities with Microsoft's SCOM packaging SDK and creates a
  temporary, transitively token-remapped sealed dependency graph for VSAE resolution. Those
  inspection copies stay under the working directory, are never release assets, and never replace
  the publisher identity recorded in the release manifest or validated by clean SCOM import.
- Every loose prerequisite `.mp` must pass cryptographic strong-name verification. The release
  manifest also records each `.mpb` file's Authenticode result and signer when present. Microsoft's
  inspected S2D and VMM bundles are Authenticode-signed; Pure's official 2.0.120.0 bundle is not.
  Pure therefore requires exact publisher-release hash provenance and the same clean-import gate;
  the release must not describe that file as Authenticode-signed.

## Rejected alternatives

### Commit or publish the key

Rejected because possession of the private strong-name key permits an attacker to impersonate the
product identity permanently.

### Reuse the Azure Local signing identity

Rejected because ADR 0022 makes Hyper-V and Azure Local independent SCOM products with independent
namespaces, packages, versions, and lifecycles.

### Publish transiently sealed development output

Rejected because a later permanent identity would break every reference and customer override
created against the transient public key token.

### Call FASTSEAL directly from the release script

Rejected because the installed Microsoft VSAE `SealMp` task is the governed authoring-toolchain
surface and keeps sealing parameters consistent with Microsoft projects.

## Acceptance gates

1. Approve and provision the permanent Hyper-V v2 key.
2. Supply a curated prerequisite set that satisfies every referenced ID/token/version floor.
3. Run the Release-mode packager and release-package validator from an approved Windows host.
4. Commit the versioned assets, stable current downloads, manifests, and checksums.
5. Validate the site's stable **Download now** link against the published repository asset.
6. After publication, clean-import the exact output and selected public override pair, then retain
   the operator certification snapshot and any defect reports for the next patch release.

## Sources

- [Management Pack lifecycle](https://learn.microsoft.com/en-us/system-center/scom/manage-mp-lifecycle)
- [What is in an Operations Manager Management Pack?](https://learn.microsoft.com/en-us/system-center/scom/manage-overview-management-pack)
- [Import, export, and remove an Operations Manager Management Pack](https://learn.microsoft.com/en-us/system-center/scom/manage-mp-import-remove-delete)
- [Use Azure Key Vault secrets in a GitHub Actions workflow](https://learn.microsoft.com/en-us/azure/developer/github/github-actions-key-vault)
