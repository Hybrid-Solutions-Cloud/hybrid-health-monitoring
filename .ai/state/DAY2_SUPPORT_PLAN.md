# Day-2 support implementation

## Goal and boundaries

Audit and improve the Hyper-V management pack's complete 360-degree support experience:
traceable health rollups, actionable per-object and per-monitor knowledge, meaningful warning
signals, Microsoft references, and diagnostic evidence. Work in source and regression tests.
Do not directly edit the live distributed application, clear alerts, modify cluster workloads,
or change Active Directory permissions. Installed sealed 1.3.7.0 remains the comparison baseline.

## Work plan

1. Finish read-only diagnosis of current cluster critical states and preserve evidence.
2. Inventory every authored class, unit monitor, dependency monitor, rule and task; audit
   containment versus health dependencies, aspect routing, optional capabilities and unavailable
   members. Identify missing links and unjustified cross-domain propagation.
3. Research Microsoft primary documentation by capability and failure condition. Build a
   maintainable support catalog with source provenance, exact configured state/threshold semantics,
   diagnostic steps, safe corrective options, escalation and recovery verification.
4. Generate console knowledge and browsable support documentation from that catalog, retaining
   existing specific knowledge. Include inherited/vendor boundaries and guest-agent limitations.
5. Correct proven source defects in rollups and diagnostic context. Add warning behavior only
   where supported by measured signals and defensible thresholds; never fabricate predictive health.
6. Validate coverage, reference integrity, state semantics and topology regressions; run MP schema,
   SDK, unit, documentation and safe live source-coupled checks. Record untested external capabilities.
7. Produce a source/resealing handoff, with exact validation results and outstanding deployment gates.

## Initial live findings (September 6)

- Both Hyper-V clusters: all four nodes Up; both CSV01 volumes Online.
- Site A: four libxfr01 VM Configuration resources Failed; their four VmIds are absent from
  Get-VM inventory on both nodes. Suspected orphaned roles, not confirmed permission to delete.
  TimsLinux is registered and Off, with its VM configuration resource not failed.
- Site B: Replica Broker network name Failed, broker Offline. Current event 1194 reports failure
  creating its AD computer object; the cluster name object exists, broker computer object was not
  returned by the read-only AD query. Exact permission/quota cause not yet established.
- Repeated resource failures drive current HCS failover-churn monitors; alert wording must not
  imply that each event is a distinct VM migration or cluster failover.
- Main solution discovery misses the separate VMM fabric containment contribution.

Raw live evidence stays in ignored `tmp/cluster-investigation/`; public support content must use
generic examples, not environment identifiers. Existing state/validation edits are preserved.
