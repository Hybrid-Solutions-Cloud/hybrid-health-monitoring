---
title: ADR 0054 â The real 1.0.0.0 - version reset and source-tree cleanup
description: Why the never-deployed 1.0.0.0-1.4.0.0 download artifacts were withdrawn, the product re-released as a single true 1.0.0.0, and the "v2" source directory eliminated.
---

# ADR 0054 â The real 1.0.0.0: version reset and source-tree cleanup

- **Status:** Accepted
- **Date:** 2026-08-31
- **Relates to:** [ADR 0049](0049-product-named-management-pack-identity.md) (product-named identity),
  [ADR 0053](0053-management-pack-review-and-runtime-correctness.md) (review and runtime correctness).

## Context

Between 2026-08-30 and 2026-08-31 the repository published five sealed builds of Hyper-V Private
Cloud Monitoring â `1.0.0.0` through `1.4.0.0` â in rapid succession, each layering fixes from the
full line-by-line review (ADR 0053) on top of the last. **None of these builds was ever imported
into a management group.** The original `1.0.0.0` could not have monitored a real host at all, and
every successor was published before anyone had tested its predecessor. The product owner's verdict:
"we have yet to release a 1.0 â that shit never worked." A version history with four supersessions
and a health warning on its own first release describes engineering churn, not releases, and forces
every operator page to carry supersession caveats for versions nobody ever ran.

Separately, the current product's source lived in `src/hyper-v/scom-mp/v2/` â a folder named for the
long-abandoned `HybridSolutionsCloud.*` `2.0.0.0` era (ADR 0049 renamed the identity and restarted
versioning, but nobody renamed the folder). The name misidentified the current product as a second
version line that does not exist.

## Decision

1. **One true `1.0.0.0`.** The current source â the reviewed, corrected packs including the full
   cookdown fan-out redesign (one probe run per host feeding the per-LUN/session/port storage
   monitors, the per-intent Network ATC monitors, and every per-VM monitor and collection rule) â
   is sealed and published as `1.0.0.0`. It is the first release of Hyper-V Private Cloud
   Monitoring.
2. **The never-deployed artifacts are withdrawn.** The `1.0.0.0`â`1.4.0.0` directories under
   `docs/public/downloads/hyper-v-private-cloud/` are removed; `latest/` serves the new `1.0.0.0`.
   They were engineering builds, retained until now only as evidence; the evidence lives on in git
   history and the CHANGELOG. The old-identity `2.0.0.0` artifacts were removed for the same reason — never deployed,
   never a release; git history is the only archive.
   This consciously sets aside the "downloads are immutable evidence" convention for artifacts that
   were never releases â a decision made explicitly by the product owner.
3. **No folder called `v2`.** The product source moved from `src/hyper-v/scom-mp/v2/` to
   `src/hyper-v/scom-mp/`; the pre-rename legacy pack source moved to
   `archive/hyperv-scom-mp-legacy/`. Contracts lost their version suffixes
   (`packages.json`, `dependencies.json`), the release workflow is `release-hyper-v.yml`, and the
   test files dropped the `V2` prefix. Sealed element IDs and XML aliases (for example
   `HCSV2Library`) are part of the pack identity and are deliberately unchanged.
4. **The gate to any future version bump is a live management-group test.** No further version is
   published until `1.0.0.0` has been imported and validated against a real Hyper-V host. The next
   published version after that validation will be justified by operator-visible change, not
   engineering iteration.

## Consequences

- Operators see a single download with no supersession warnings. A fresh management group imports
  `1.0.0.0`; there is no in-place-upgrade story to document because nothing earlier was deployed.
- Anyone who did import an engineering build (none known) must remove it before importing the real
  `1.0.0.0`, because SCOM will refuse a same-or-lower version import against the sealed token.
- The CHANGELOG keeps the engineering history under an explicit "withdrawn engineering builds"
  heading, so the review findings (ADR 0053) remain traceable without presenting them as releases.
- All tooling, tests, docs, and the release workflow reference `src/hyper-v/scom-mp/`; the word
  "v2" survives only in historical ADRs, the archived legacy source, and sealed XML aliases.
