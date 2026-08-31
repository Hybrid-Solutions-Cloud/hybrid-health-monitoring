import { defineConfig } from 'vitepress'

const repositoryUrl = 'https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring'
const base = '/hybrid-health-monitoring/'

// ---------------------------------------------------------------------------
// Sidebar building blocks
//
// Each page has exactly one home. Sidebars are assembled from the shared arrays
// below and reused across URL prefixes rather than restated, so a page's nav
// position is edited in one place and a reader sees the same tree no matter
// which URL prefix they entered from.
// ---------------------------------------------------------------------------

const hyperVDesign = {
  text: 'Design and architecture',
  collapsed: true,
  items: [
    { text: 'Design map', link: '/design/hyper-v/' },
    { text: 'Solution design', link: '/design/hyper-v/scom-mp' },
    { text: 'Architecture', link: '/design/hyper-v/architecture' },
    { text: 'Management pack structure', link: '/design/hyper-v/management-pack-structure' },
    { text: 'V2 dependencies and ownership', link: '/design/hyper-v/v2-dependency-and-ownership-contract' },
    { text: 'Class and relationship model', link: '/design/hyper-v/class-and-relationship-model' },
    { text: 'Discovery and workflows', link: '/design/hyper-v/discovery-and-workflow-architecture' },
    { text: 'Health and alerts', link: '/design/hyper-v/health-and-alert-architecture' },
    { text: 'Distributed Application', link: '/design/hyper-v/distributed-application' },
    { text: 'Overrides and tuning', link: '/design/hyper-v/override-and-tuning-architecture' },
    { text: 'Authoring standards', link: '/design/hyper-v/authoring-standards' },
    { text: 'Security and operability', link: '/design/hyper-v/security-and-operability' },
    { text: 'Validation and release', link: '/design/hyper-v/validation-and-release' },
    { text: 'Governed release runbook', link: '/design/hyper-v/release-runbook' },
    { text: 'Azure Monitor solution design', link: '/design/hyper-v/azure-monitor' },
  ],
}

const hyperVSidebar = [
  {
    text: 'Get started',
    items: [
      { text: 'Overview', link: '/hyper-v/' },
      { text: 'Prerequisites', link: '/hyper-v/prerequisites' },
      { text: 'Download', link: '/downloads/hyper-v-private-cloud' },
    ],
  },
  {
    text: 'Deploy and operate',
    items: [
      { text: 'Administration guide', link: '/hyper-v/management-pack-guide' },
      { text: 'Operations guide', link: '/hyper-v/operations-guide' },
      { text: 'Monitoring catalog policy', link: '/hyper-v/monitoring-catalog' },
      { text: 'Management pack overview', link: '/hyper-v/scom-mp' },
    ],
  },
  {
    text: 'Azure Monitor track',
    items: [
      { text: 'Health model status', link: '/hyper-v/azure-monitor' },
      { text: 'Research and parity gaps', link: '/hyper-v/azure-monitor-research' },
    ],
  },
  {
    text: 'Dashboards',
    collapsed: true,
    items: [
      { text: 'SquaredUp Dashboard Server', link: '/hyper-v/squaredup-dashboard-server' },
      { text: 'SquaredUp Cloud', link: '/hyper-v/squaredup-cloud' },
    ],
  },
  {
    text: 'Reference',
    collapsed: true,
    items: [
      { text: 'Monitoring research', link: '/hyper-v/monitoring-research' },
      { text: 'Research spikes', link: '/design/research-spikes' },
    ],
  },
  hyperVDesign,
]

const azureLocalDesign = {
  text: 'Design and architecture',
  collapsed: true,
  items: [
    { text: 'Design map', link: '/design/azure-local/' },
    { text: 'Solution design', link: '/design/azure-local/scom-mp' },
    { text: 'Architecture', link: '/design/azure-local/architecture' },
    { text: 'Management pack structure', link: '/design/azure-local/management-pack-structure' },
    { text: 'Class and relationship model', link: '/design/azure-local/class-and-relationship-model' },
    { text: 'Discovery and workflows', link: '/design/azure-local/discovery-and-workflow-architecture' },
    { text: 'Health and alerts', link: '/design/azure-local/health-and-alert-architecture' },
    { text: 'Distributed Application', link: '/design/azure-local/distributed-application' },
    { text: 'Overrides and tuning', link: '/design/azure-local/override-and-tuning-architecture' },
    { text: 'Validation and release', link: '/design/azure-local/validation-and-release' },
    { text: 'Azure Monitor solution design', link: '/design/azure-local/azure-monitor' },
    { text: 'Azure Monitor architecture', link: '/design/azure-local/azure-monitor-architecture' },
  ],
}

const azureLocalSidebar = [
  {
    text: 'Get started',
    items: [
      { text: 'Overview', link: '/azure-local/' },
      { text: 'Choose a delivery track', link: '/comparison/' },
    ],
  },
  {
    text: 'SCOM management pack',
    items: [
      { text: 'Overview', link: '/azure-local/scom/' },
      { text: 'Prerequisites', link: '/azure-local/scom/prerequisites' },
      { text: 'Download lab preview', link: '/downloads/scom-lab-preview' },
      { text: 'Administration guide', link: '/azure-local/scom/management-pack-guide' },
      { text: 'Operations guide', link: '/azure-local/scom/operations-guide' },
      { text: 'Monitoring catalog', link: '/azure-local/scom/monitoring-catalog' },
      { text: 'Health-rollup tree', link: '/azure-local/scom/diagrams/health-tree' },
      { text: 'SquaredUp Dashboard Server', link: '/azure-local/scom/squaredup/' },
    ],
  },
  {
    text: 'Azure Monitor health model',
    items: [
      { text: 'Overview', link: '/azure-local/azure-monitor/' },
      { text: 'Prerequisites', link: '/azure-local/azure-monitor/prerequisites' },
      { text: 'Operations guide', link: '/azure-local/azure-monitor/operations-guide' },
      { text: 'Entity graph', link: '/azure-local/azure-monitor/diagrams/entity-graph' },
      { text: 'SquaredUp Cloud', link: '/azure-local/azure-monitor/squaredup/' },
    ],
  },
  {
    text: 'Reference',
    collapsed: true,
    items: [
      { text: 'SCOM monitoring research', link: '/azure-local/scom/monitoring-research' },
      { text: 'Azure Monitor research', link: '/azure-local/azure-monitor/research' },
      { text: 'Research spikes', link: '/design/research-spikes' },
    ],
  },
  azureLocalDesign,
]

const designSidebar = [
  {
    text: 'Design',
    items: [
      { text: 'Overview', link: '/design/' },
      { text: 'Shared design', link: '/design/shared/' },
      { text: 'Research spikes', link: '/design/research-spikes' },
    ],
  },
  {
    text: 'Shared foundations',
    items: [
      { text: 'Scope and topology', link: '/design/scope-topology' },
      { text: 'Health model', link: '/design/health-model' },
      { text: 'Signal catalog', link: '/design/signal-catalog' },
      { text: 'Customization', link: '/design/customization' },
      { text: 'SCOM ↔ Azure Monitor mapping', link: '/design/concept-mapping' },
      { text: 'Health-state flow', link: '/design/diagrams/health-state-flow' },
    ],
  },
  hyperVDesign,
  azureLocalDesign,
  {
    text: 'Architecture decisions',
    items: [
      { text: 'Decision index', link: '/design/decisions/' },
    ],
  },
]

// Architecture decision records, grouped by theme. A flat list of 48 numeric IDs
// is unnavigable; the theme is what a reader is actually looking for.
const decisionsSidebar = [
  {
    text: 'About',
    items: [
      { text: 'Decision index', link: '/design/decisions/' },
      { text: 'ADR template', link: '/design/decisions/template' },
    ],
  },
  {
    text: 'Foundations and scope',
    items: [
      { text: '0001 — Scope and topology', link: '/design/decisions/0001-scope-and-topology' },
      { text: '0002 — Signal source', link: '/design/decisions/0002-signal-source' },
      { text: '0003 — Health rollup', link: '/design/decisions/0003-health-rollup-policy' },
      { text: '0007 — Naming', link: '/design/decisions/0007-naming-convention' },
      { text: '0021 — Platform and delivery tracks', link: '/design/decisions/0021-platform-and-delivery-track-architecture' },
      { text: '0024 — Repository and publishing identity', link: '/design/decisions/0024-repository-and-publishing-identity' },
      { text: '0030 — Platform-first source tree', link: '/design/decisions/0030-platform-first-source-tree' },
      { text: '0049 — Product-named MP identity', link: '/design/decisions/0049-product-named-management-pack-identity' },
    ],
  },
  {
    text: 'SCOM modelling',
    items: [
      { text: '0004 — SCOM discovery', link: '/design/decisions/0004-scom-discovery-strategy' },
      { text: '0005 — SCOM class hierarchy', link: '/design/decisions/0005-scom-class-hierarchy' },
      { text: '0022 — SCOM packaging boundaries', link: '/design/decisions/0022-scom-management-pack-packaging-boundaries' },
      { text: '0026 — Platform-owned SCOM DAs', link: '/design/decisions/0026-platform-owned-scom-distributed-applications' },
    ],
  },
  {
    text: 'Azure Monitor modelling',
    items: [
      { text: '0006 — Azure Monitor entities', link: '/design/decisions/0006-azmon-entity-model' },
      { text: '0010 — Cloud prerequisites', link: '/design/decisions/0010-cloud-prerequisites-contract' },
      { text: '0011 — Azure-side connectivity', link: '/design/decisions/0011-l3-azure-scope-and-connectivity' },
      { text: '0012 — Metrics routing', link: '/design/decisions/0012-azure-monitor-workspace-vs-law-metrics' },
      { text: '0013 — Azure deployment', link: '/design/decisions/0013-azmon-deployment-strategy' },
      { text: '0036 — Azure Local Health Model v1', link: '/design/decisions/0036-azure-local-azure-monitor-health-model-v1' },
    ],
  },
  {
    text: 'Health, alerts, and customization',
    items: [
      { text: '0008 — Customization', link: '/design/decisions/0008-customization-strategy' },
      { text: '0009 — Alerts and health state', link: '/design/decisions/0009-alert-vs-health-state' },
      { text: '0019 — Cost, scale, and retention', link: '/design/decisions/0019-cost-scale-retention' },
    ],
  },
  {
    text: 'Delivery and release',
    items: [
      { text: '0014 — CI/CD', link: '/design/decisions/0014-cicd-pipeline-strategy' },
      { text: '0015 — Testing', link: '/design/decisions/0015-testing-strategy' },
      { text: '0016 — Signing and secrets', link: '/design/decisions/0016-signing-and-secrets' },
      { text: '0017 — Versioning and release', link: '/design/decisions/0017-versioning-and-release' },
      { text: '0018 — Self-observability', link: '/design/decisions/0018-self-observability' },
      { text: '0020 — VitePress documentation', link: '/design/decisions/0020-vitepress-documentation-platform' },
    ],
  },
  {
    text: 'Hyper-V platform',
    items: [
      { text: '0023 — Azure Monitor gate', link: '/design/decisions/0023-hyper-v-azure-monitor-through-arc-enabled-scvmm' },
      { text: '0025 — Network management authority', link: '/design/decisions/0025-hyper-v-network-management-authority' },
      { text: '0027 — Management pack decomposition', link: '/design/decisions/0027-hyper-v-scom-management-pack-decomposition' },
      { text: '0028 — Object and discovery', link: '/design/decisions/0028-hyper-v-object-and-discovery-architecture' },
      { text: '0029 — Health, alert, and DA rollup', link: '/design/decisions/0029-hyper-v-health-alert-and-da-rollup' },
      { text: '0031 — Authoring toolchain', link: '/design/decisions/0031-hyper-v-mp-authoring-toolchain' },
      { text: '0037 — Azure Monitor health model', link: '/design/decisions/0037-hyper-v-azure-monitor-health-model-architecture' },
    ],
  },
  {
    text: 'Hyper-V v2 packaging and integrations',
    items: [
      { text: '0039 — External object ownership', link: '/design/decisions/0039-hyper-v-v2-external-object-ownership' },
      { text: '0040 — Microsoft S2D and SDN ownership', link: '/design/decisions/0040-hyper-v-v2-microsoft-s2d-and-sdn-ownership' },
      { text: '0041 — Pure Storage integration', link: '/design/decisions/0041-hyper-v-v2-pure-storage-integration' },
      { text: '0042 — File services and physical network', link: '/design/decisions/0042-hyper-v-v2-file-services-and-physical-network-ownership' },
      { text: '0043 — Package and deployment profiles', link: '/design/decisions/0043-hyper-v-v2-package-and-deployment-profile-architecture' },
      { text: '0044 — Network ATC contract', link: '/design/decisions/0044-hyper-v-v2-network-atc-monitoring-contract' },
      { text: '0045 — Windows Server SDN contract', link: '/design/decisions/0045-hyper-v-v2-windows-server-sdn-integration-contract' },
      { text: '0046 — Virtual Machine Manager contract', link: '/design/decisions/0046-hyper-v-v2-virtual-machine-manager-integration-contract' },
      { text: '0047 — Explicit PowerShell 7 execution', link: '/design/decisions/0047-hyper-v-v2-explicit-powershell-7-execution' },
      { text: '0048 — Governed sealing and release assets', link: '/design/decisions/0048-hyper-v-v2-governed-sealing-and-release-assets' },
      { text: '0050 — Prerequisite acquisition and preflight', link: '/design/decisions/0050-prerequisite-acquisition-and-preflight' },
      { text: '0051 — Dependency currency and platform validation', link: '/design/decisions/0051-dependency-currency-and-platform-validation' },
      { text: '0052 — Pure Storage monitoring strategy', link: '/design/decisions/0052-pure-storage-monitoring-strategy' },
      { text: '0053 — Management pack review and runtime correctness', link: '/design/decisions/0053-management-pack-review-and-runtime-correctness' },
      { text: '0054 — The real 1.0.0.0: version reset', link: '/design/decisions/0054-the-real-1000-version-reset' },
    ],
  },
  {
    text: 'Azure Local platform',
    items: [
      { text: '0032 — SCOM local runtime boundary', link: '/design/decisions/0032-azure-local-scom-local-runtime-boundary' },
      { text: '0033 — Management pack decomposition', link: '/design/decisions/0033-azure-local-scom-management-pack-decomposition' },
      { text: '0034 — Object discovery and DA', link: '/design/decisions/0034-azure-local-object-discovery-and-da-architecture' },
      { text: '0035 — Health, alert, and rollup', link: '/design/decisions/0035-azure-local-health-alert-and-rollup-architecture' },
    ],
  },
  {
    text: 'Integrations',
    items: [
      { text: '0038 — SCOM to ServiceNow boundary', link: '/design/decisions/0038-scom-servicenow-connector-boundary' },
    ],
  },
]

const downloadsSidebar = [
  {
    text: 'Downloads',
    items: [
      { text: 'Hyper-V Private Cloud Monitoring v2', link: '/downloads/hyper-v-private-cloud' },
      { text: 'Azure Local SCOM lab preview', link: '/downloads/scom-lab-preview' },
    ],
  },
  {
    text: 'Before you import',
    items: [
      { text: 'Hyper-V prerequisites', link: '/hyper-v/prerequisites' },
      { text: 'Azure Local SCOM prerequisites', link: '/azure-local/scom/prerequisites' },
      { text: 'Azure Local Azure Monitor prerequisites', link: '/azure-local/azure-monitor/prerequisites' },
    ],
  },
]

export default defineConfig({
  base,
  title: 'Hybrid Infrastructure Health Monitoring',
  description: 'SCOM and Azure Monitor health models for Hyper-V and Azure Local.',
  lang: 'en-US',
  cleanUrls: true,
  lastUpdated: true,

  head: [
    ['link', {
      rel: 'icon',
      type: 'image/svg+xml',
      href: `${base}assets/images/azurelocal-scom-mp-icon.svg`,
    }],
    ['meta', { name: 'theme-color', content: '#0078d4' }],
  ],

  sitemap: {
    hostname: 'https://labs.hybridsolutions.cloud/hybrid-health-monitoring/',
  },

  markdown: {
    config(markdown) {
      const defaultFence = markdown.renderer.rules.fence!

      markdown.renderer.rules.fence = (tokens, index, options, environment, self) => {
        const token = tokens[index]

        if (token.info.trim() === 'mermaid') {
          const id = `mermaid-${token.map?.[0] ?? index}`
          const graph = encodeURIComponent(token.content)
          return `<MermaidDiagram id="${id}" graph="${graph}" />`
        }

        return defaultFence(tokens, index, options, environment, self)
      }
    },
  },

  themeConfig: {
    logo: {
      src: '/assets/images/azurelocal-scom-mp-icon.svg',
      alt: 'Hybrid Infrastructure Health Monitoring',
    },
    siteTitle: '<span class="brand-line">Hybrid Infrastructure</span> <span class="brand-line">Health Monitoring</span>',

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Start here', link: '/start-here' },
      { text: 'Hyper-V', link: '/hyper-v/' },
      { text: 'Azure Local', link: '/azure-local/' },
      { text: 'Downloads', link: '/downloads/hyper-v-private-cloud' },
      {
        text: 'Reference',
        items: [
          { text: 'Design and architecture', link: '/design/' },
          { text: 'Architecture decisions', link: '/design/decisions/' },
          { text: 'SCOM → Azure Monitor', link: '/comparison/' },
          { text: 'Integrations', link: '/integrations/' },
        ],
      },
      { text: 'Project', link: '/project/about' },
    ],

    sidebar: {
      // The Hyper-V solution. One tree, shown wherever a Hyper-V page lives.
      '/hyper-v/': hyperVSidebar,

      // The Azure Local solution. Its SCOM and Azure Monitor pages live under
      // their own top-level directories for historical reasons, so the same tree
      // is served for all three prefixes — a reader never sees a different
      // sidebar depending on which door they came through.
      '/azure-local/': azureLocalSidebar,
      '/azure-local/scom/': azureLocalSidebar,
      '/azure-local/azure-monitor/': azureLocalSidebar,

      '/downloads/': downloadsSidebar,

      // Decisions get their own tree so operator navigation is not buried under
      // 48 numbered records.
      '/design/decisions/': decisionsSidebar,
      '/design/': designSidebar,

      '/comparison/': [
        {
          text: 'SCOM → Azure Monitor',
          items: [
            { text: 'Migration overview', link: '/comparison/' },
            { text: 'Concept mapping', link: '/design/concept-mapping' },
          ],
        },
        {
          text: 'Compare the tracks',
          items: [
            { text: 'Azure Local SCOM prerequisites', link: '/azure-local/scom/prerequisites' },
            { text: 'Azure Local Azure Monitor prerequisites', link: '/azure-local/azure-monitor/prerequisites' },
          ],
        },
      ],

      '/integrations/': [
        {
          text: 'Integrations',
          items: [
            { text: 'Overview', link: '/integrations/' },
            { text: 'ServiceNow', link: '/integrations/servicenow' },
            { text: 'SCOM to ServiceNow', link: '/integrations/scom-servicenow' },
          ],
        },
      ],

      '/project/': [
        {
          text: 'Project',
          items: [
            { text: 'About', link: '/project/about' },
            { text: 'Roadmap', link: '/project/roadmap' },
            { text: 'Changelog', link: '/project/changelog' },
            { text: 'License', link: '/project/license' },
          ],
        },
      ],
    },

    search: {
      provider: 'local',
    },

    outline: {
      level: [2, 3],
    },

    editLink: {
      pattern: `${repositoryUrl}/edit/main/docs/:path`,
      text: 'Edit this page on GitHub',
    },

    lastUpdated: {
      text: 'Last updated',
    },

    docFooter: {
      prev: 'Previous page',
      next: 'Next page',
    },

    socialLinks: [
      { icon: 'github', link: repositoryUrl },
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © Hybrid Solutions Cloud contributors',
    },
  },
})
