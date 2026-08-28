# Handoff

## Current session

- **V2 dependency decision accepted:** Added ADR 0039 and the public v2 dependency/ownership
  contract. The product console identity is `Hyper-V Private Cloud Monitoring`, console root is
  `Hyper-V Private Cloud`, and the new namespace is
  `HybridSolutionsCloud.HyperVPrivateCloud`. Standalone core remains independent; optional
  capability adapters own external prerequisites and relationships.
- **Microsoft contracts inspected:** Downloaded the official current Microsoft Windows Server
  Cluster `10.1.0.0` and Windows Server OS/CSV `10.1.2.2` packages from Microsoft, extracted and
  exported their sealed MPs, and inventoried public classes/relationships. The Cluster package
  exposes cluster nodes, groups, networks, resources, and containment. The Windows Server package
  exposes public CSV and cluster-disk objects plus discovery/monitoring. V2 will reuse these
  identities rather than create duplicate cluster/CSV objects.
- **Machine-readable dependency gate:** Added
  `src/hyper-v/scom-mp/contracts/dependencies.v2.json` with approved Cluster/CSV versions,
  authoritative class IDs, and explicit pending spikes for Pure, VMM, SDN, SOFS, and physical
  networking. Pester now enforces the product identity and approved Microsoft contracts.
- **Latest verification:** Hyper-V Pester passes 14/14, VitePress production build passes, new
  local Markdown links resolve, dependency JSON parses, and `git diff --check` passes. The VitePress
  build reports only the existing large-chunk warning.

- **Generated override examples and semantic CI gate:** Added
  `Update-HyperVOverrideExamples.ps1`, regenerated all six Hyper-V Lab/Standard/Strict example
  XML files from the supported generator, and documented that the examples are generated
  artifacts. The updater's `-Check` mode performs an ordinal byte comparison and is invoked by
  the Hyper-V Pester suite, so hand edits or generator drift fail CI.
- **Offline override contract validation:** Added tests that build version `0.2.0.0`, generate
  every profile, and resolve each referenced context class, discovery, monitor, module, and
  configuration parameter against the built sealed-product XML. The tests also require every
  declared reference alias to be used.
- **Latest verification:** Hyper-V Pester passes 13/13; the Hyper-V product contract suite and
  generated-example drift check pass; PSScriptAnalyzer reports zero warnings/errors for both
  override tools; `git diff --check` passes. These changes are ready for commit and push.

- **Hyper-V v2 plan:** Updated root `PLAN.md` to make Hyper-V Private Cloud Monitoring v2 the
  active priority and Azure Local explicitly under development. The `0.1` Hyper-V preview is now
  classified as a superseded host-centric baseline rather than a complete private-cloud product.
  Added the clean-sheet modular package architecture, authoritative Microsoft/vendor dependency
  policy, complete compute/cluster/S2D/SAN/Pure/SMB/network/ATC/SDN/VMM catalog, DA and console
  redesign, research spikes, implementation sequence, override remediation, compatibility path,
  lab matrix, release gates, and definition of done. No source code or release assets changed.
- **Validation:** `git diff --check` passed. Branch remains `main`; `PLAN.md` and this handoff are
  modified and uncommitted.
- **Override remediation begun:** Hyper-V override generation now separates the unsealed override
  MP identity (`-Version`, default `1.0.0.0`) from mandatory sealed references
  (`-ProductVersion`). Profile schema `1.2` carries explicit monitor IDs and context classes and
  rejects unknown schemas. Updated all three Hyper-V profiles, operator examples, design guidance,
  contract invocation, and Pester assertions. Hyper-V Pester passes 11/11 and the product contract
  suite passes. The equivalent Azure Local remediation remains deferred while that product is
  explicitly under development.
- **Cluster dependency evidence:** The installed sealed SCOM 2022
  `Microsoft.Windows.Cluster.Library` is version `7.0.8447.6` and exposes public Cluster, Cluster
  Service, and Virtual Server model classes, but no public CSV class. V2 can reuse Microsoft
  cluster identity while retaining HCS-owned CSV/S2D/SAN classes with explicit correlations.

- **SCOM lab preview published:** Published GitHub prerelease
  `scom-lab-preview-v0.1.0` with separate Azure Local and Hyper-V ZIPs. Each ZIP contains the five
  sealed version `0.1.0.0` MPs, a lab-only notice, import order, and per-file SHA-256 checksums. A
  top-level checksum file covers both ZIPs. No signing key or secret-like file is present.
- **Public downloads:** Added `docs/downloads/scom-lab-preview.md`, a home-page download action,
  both product-page links, administration-guide links, and navigation entries. GitHub Pages run
  `33202030487` completed successfully. The public page and all three release assets returned HTTP
  200 after deployment.
- **Publication validation:** Rebuilt all ten source XML artifacts with the preview public token;
  every SHA-256 hash matched the XML used for transient sealing. Both five-project suites passed
  Microsoft VSAE/SDK verification against OM2022, all ten sealed assemblies passed strong-name
  verification, both product contract suites passed, Pester passed 15/15, PSScriptAnalyzer passed
  for eight scripts, VitePress built, gitleaks found no leaks, package/checksum checks passed, and
  `git diff --check` passed.
- **Release status boundary:** This is deliberately a GitHub prerelease for isolated or approved
  pre-production labs. Public key token `14a10c8275285f00` is transient. The artifacts are not
  governed-release-signed, representative-lab-certified, or production-supported; customer
  overrides created against the preview identity may need rebuilding for the permanent release.
- **Missing-pipeline root cause:** Generated `out/` directories are intentionally ignored. The
  planning ADR proposed `mp-build.yml` and release asset publication, but that workflow was never
  implemented. Release Please was archived during the July Azure DevOps/VitePress migration, and
  the active GitHub/Azure DevOps workflows validate source/deploy docs without sealing or
  publishing MPs. The August test sealing therefore stopped in `D:/tmp/` until this prerelease.
- **Published commit/release:** Download documentation commit `ef9b36a`; prerelease and assets at
  `https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/tag/scom-lab-preview-v0.1.0`.
- **2026-08-28 artifact audit:** Confirmed that the repository tracks complete source templates,
  manifests, build tools, validators, and override examples for independent Azure Local and
  Hyper-V SCOM products. Git tracks no sealed `.mp` or `.mpb` artifacts now, and
  `git rev-list --objects --all` found no such artifact anywhere in repository history.
- **Repository-local output:** Ignored `src/azure-local/scom-mp/out/development/` and
  `src/hyper-v/scom-mp/out/development/` directories remain on this workstation. Each contains
  four unsealed development XML outputs plus an inventory; optional Reporting is absent because
  the default development build excludes it. The inventories explicitly mark the outputs
  `releaseReady: false`, `sealed: false`, `signed: false`, and `labImported: false`.
- **Transient sealed artifacts found:** The five Azure Local and five Hyper-V version `0.1.0.0`
  test-sealed `.mp` files remain outside the repository under
  `D:/tmp/hcs-scom-seal-92cb5ef4f7374e9299ece6638c3cef63/{azure-local,hyper-v}/`.
  All ten expose public key token `14a10c8275285f00`; an independent `sn.exe -vf` audit returned
  exit code 0 and `Assembly ... is valid` for every file. These are transient development/test
  artifacts, not governed-release-signed, published, or lab-certified deliverables.
- **Audit conclusion:** The previous completion claim is accurate only for authored development
  source plus OM2022 verification/test sealing. It is not accurate if interpreted to mean that
  release Management Packs were committed or published. A governed release still needs a durable
  artifact location, release signing, and representative SCOM lab certification.
- **Public-site reconciliation:** Updated the landing/status pages, both SCOM product and design
  lanes, validation pages, roadmap, administration guides, source READMEs, current ADR notes, and
  the Azure Local package diagram to record completed OM2022 VSAE verification and transient test
  sealing. Standalone MPVerify is no longer represented as an additional release gate.
- **ServiceNow clarification:** Audited the existing integration source and public docs. ServiceNow
  supplies the SCOM Events connector; the repository already supplies separate Azure Local and
  Hyper-V profiles, the normalized AlertId mapping/lifecycle contract, offline validation, ADR, and
  operator guidance. No custom connector or automated ServiceNow mutation exists or is needed for
  the first lab. Live Windows MID Server configuration and certification remain next; Azure Monitor
  Secure Webhook/common-alert-schema artifacts remain future implementation.
- **Microsoft verification unlocked:** Located the installed VSAE 1.10.571.0 OM2022 dependency
  set and Visual Studio 2022 full-framework MSBuild. Replaced both PowerShell 7 in-process SDK
  loaders with a shared VSAE `VerifyMergedManagementPack` MSBuild project and product wrappers.
- **Verified defect fixed:** Microsoft verification proved that
  `Microsoft.SystemCenter.ServiceDesigner.Component` does not exist in the OM2022 Service Designer
  library. Changed all five Hyper-V and six Azure Local DA component classes to the verified
  `Microsoft.SystemCenter.ServiceDesigner.ServiceComponentGroup` base and added regression checks.
- **SDK and test-seal result:** The complete Hyper-V and Azure Local suites—Library, Discovery,
  Monitoring, Presentation, and optional Reporting—pass Microsoft VSAE/SDK verification against
  the installed OM2022 sealed dependencies. Both five-MP chains then test-sealed successfully in
  dependency order with a transient development key stored only under `D:/tmp/`.
- **Additional verified fixes:** Renamed discovery-script `$data` and helper `$Target` variables so
  they cannot collide with SCOM expression namespaces, split malformed MAML into sibling sections,
  and made all three-state monitor health mappings unique. Added regression assertions.
- **Sealing runtime:** VSAE `FASTSEAL.exe` targets CLR v2.0.50727. `NET-Framework-Core` initially
  reported `Removed`, then completed installation through Server Manager and now reports
  `Installed`. **No restart was performed, and the operator explicitly prohibited restarting this
  server.**
- **Latest validation:** Both complete five-MP VSAE/SDK wrappers passed; all ten transient artifacts
  test-sealed and passed strong-name verification; Pester 15/15; PSScriptAnalyzer zero warnings or
  errors; VitePress production build and `git diff --check` passed; public ADO identifier scan
  returned zero matches. VitePress emitted only its existing large-chunk warning.
- **Outcome:** Implemented the Azure Local SCOM development baseline, both independent Azure
  Monitor Health Model baselines, and the optional SCOM-to-ServiceNow development contract. Updated
  research, ADRs, architecture, operator guidance, navigation, roadmap, source READMEs, changelog,
  and private delivery tracking.
- **Azure Local SCOM:** Added five package sources (Library, Discovery, Monitoring, Presentation,
  optional Reporting), 17 classes, 28 relationships, staged local topology discovery, a
  platform-owned Distributed Application with six health components, 14 unit monitors, six
  aggregate monitors, 12 dependency rollups, 11 curated monitor alerts, 12 performance rules, four
  event rules, a diagnostic task, operational knowledge, and 14 views.
- **Overrides:** Added separate customer-owned Discovery and Monitoring override generators plus
  Lab, Standard, and Strict starter profiles. The Default Management Pack remains prohibited.
- **Azure Local Azure Monitor:** Added an independent monitor account/Health Model Bicep baseline,
  deployment and six domain entities, separate compute/storage Azure-resource entities, documented
  Azure Local CPU and storage-degraded signals, deployment state alerts, KQL research queries, and
  a workbook. Unproven domains remain Unknown.
- **Hyper-V Azure Monitor:** Accepted the constrained go decision and added an independent Bicep
  baseline. Arc-enabled SCVMM supplies inventory; Arc-enabled Server plus AMA/DCR supplies host
  heartbeat, hypervisor CPU, cluster-event, and telemetry-coverage signals. Explicit DCR
  associations and complete fabric parity remain lab work.
- **ServiceNow:** Accepted the connector-boundary ADR and added separate Azure Local and Hyper-V
  connector profiles, a normalized AlertId-based mapping, an offline compatibility validator, and
  public setup/lifecycle/security guidance. Live MID Server and ServiceNow validation remains.
- **Architecture:** Accepted ADRs 0032–0038 and promoted ADR 0023 to the constrained Hyper-V Azure
  Monitor implementation decision. Added four Azure Local SCOM draw.io diagrams with public SVG
  exports and repaired three previously committed draw.io files that had obsolete stub XML appended.
- **Private tracking:** Updated all existing Azure Local and Hyper-V SCOM/Azure Monitor delivery
  items with exact baseline and remaining-gate status. Added a separate integrations Epic, a
  SCOM-to-ServiceNow Feature, and research, architecture, implementation, and lab-validation
  Stories. No internal identifiers or board links appear in public repository content.
- **Validation passed:** Azure Local and Hyper-V MP contracts; Azure Local and Hyper-V Azure Monitor
  Bicep/contract checks; SCOM-to-ServiceNow contract; Pester 15/15; product PSScriptAnalyzer zero
  warnings/errors; gitleaks zero findings; 20 JSON files parsed; seven draw.io files parsed; local
  Markdown links passed; changed-file structural Markdown lint passed; VitePress production build;
  `git diff --check`; public work-item scan zero. VitePress reports only its existing large-chunk
  warning.
- **Governance:** Registry resolves this as the HCS `docs` profile. The governance server could not
  inspect the Windows path for drift and its optional markdown/link binaries are not installed;
  equivalent local checks were run directly.
- **Release gates:** Both complete suites are SDK dependency-resolved and transiently test-sealed
  against OM2022, but no test output is a public release artifact. Governed release signing and
  SCOM-lab certification remain; standalone MPVerify is not a separate gate.
  Neither Azure Monitor baseline has been deployed to a representative subscription. ServiceNow
  MID Server behavior and the supported SCOM version pair are not lab-certified.
- **Branch:** `main`.
- **Latest documentation validation:** VitePress production build passed, the ServiceNow contract
  validator passed, Pester passed 15/15, PSScriptAnalyzer returned zero warnings/errors, edited
  draw.io/SVG XML parsed, gitleaks reported zero findings, the public work-item identifier scan
  returned zero matches, and `git diff --check` passed. Governance MCP could not access the local
  Windows path; its optional markdownlint/lychee executables are also not installed server-side.
- **Next action:** Do not restart this server. Import the transiently test-sealed products into the
  operator-provided SCOM labs in dependency order and execute the documented SCOM and ServiceNow
  matrices. Establish the governed release-signing identity only after the lab evidence is
  approved. Azure Monitor live deployment remains a separate lab workstream.

## Last session

- **Outcome:** Authored the functional Hyper-V SCOM development baseline and reconciled public
  design, roadmap, product, catalog, administration, ADR, source README, changelog, and AI state.
- **Library:** 13 localized public classes, 70 localized properties, and 20 localized relationships.
  The model has a stable cluster-or-host boundary, non-hosted mobile VM identity, hosted host-local
  objects, a Service Designer DA root, and five component classes.
- **Discovery and DA:** Added registry role seed plus staged PowerShell topology discovery for
  Hyper-V, Failover Clustering, CSV, virtual switches, Network ATC, Replica facts, monitoring
  pipeline, DA roots/components, and 20 membership/reference relationships.
- **Monitoring:** Added one shared cookdown data source, nine three-state host monitors, auto-resolve
  alerts, 10 DA dependency rollups, 12 performance rules, four Failover Clustering event-alert
  rules, 13 operational-knowledge articles, and one read-only diagnostic task. Five
  high-cardinality/topology-sensitive performance rules are disabled by default.
- **Presentation:** Added four folders and 10 localized service-health, inventory, alert,
  performance, and event views. DA roots derive from the Service Designer service class and roll up
  through Compute, Virtual Machines, Storage, Network, and Monitoring Pipeline components.
- **Overrides:** Added generator-backed Lab, Standard, and Strict profiles. Each invocation creates
  separate unsealed, customer-owned Discovery and Monitoring override MPs. The Default Management
  Pack remains prohibited.
- **Build and validation:** Added deterministic element localization, structural product contracts,
  and a Microsoft SDK verification command that requires official target-version dependency MPs
  and fails on missing dependencies or verification errors.
- **Architecture:** Accepted ADRs 0027–0029 and 0031. Release-specific dependency versions,
  test/release sealing, signing identity, and lab certification remain release gates, not unbuilt
  source work.
- **Private tracking:** Updated the architecture, classes/discovery, monitoring/overrides, DA
  membership, DA rollup, and release-validation items with exact status and remaining gates. No
  internal work-item identifiers or links appear in public repository content.
- **Validation passed:** Hyper-V MP contract suite; Pester 8/8; PSScriptAnalyzer zero
  warnings/errors; VitePress production build; changed-file Markdown lint with VitePress-compatible
  line/H1 exclusions; `git diff --check`; public work-item scan zero; high-confidence secret scan
  zero. The VitePress build reports only its existing large-chunk warning.
- **External gate:** The Microsoft SDK assembly is installed, but official sealed System, Windows,
  Service Designer, Health, Performance, System Center, and Data Warehouse dependency MPs are not
  locally available. Full SDK verification therefore cannot truthfully pass yet. Test sealing,
  representative standalone/cluster SCOM lab import, topology lifecycle, fault/recovery,
  maintenance, failover, scale, upgrade/removal, release sealing/signing, and optional Reporting,
  SLO, and SquaredUp certification remain.
- **Branch:** `main`.
- **Next action:** Export the official dependency MPs from each target SCOM management group, run
  `Test-HyperVManagementPacksWithSdk.ps1`, correct any verified schema/dependency findings, then
  test-seal and execute the documented standalone and cluster lab matrix.
