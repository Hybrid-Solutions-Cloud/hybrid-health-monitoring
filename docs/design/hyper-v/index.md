---
title: Hyper-V design
description: Architecture map and design contracts for the sovereign Hyper-V SCOM Management Pack Suite.
---

# Hyper-V design

Hyper-V Private Cloud Monitoring is an enterprise on-premises monitoring suite engineered entirely for System Center Operations Manager (SCOM). It has zero cloud, Azure Monitor, or Azure Arc runtime dependencies.

| Design lane | Commitment | Status |
|---|---|---|
| [SCOM Management Pack](scom-mp.md) | Committed | Production release sealed (1.3.5.0); full architecture contracts published |

## SCOM Management Pack solution

The SCOM lane provides implementation-grade design contracts for the
[end-to-end architecture](architecture.md), [Management Pack structure](management-pack-structure.md),
[dependency and ownership contract](v2-dependency-and-ownership-contract.md),
[class and relationship model](class-and-relationship-model.md),
[discovery and workflows](discovery-and-workflow-architecture.md),
[health and alerts](health-and-alert-architecture.md),
[Distributed Application](distributed-application.md), [authoring standards](authoring-standards.md),
[security and operability](security-and-operability.md), and
[validation and release](validation-and-release.md).

The diagrams on these pages are rendered by the site's Vue component so architecture, sequence,
state, class, and decision flows remain readable in both light and dark documentation themes.

The [Hyper-V Distributed Application](distributed-application.md) belongs only to this SCOM
solution. Optional [SquaredUp Dashboard Server](../../hyper-v/squaredup-dashboard-server.md)
content also belongs to the Hyper-V SCOM solution.

## Platform design questions

- Which Windows Server, SCOM, cluster, and optional SCVMM versions are supported?
- Which standalone and clustered entities have stable discovery keys and ownership relationships?
- When is Network ATC the host-network authority, and when is networking manual or owned by
  SCVMM/SDN?
- Which signals should become default monitors, disabled monitors, collection rules, diagnostics,
  or exclusions?
- Which stable keys and relationships populate each standalone-host or cluster
  [Distributed Application](distributed-application.md)?

SCOM packaging is governed by [ADR 0022](../decisions/0022-scom-management-pack-packaging-boundaries.md)
and requires completely independent Azure Local and Hyper-V runtime products.

These questions are resolved through the [research backlog](../research-spikes.md), not by copying
the Azure Local design.
