# Day-2 support candidate validation — September 6, 2026

## Sealed release publication

The validated source is published as sealed version 1.3.8.0. Release source commit
`fd356e266dad446be1ba872bb9474a3f4764786d` and asset commit
`d4a942ed8e79197226ba66f74e93d99ac2e05c73` are on main. Actions run `34055922030` passed MP,
documentation, and Pages jobs; all 31 deployed immutable assets match the signed build and all 30
checksums pass. Exact sealed upgrade/import and runtime soak remain separate operator acceptance
work and are not claimed as passed.

## Publication update

Subsequently committed and pushed at the operator's request: source/docs/tests `631bc9f`, followed
by test-only correction `3dbd44d`. GitHub Actions run `34050218756` passed MP validation, site build
and Pages deployment. The first CI run found a VMM fixture relying on a locally installed module;
the corrected fixture explicitly stubs module discovery and passed all 13 focused tests before
repush. Shipped MP logic is identical between these two commits. Sealing and actual sealed-version
validation/import remain separate gates. The original local-validation record below is retained.

## Scope and deployment boundary

Source work on `main`, based on `8fbb62e`. Installed sealed version remains **1.3.7.0**.
Candidate XML was built at **1.3.8.0** for testing only; this does not reserve/publish that version.
No live DA edits, candidate import, alert closure, cluster/VM repair, directory change, sealing,
commit or push was performed for this task. Previous local state/validation edits are preserved.

## Implemented coverage

- 13 management packs; 48 classes, 171 unit monitors (159 enabled), 149 health dependencies,
  80 rules and 74 tasks. All 522 elements have console support knowledge and generated Markdown.
- Object-specific scope/ownership descriptions, original detailed knowledge retained except three
  explicitly corrected cluster articles, compiled conditions/configuration, alert behavior,
  read-only investigation, corrective-action boundaries, escalation, recovery and Microsoft links.
- Probe-specific reasons for all 31 core state-valued monitors; numeric monitors show exact
  expressions and thresholds. No invented warning band where none is implemented.
- 34 unique Microsoft Learn links, all HTTP 200 in the final link check.
- Root paths proven for 159/159 enabled product leaves. Added Security aspect propagation,
  missing domain performance/configuration routes, SMB/SAN participation containment, and VMM
  enterprise discovery links. External/native monitor internals and live candidate membership
  are explicitly outside this source graph proof.
- Cluster diagnostics now identify roles/resources, owners, timestamps, error codes, nodes,
  networks and CSV/counter identity. Role-failure events are grouped by named role and five-minute
  bucket, not advertised as confirmed failovers. Paused-node dynamic votes are included.
- Core host/VM state context includes collector/sample time and VM identity; affected auto-start
  VMs and unhealthy integration services are named in bounded detail.

## Validation evidence

| Gate | Result / evidence |
|---|---|
| Official MP and MAML schemas | All 13 pass; repeated within focused tests. |
| Root graph | 159 enabled leaves reachable; zero product gaps. Three external references listed separately. |
| Final focused tests | 107 passed, 0 failed; build, support, unique display/knowledge identity and cluster local-query regressions. `tmp/day2-final-supplemental-tests.log` |
| Latest support/negative graph tests | 13 passed, 0 failed, including empty-input rejection and a deliberately disconnected enabled leaf. `tmp/day2-graph-negative-tests.log` |
| Other repository unit tests | 31 passed, 0 failed (Azure Local, legacy Hyper-V and dependency documentation). `tmp/day2-other-unit-tests.log` |
| Full product runtime regression | 239 passed, 0 failed, 0 skipped, 1600.32 seconds. Final later support/generator changes are covered by the 107-test supplemental run and latest 13-test support run. `tmp/day2-release-candidate-tests.log` |
| Documentation production build | Final pass, 242.23 seconds; standard large-chunk warning. `tmp/day2-final-docs-build.log` |
| Generated reference consistency | Regeneration is byte-identical; public support examples contain none of the investigated environment identifiers. `tmp/day2-support-repro/` |
| Microsoft URL check | 34/34 HTTP 200. `tmp/day2-final-link-check.json` |
| SDK verification | All 13 pass; 159 expected `TypeDefinitionInUnsealedMP` warnings, zero unexpected issues. `tmp/day2-final-sdk.log` |
| Live cluster source probes | Pass on one node in each cluster, read-only with in-memory property-bag capture; real role failures and named CSV/network context returned. |
| Live host and VM source probes | Pass on one host and one running VM; both pipeline states Good and new identity/timestamp context present. |
| Live installed DA path | Confirmed solution → fabric → cluster service → Availability and Clustering → failed-role/failure-churn leaves, with native Microsoft paths also present. |

SDK caveat: verification used a separate **1.3.7.0 compatibility build** to resolve the installed
sealed product references without importing or signing a candidate. This is source/SDK validation,
not verification of the final sealed 1.3.8.0 upgrade set. VSAE is unavailable on this jump server.
The sealing machine must perform release-mode VSAE/SDK/identity/signature validation of the actual
new version and complete compatible pack set before deployment.

The first broad pass had 233 passing tests and one obsolete knowledge-count assertion. A later
focused pass exposed four additional assertions that assumed availability-only dependencies;
those were replaced with aspect-preservation/coverage assertions. SDK found duplicate generated
relationship displays in two packs; the generator now updates existing entries, with a regression
test. These failures were resolved in source, not ignored or suppressed.

## Live incident conclusions

- All four cluster nodes Up, both CSVs Online, cluster networks Up and witnesses Online at the
  final probe. This does not establish guest application health.
- Site A: four libxfr VM Configuration resources fail with path-not-found (0x3); their VM IDs
  were absent from both possible owners. Likely orphaned roles or missing registration/configuration,
  requiring workload/backup/VMM ownership reconciliation before removal or restore.
- Site A's separately registered stopped Linux VM requires intended-state confirmation.
- Site B: Replica Broker Network Name fails; current event 1194 reports AD computer-object
  creation failure, the CNO exists, and the broker VCO was not returned. The read-only CNO token/OU
  ACL check found no applicable CreateChild grant. Directory-owner validation of delegation,
  prestaging, quotas and replication is required; no AD permissions were modified.
- Repeated retries explain the HCS failure-window critical monitors. Repairing the actual cause
  need not immediately clear an accumulated lookback-window count.

Raw environment evidence remains in ignored `tmp/cluster-investigation/`. Public support examples
use generic identities. Do not copy raw environment data into generated public pages.

## Resealing and acceptance handoff

1. Review source diff and the final regression result; preserve unrelated existing edits.
2. Commit/push only when requested, following governance work-item requirements.
3. On the authorized signing machine, choose the next approved version, build/seal the full set
   with the established permanent identity, then run release validation and publish through CI.
4. Regenerate the support reference from that exact source/version if needed; do not edit live DAs.
5. Import through the normal deployment process, verify versions and wait for fresh discoveries.
6. Confirm VMM singleton links, SMB/SAN participation and Security/performance/configuration
   leaf-to-root behavior on technologies actually present. Require fresh runtime evidence; static
   coverage is not blanket certification of every optional vendor capability.
7. Remediate the existing cluster incidents separately with the relevant service and AD owners.

## Maintainable source entry points

- `src/hyper-v/scom-mp/support/support-catalog.psd1`
- `src/hyper-v/scom-mp/tools/HyperVPrivateCloud.Support.psm1`
- `src/hyper-v/scom-mp/tools/HyperVPrivateCloud.HealthModel.psm1`
- `src/hyper-v/scom-mp/tools/Test-HyperVPrivateCloudHealthGraph.ps1`
- `src/hyper-v/scom-mp/tools/Export-HyperVPrivateCloudSupportGuide.ps1`
- `docs/hyper-v/support/index.md` and generated capability/reference pages
- `tests/unit/HyperVPrivateCloud.Day2Support.Tests.ps1`
