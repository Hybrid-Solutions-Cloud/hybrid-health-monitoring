---
title: ADR 0052 — Pure Storage monitoring strategy
description: The vendor management pack this capability depends on is dormant and does not support SCOM 2025. What replaces it.
---

# ADR 0052 — Pure Storage monitoring strategy

- **Status:** Proposed
- **Date:** 2026-08-30
- **Supersedes:** the integration mechanism in [ADR 0041](0041-hyper-v-v2-pure-storage-integration.md);
  its ownership and correlation rules stand.

## Context

`Capability.PureStorage` takes a hard reference on `PureStorageFlashArray` `2.0.120.0`, published by
Pure Storage. That dependency is dead-ended for a product targeting SCOM 2025.

**The vendor says so.** The repository's `release_notes.md` states verbatim: *"This release requires
Microsoft System Center Operations Manager 2016, 2019, or 2022"*. Pure's own support portal repeats
it: *"Systems Center Operations Manager versions 2016, 2019, or 2022."* SCOM 2025 is not an ambiguous
omission — the supported-version sentence is an explicit enumeration that ends at 2022.

**The pack is dormant.** The most recent commit and the most recent release are both **2 October
2024**; the commit before that batch was November 2022. Fifty-six commits total. Open defects have
aged out, including one from June 2021 reporting that the pack targets the obsolete
`RootManagementServer` class, so its workflows cannot be aimed at specific management servers. No
statement about SCOM 2025 exists in the repository, the release notes, the issues, or the support
portal — silence rather than a denial, but nothing to plan against.

`2.0.120.0` is also a hard floor rather than a preference: it fixed alert retrieval broken by cipher
hardening in Purity 6.5+, so on any modern array an earlier pack silently loses alerting. We already
declare it. There is nothing further to upgrade to.

Separately, Pure's support and blog domains now redirect to `everpuredata.com`. The cause has not
been researched, but it is a signal worth understanding before depending further on this vendor's
SCOM investment.

Meanwhile Pure has moved its observability investment elsewhere. The standalone
`pure-fa-openmetrics-exporter` was **deprecated in favour of a native OpenMetrics exporter built into
Purity//FA 6.6.11 and later** — in-array, first-party, no sidecar, read-only token over HTTPS.

## Decision

**Stop treating the vendor management pack as the strategic path. Keep it only as a legacy option,
and monitor Pure through an interface Pure actually maintains.**

1. **`Capability.PureStorage` is documented as supported on SCOM 2019 and 2022 only**, matching the
   vendor's own statement. It is not offered as part of a SCOM 2025 deployment. This is a
   documentation change, not a code change — the pack works where its dependency works.

2. **A replacement is built against an interface Pure maintains.** Two candidates, to be decided by
   the spike:
   - **Native Purity//FA OpenMetrics endpoint (6.6.11+)** — where Pure's investment has gone. Suits
     estates that already run Prometheus/Grafana alongside SCOM, and requires no management pack from
     us at all.
   - **FlashArray REST API 2.x** — a first-party capability pack of our own, discovering arrays,
     volumes, hosts, ports, hardware components and alerts over HTTPS with a read-only token. Fits
     the existing PowerShell 7 workflow pattern and keeps everything inside SCOM, which is where this
     product's Distributed Application lives.

3. **Scope the second option honestly.** The REST surface covers everything the vendor pack exposes,
   so the API is not the hard part. The cost is **owning a management pack** — discovery model, class
   hierarchy, monitors, health rollup, views, alert knowledge, overrides, and management-server
   targeting. That last item is precisely where the vendor pack is defective. Budget it as authoring
   a capability pack, not as writing an API client.

4. **Escalate to Pure before committing.** Ask for a written support position on SCOM 2025. The
   absence of a "no" is not a "yes", and a vendor statement would change the calculus.

5. **The ownership rules in [ADR 0041](0041-hyper-v-v2-pure-storage-integration.md) survive
   unchanged.** Whatever supplies the data, Pure objects remain vendor-owned in our model, and our
   contribution stays private-cloud membership and dependency rollup. Only the source of the objects
   changes.

## Options considered

**Stay on the vendor pack and hold a SCOM 2022 management group for Pure.** Rejected as a strategy,
though it remains what an existing customer does today. It forks the estate and freezes a management
group on an older SCOM for one capability.

**Wait for Pure to ship SCOM 2025 support.** Rejected. Twenty-three months without a commit, a
four-year-old unfixed defect, and no roadmap statement. Waiting is not a plan.

**Drop Pure monitoring entirely.** Rejected. The capability exists because customers run Hyper-V on
FlashArray, and the correlation between virtual hard disks and array volumes is genuinely useful.
The dependency is dead, not the requirement.

**Native OpenMetrics only, no SCOM integration.** Lowest ongoing burden and closest to Pure's own
direction, but it puts array health outside the private-cloud Distributed Application, which is the
thing that makes this product coherent. Viable for estates that want it; not sufficient alone.

## Consequences

- SCOM 2025 deployments lose Pure array monitoring until a replacement ships. That is the current
  reality made explicit rather than a new limitation.
- We take on ownership of Pure monitoring quality, including the failure modes the vendor pack has
  not fixed.
- A REST-based capability removes an external management pack dependency, one publisher token, and
  one Run As profile from the prerequisite set — the same self-contained pattern already proven by
  `Capability.Storage` and `Capability.NetworkATC`.
- If Pure does ship SCOM 2025 support, this decision is revisited by a successor ADR rather than
  silently abandoned.

## References

- [ADR 0041 — Pure Storage integration](0041-hyper-v-v2-pure-storage-integration.md)
- [ADR 0051 — Dependency currency and supported-platform validation](0051-dependency-currency-and-platform-validation.md)
- [Research spikes](../research-spikes.md) — Pure Storage monitoring replacement
- [PureStorage-Connect/SCOM-Management-Pack](https://github.com/PureStorage-Connect/SCOM-Management-Pack)
- [pure-fa-openmetrics-exporter](https://github.com/PureStorage-OpenConnect/pure-fa-openmetrics-exporter) — deprecation notice
