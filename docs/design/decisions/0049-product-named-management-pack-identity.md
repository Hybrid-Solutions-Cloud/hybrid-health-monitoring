---
title: ADR 0049 — Product-named management pack identity
description: Management pack identities are named for the product they monitor, not for the organisation that publishes them.
---

# ADR 0049 — Product-named management pack identity

- **Status:** Accepted
- **Date:** 2026-08-30
- **Supersedes:** the namespace portion of [ADR 0024](0024-repository-and-publishing-identity.md)

## Context

Every Hyper-V v2 management pack shipped under the namespace
`HybridSolutionsCloud.HyperVPrivateCloud.*`. The company name was the first and most prominent
segment of the identity of a general-purpose infrastructure monitoring product.

Two observations drove a change:

1. **The product is not company-specific.** It monitors Hyper-V private cloud infrastructure. Nothing
   about what it does is tied to Hybrid Solutions Cloud, and leading the identity with the publisher
   describes who wrote it rather than what it is.
2. **The console already got this right.** Every `DisplayString` was already product-named —
   "Hyper-V Host", "Hyper-V Virtual Machine", "Compute", "Storage". Only the machine-readable
   identity carried the company name, so the two disagreed about what the product is called.

Renaming a management pack ID is not a rename in SCOM — it produces a different management pack with
no upgrade path from the old one. That made the timing decisive: release `2.0.0.0` had been sealed
and published but not imported into any production management group, so the cost of renaming was a
rebuild rather than a customer migration. That window does not reopen.

## Decision

Management pack identities are named for the product they monitor.

- The Hyper-V namespace becomes `HyperVPrivateCloud.*` — for example `HyperVPrivateCloud.Library`
  and `HyperVPrivateCloud.Capability.Cluster`.
- Published override examples drop the organisation prefix entirely and are named
  `HyperVPrivateCloud.Overrides.<Profile>.<Tier>.<Kind>`, because they are named for the product they
  override.
- Customer-generated override packs keep the conventional publisher prefix
  `<Org>.HyperVPrivateCloud.Overrides.*`, which is what `-OrganizationId` produces. This is correct:
  a customer's override pack genuinely is authored by that customer.
- Publisher attribution moves to where it belongs — the sealed pack's `Company` and `Copyright`
  fields, the documentation byline, and the download page.
- **The version line restarts at `1.0.0.0`.** `HyperVPrivateCloud.*` is a new pack identity with no
  prior release, so continuing from `2.0.0.0` would imply a lineage SCOM does not recognise. The
  `2.x` numbering was itself an artefact — no `1.0` was ever officially released — so the rename is
  the natural point to correct it. `1.0.0.0` is the first release of this product under its own name.

## Options considered

**Keep `HybridSolutionsCloud.HyperVPrivateCloud.*`.** Zero work and zero risk. Rejected because it
permanently bakes publisher branding into a product identity, and the window to change it without a
customer migration closes the moment anyone imports `2.0.0.0` in production.

**Drop all namespacing — `Library`, `Discovery`, `Monitoring`.** Maximally product-focused and
rejected outright. Management pack IDs share a flat global space inside a management group; a pack
called `Library` would collide with almost anything.

**`PrivateCloud.HyperV.*`.** A product-family root leaving room for a symmetric
`PrivateCloud.AzureLocal.*`. Rejected for now because Azure Local's packs are a separate lab-preview
product on a different maturity track, and speculatively reshaping a shipped namespace for a
symmetry that may never be built is the wrong trade.

**`HyperVPrivateCloud.*` (chosen).** Names the product, keeps a distinctive root segment that is
unlikely to collide, and requires no change to the already-correct display names.

## Consequences

**Breaking.** `HyperVPrivateCloud.Library` and `HybridSolutionsCloud.HyperVPrivateCloud.Library` are
unrelated management packs as far as SCOM is concerned. Anyone who imported `2.0.0.0` must remove
those packs and import `1.0.0.0`, losing stored overrides and accumulated health state. This is
acceptable only because no such deployment exists; it will not be acceptable again.

**Release `2.0.0.0` stays published as-is.** Its sealed artifacts, manifest, and checksums are
immutable release evidence and were deliberately not rewritten by the rename. Until `1.0.0.0` is
sealed and published, the download page must state which identity each release carries.

**All 66 override examples were regenerated**, and the generator now composes the pack ID from an
optional organisation prefix rather than hardcoding one.

**The dependency exporter derives the namespace** as the longest common dotted prefix of a solution's
pack IDs rather than assuming a fixed segment count, so it survived this rename and will survive the
next one.

**Sealing is possible on an authoring workstation, but a published release still goes through CI.**
VSAE 2022, `FASTSEAL.exe`, the VSAC MSBuild tasks, `sn.exe`, and MSBuild are all present on a
configured authoring box, so a sealed build can be produced and verified locally for validation. The
governed release still runs through `release-hyper-v-v2`, because that workflow is what supplies the
protected environment, OIDC-scoped Key Vault access to the permanent signing key, immutable run
provenance, and the published asset manifest. A locally sealed pack is for verification, never for
publication.

## References

- [ADR 0024 — Repository and publishing identity](0024-repository-and-publishing-identity.md)
- [ADR 0043 — Package and deployment profile architecture](0043-hyper-v-v2-package-and-deployment-profile-architecture.md)
- [ADR 0048 — Governed sealing and release assets](0048-hyper-v-v2-governed-sealing-and-release-assets.md)
- [Hyper-V prerequisites](../../hyper-v/prerequisites.md)
