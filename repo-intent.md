# Repo intent — hybrid-health-monitoring

**SCOM and Azure Monitor health models for Hyper-V and Azure Local.**

## What this repo is

Defines infrastructure health as an entity model — signals, state, rollup, alerts,
customization, lifecycle — not merely a list of metric thresholds. Two platform
tracks: **Azure Local** (SCOM Management Pack committed, Azure Monitor Health
Models committed) and **Hyper-V** (SCOM committed, Azure Monitor constrained
through Arc-enabled SCVMM and Arc-enabled Servers). The platforms share SCOM
authoring patterns and health semantics where appropriate, but their topology,
discoveries, signals, prerequisites, support matrices, and release boundaries stay
explicit and separate.

## Shape

- `src/` — the health model source
- `docs/` — VitePress documentation, published at
  labs.hybridsolutions.cloud/hybrid-health-monitoring/
- `tools/`, `tests/`, `diagrams/`
- `PLAN.md`, `STANDARDS.md`, `REFERENCES.md` — governance docs at root
- release-please-managed versioning (`.release-please-manifest.json`)

## Status

Active. Full HCS standards badge/governance stack (AGENTS.md, CODEOWNERS,
CONTRIBUTING.md).
