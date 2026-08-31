---
title: ADR 0051 — Dependency currency and supported-platform validation
description: How referenced Microsoft management packs are checked for Windows Server 2025 and SCOM 2025 support, and how declared minimum versions are established rather than inherited from the build.
---

# ADR 0051 — Dependency currency and supported-platform validation

- **Status:** Proposed
- **Date:** 2026-08-30
- **Related:** [ADR 0043](0043-hyper-v-v2-package-and-deployment-profile-architecture.md),
  [ADR 0048](0048-hyper-v-v2-governed-sealing-and-release-assets.md),
  [ADR 0050](0050-prerequisite-acquisition-and-preflight.md)

## Context

The capability packs reference Microsoft management packs whose names say "2016" while this product
targets Windows Server 2025 and SCOM 2025. That prompted a reasonable question: are these
dependencies stale, and should the functionality be reimplemented in our own packs instead?

An audit answered it. **The names mislead; the packs are current.** Four of the referenced downloads
were re-released in **May 2025** — six months *after* both Windows Server 2025 and SCOM 2025 became
generally available — and each explicitly enumerates both:

| Package | Version | Released | Windows Server 2025 | SCOM 2025 |
|---|---|---|---|---|
| Windows Server Operating System (supplies CSV monitoring) | 10.1.2.2 | 2025-05-12 | stated | stated |
| Windows Server Cluster | 10.1.0.0 | 2025-05-29 | stated | stated |
| File and iSCSI Services | 10.1.0.4 | 2025-05-27 | stated | stated |
| Storage Spaces Direct | 1.0.47.4 | 2025-05-29 | stated | stated |

"2016 and above" is Microsoft's version-agnostic naming convention, not a support ceiling. None of
these packs is deprecated.

The audit did, however, surface four defects that are **ours**:

1. **`Microsoft.Windows.Cluster.Library` ships with SCOM.** The release manifest records the file we
   sealed against as `7.0.8447.6` — the same version scheme as `System.Health.Library` — and the pack
   is present in the VSAE `References/OM2022` set, which is the ships-with-SCOM list. The
   prerequisites page nevertheless told operators to download it.
2. **Two references are declared but never used.** `Capability.FileServices` declares
   `Microsoft.Windows.FileServices` and consumes nothing from it; `Capability.S2D` declares
   `Microsoft.Storage.Library` and consumes nothing from it. Both are pure prerequisite burden.
3. **Declared minimums are build artefacts, not established minimums.** We declare
   `Microsoft.Storage.Library` `1.0.0.0` having sealed against `1.0.47.4`, and
   `Microsoft.Windows.FileServices` `10.1.0.3` having sealed against `10.1.0.4`. Declaring lower is
   the permissive direction and not itself wrong, but no version in those ranges has been validated.
4. **The VMM minimums are internally inconsistent and unverifiable.**
   `PRO.V2.Library` `10.25.1200.0` is exactly the VMM 2025 GA build, while the other three sit at
   `11.19.0.3`, a 2019-era scheme with no public attestation. Microsoft does not publish VMM
   management pack versions — they ship inside the VMM installation.

One dependency carries genuine platform risk. `Microsoft.Windows.10.SDNMonitoring` `10.0.0.2` is the
only referenced pack whose page does **not** enumerate SCOM 2025 — it states only "SCOM 2016 and
higher", weaker than its siblings received in the same May 2025 refresh. Independently, Windows
Server 2025 moved the Network Controller from Service Fabric hosted in virtual machines to a Failover
Clustering service running on the host, and the pack's object model still describes the Service
Fabric shape. Nothing available confirms or denies that it discovers a Failover Clustering-hosted
Network Controller.

## Decision

**Keep referencing Microsoft's packs. Validate currency as an explicit, repeatable obligation rather
than an assumption.**

1. **A dependency is only referenced if its publisher states support for our target platforms.**
   Before a release, every referenced pack is checked against its publisher's stated Windows Server
   and SCOM support. A dependency whose publisher does not claim our target platform is either
   validated in a lab or the capability is withdrawn — it is not shipped on hope.

2. **`Microsoft.Windows.10.SDNMonitoring` is treated as unvalidated on Windows Server 2025** until a
   lab confirms discovery against a Failover Clustering-hosted Network Controller. Until then the SDN
   capability carries an explicit caveat in its documentation. If validation fails, the options are
   to constrain the capability to Service Fabric deployments or to withdraw it.

3. **The ships-with-SCOM set is derived, not hand-written.** `Export-MpDependencies.ps1` now reads the
   VSAE `References/OM*` folders — the authoritative list of packs that ship with SCOM — and falls
   back to a literal list only where VSAE is absent. A hand-maintained list is what produced defect 1.

4. **Every declared reference must be consumed.** A reference that no element in the pack uses is
   removed. The two identified in defect 2 are removed in the next version; they are not removed from
   `1.0.0.0`, because that would make the published documentation describe packs that differ from the
   sealed download.

5. **Declared minimums are established, not inherited.** The minimum for each reference is the oldest
   version we have validated against, recorded with evidence. Where no such evidence exists, the
   minimum is the version we sealed against — accurate, if conservative — rather than a lower number
   nobody has tested. VMM minimums are read from the versions shipped in
   `…\Virtual Machine Manager\ManagementPacks` on the target media rather than guessed.

## Options considered

**Reimplement the functionality in our own packs and drop the external references.** This was the
question that prompted the audit, and it is the wrong answer for most of the set. If a customer runs
failover clustering and monitors it with SCOM, they already have Microsoft's Cluster pack — that is
how clustering is monitored. Discovering clusters ourselves would produce a second class hierarchy
for the same physical objects: two health rollups, two alert sources, doubled agent workload, and a
console showing each node twice. It would also forfeit the correlation that is much of this product's
value, since we could no longer roll up the objects the customer already monitors. And the packs are
not, in fact, stale.

**Reimplement selectively where the dependency is genuinely dead.** Correct, and already the pattern:
`Capability.Storage` and `Capability.NetworkATC` carry no external management pack dependency and
discover through PowerShell. Applied to Pure Storage in
[ADR 0052](0052-pure-storage-monitoring-strategy.md).

**Pin exact versions rather than minimums.** Rejected. A reference version is a minimum by design;
pinning exactly would break every customer whose management group is newer than our build.

**Accept publisher metadata as sufficient evidence.** Rejected for SDN specifically. A support
statement on a download page is a metadata field, not a test result, and in SDN's case the platform
architecture demonstrably changed underneath the pack.

## Consequences

- Currency becomes a release obligation with a named owner, instead of an assumption that decays
  silently between releases.
- The Cluster capability's real acquisition burden drops from three packs to two, correcting
  documentation that was overstating the prerequisite list for every operator.
- The SDN capability ships with a stated caveat until lab evidence exists. That is worse marketing
  and better engineering than implying validation we do not have.
- Removing unused references changes pack content, so it lands in the next version rather than
  retrofitting `1.0.0.0`.
- Establishing true minimums requires testing against older management packs, which needs lab
  capacity we have not yet allocated.

## References

- [ADR 0050 — Prerequisite acquisition and import preflight](0050-prerequisite-acquisition-and-preflight.md)
- [ADR 0052 — Pure Storage monitoring strategy](0052-pure-storage-monitoring-strategy.md)
- [Research spikes](../research-spikes.md) — dependency currency and platform validation
- [Microsoft management pack list](https://learn.microsoft.com/en-us/system-center/scom/management-pack-list)
- [What's new in Windows Server 2025](https://learn.microsoft.com/en-us/windows-server/get-started/whats-new-windows-server-2025)
