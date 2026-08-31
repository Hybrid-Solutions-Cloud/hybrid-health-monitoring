---
title: ADR 0050 — Prerequisite acquisition and import preflight
description: How an operator obtains the Microsoft and vendor Management Packs this product depends on, and how a failed import is prevented rather than diagnosed after the fact.
---

# ADR 0050 — Prerequisite acquisition and import preflight

- **Status:** Proposed
- **Date:** 2026-08-30
- **Related:** [ADR 0043](0043-hyper-v-v2-package-and-deployment-profile-architecture.md),
  [ADR 0048](0048-hyper-v-v2-governed-sealing-and-release-assets.md)

## Context

[ADR 0043](0043-hyper-v-v2-package-and-deployment-profile-architecture.md) and
[ADR 0048](0048-hyper-v-v2-governed-sealing-and-release-assets.md) decided that Microsoft and vendor
prerequisite Management Packs are **not redistributed**. ADR 0048 states it plainly: *"Operators
obtain them from their publishers and import them before the matching HCS capability MP."* ADR 0043
adds a conditional — *"not redistributed unless their license explicitly permits it"* — which has
never been evaluated, because nobody has read those licences.

Neither ADR decided **how** the operator obtains them, or what happens when they have not. That gap
has a measured cost. On the first real import of `1.0.0.0`, four of the nine optional capability
packs failed:

```text
The dependencies for this management pack cannot be located.
```

Cluster, File Services, SDN, and Pure Storage all failed. These are exactly the capability packs
carrying external references, so the behaviour is correct — but the operator experience is that a
freshly downloaded, correctly sealed product does not import. SCOM's error names the missing
reference only after the operator clicks into the Status column, and gives no acquisition path.

Satisfying those four requires visiting three separate Microsoft Download Center pages and one
GitHub release, and knowing which of the packs inside each download are the ones actually
referenced. `release-manifest.json` already carries all 21 prerequisite identities with minimum
versions and publisher tokens, and `docs/hyper-v/prerequisites.md` documents them — but both are
read *after* a failed import, not before.

The product is otherwise correct here. Not redistributing is defensible and probably right; refusing
to help the operator act on that decision is not.

## Decision

**Keep the no-redistribution stance. Close the acquisition gap with tooling, not by bundling.**

1. **Ship a preflight command.** A supported script takes a management group connection and a chosen
   deployment profile, and reports which referenced prerequisites are present, which are missing, and
   which are present below the referenced minimum version. It reads the prerequisite set from
   `release-manifest.json` rather than a hand-maintained list, so it cannot drift from the sealed
   packs. It is read-only and makes no change to the management group.

2. **Preflight is documented as step one of installation**, ahead of the import order, in
   `docs/hyper-v/prerequisites.md` and the administration guide.

3. **Do not auto-import third-party prerequisites.** The tooling reports and links; it does not
   acquire or import Microsoft or vendor packs on the operator's behalf. Importing a publisher MP
   into a customer management group can overwrite a newer pack, alter monitoring the customer already
   depends on, and change support posture — consequences the customer must choose, not a vendor
   script.

4. **Link to download pages, never to download files.** Microsoft's
   [copyright permissions](https://www.microsoft.com/en-us/legal/intellectualproperty/copyright/permissions)
   state: *"You may link to the download page, but not directly to the download."* Every prerequisite
   link — in documentation, in the dependency contract, and in any future preflight output — targets
   the publisher's download **page**. The `officialMedia` field in `contracts/dependencies.v2.json`
   previously deep-linked the SCVMM media archive and has been corrected.

5. **Re-evaluate the redistribution conditional with evidence.** The ADR 0043 carve-out stays, but is
   only actionable once the licence position is established. Research to date supports the link-only
   stance for the Microsoft packs: Microsoft's stated default is *"Unless expressly permitted in the
   accompanying License Terms or End-User License Agreement (EULA), Microsoft does not allow
   redistribution"*, no redistribution instrument exists for management packs, and no third-party
   precedent was found. The determinative document — the EULA inside each MSI — has not been read,
   so the question is not closed. Pure Storage's pack is Apache-2.0 and is the one plausible
   candidate for bundling; a successor ADR may revisit it for that pack alone.

6. **Document the online catalog as the low-friction path.** The console's *Add from disk* flow
   offers an Online Catalog Connection prompt; answering **Yes** lets SCOM resolve missing
   dependencies from Microsoft's own catalog, where all five of our Microsoft prerequisites live.
   This is Microsoft-operated resolution, not vendor-operated import, so it carries none of the risk
   in point 3. Document it alongside the manual path for air-gapped estates — after verifying the
   prompt still appears on SCOM 2022 and 2025.

7. **Ship a guided import that passes all packs as one array.** `Import-SCOMManagementPack` resolves
   ordering within a batch, so handing it a folder containing our packs plus whatever prerequisites
   the operator has already downloaded eliminates the wrong-order failure class entirely. It cannot
   and must not fetch anything.

8. **Audit declared reference versions down to the true minimum.** A reference version is a
   *minimum*, not an exact match. Declaring a version higher than we actually require turns an
   adequately equipped management group into a failed import for no reason. Our declared minimums
   were taken from the packs we happened to build against and have never been audited.

9. **Document the uninstall path.** The VMM, SDN, and Pure Storage capabilities define Run As
   profiles, so SCOM writes references into `Microsoft.SystemCenter.SecureReferenceOverride` and
   removal fails until those are cleared. An operator must not discover this mid-uninstall.

## Options considered

**Bundle the prerequisites in the download.** Solves the operator problem outright — one download,
one import order, no external hunting. Rejected for now on two grounds. It contradicts ADR 0043 and
0048 without new evidence, and the licence position for the Microsoft packs and for the VMM packs
(which ship on installation media rather than a public download) is currently unknown. Bundling
first and checking licences afterwards is the wrong order.

**Auto-import missing prerequisites from a script.** Attractive, and technically possible with
`Import-SCOMManagementPack`. Rejected as the default. A vendor script that silently imports
Microsoft packs into a production management group can downgrade or replace packs the customer is
already using, and there is no safe generic answer to a version conflict. This belongs to the
customer's change control.

**Documentation only — the status quo.** Rejected. It has now been tested in practice and produced
four failed imports on first use. The information was accurate and discoverable in principle, and
still did not prevent the failure, because nothing consults it at the moment of import.

**Fail more helpfully inside the MP.** Not possible. Reference resolution happens in the SCOM import
pipeline before any MP content executes; a sealed pack cannot intercept or annotate its own
unresolved-reference failure.

## Consequences

- The operator gets a definitive answer before importing, from the same manifest the release was
  sealed against, instead of discovering the gap as a console error.
- The no-redistribution decision is preserved, so the licence question stays open rather than being
  pre-empted.
- Preflight is one more supported script to maintain and version alongside the release. It must read
  the manifest, never a duplicated list, or it becomes another drift surface.
- Auto-import remains unavailable, so an operator with many management groups still does manual work.
  That is a deliberate trade against the risk of a vendor script mutating a customer's estate.
- If the spike finds redistribution is permitted for some packs, this ADR does not block that — a
  successor ADR revisits it with evidence.

## References

- [ADR 0043 — Package and deployment profile architecture](0043-hyper-v-v2-package-and-deployment-profile-architecture.md)
- [ADR 0048 — Governed sealing and release assets](0048-hyper-v-v2-governed-sealing-and-release-assets.md)
- [ADR 0049 — Product-named management pack identity](0049-product-named-management-pack-identity.md)
- [Hyper-V prerequisites](../../hyper-v/prerequisites.md)
- [Research spikes](../research-spikes.md) — prerequisite redistribution and acquisition spike
