# Project context

> **"Private Cloud Powered by Hyper-V: A 360° View"**  
> The premier operational health monitoring suite for sovereign, enterprise Hyper-V private clouds, providing 100% end-to-end visibility across physical compute, out-of-band management, storage fabrics, networking, perimeter firewalls, and management domain services.

This repository defines Hybrid infrastructure health monitoring for two platform tracks:
1. **Hyper-V Private Cloud**: A sovereign, 100% on-premises enterprise SCOM solution (zero cloud or Azure dependencies) delivering a complete 360° Distributed Application service model across compute, storage, networking, edge security, management infrastructure, and workloads.
2. **Azure Local**: Independent SCOM Management Pack and Azure Monitor Health Model delivery surfaces.

The documentation is a VitePress site rooted at `docs/` and published beneath the
`/hybrid-health-monitoring/` base path at `https://labs.hybridsolutions.cloud/hybrid-health-monitoring/`.
The site is deployed by GitHub Pages and the central Azure DevOps VitePress template.

Internal delivery tracking mirrors the two platforms and four solution boundaries. Work-item
identifiers and direct board links must never be published in the public site or repository text.

Hyper-V SCOM phase one covers support and topology, exhaustive raw inventories, prior Microsoft MP
research, SCOM workflow mapping, threshold engineering, lab/fault validation, final catalog
curation, and comprehensive MP/DA architecture validation. ADRs 0027–0029 and 0031 are accepted;
the authored development baseline has passed OM2022 VSAE dependency verification and transient
test sealing and now advances to lab and governed release certification.

The proposed Hyper-V packaging contract includes sealed Library, Discovery, Monitoring,
Presentation, and optional Reporting artifacts. Customers own separate unsealed Discovery and
Monitoring override MPs. Optional Lab, Standard, and Strict templates are public starter examples,
not active product policy, and the Default Management Pack is never a customization target.

The design information architecture is platform first and delivery surface second. It has explicit
Azure Local/SCOM, Azure Local/Azure Monitor, Hyper-V/SCOM, and constrained Hyper-V/Azure Monitor
lanes. Shared design is deliberately small; accepted Azure Local ADRs do not silently govern
Hyper-V. ADR 0025 establishes Network ATC as the preferred eligible Hyper-V cluster baseline while
requiring separate handling for SCVMM/SDN and non-ATC network-management paths.

ADRs 0022 and 0026 establish the SCOM product boundary: Azure Local and Hyper-V share research and
non-runtime engineering practices only. They own independent MP namespaces, packages, classes,
monitoring, overrides, Distributed Applications, releases, and support lifecycles. Azure Local uses
the deployment DA defined by ADR 0005/0018. Hyper-V requires a separate DA instance per supported
failover cluster or standalone host, refined by topology and DA validation before authoring.

The source tree enforces the same hierarchy through accepted ADR 0030. Azure Local and Hyper-V are
top-level source owners, each with `scom-mp` and `azure-monitor` solution roots. ADRs 0023 and 0037
now authorize the constrained Hyper-V Azure Monitor development baseline without changing the
independent product boundary.

ServiceNow is an optional integration area. ServiceNow supplies the existing SCOM Events connector;
the repository's configuration contract now has
an accepted ADR, separate Azure Local and Hyper-V allowlists, a normalized AlertId-based mapping,
secret-free public profiles, and an offline validator. Live MID Server and ServiceNow validation
remains a release gate; the Metrics connector stays disabled unless separately justified. The
Azure Monitor path remains later work and uses Secure Webhook action groups with common alert
schema, with Logic Apps only when enrichment or orchestration is required. Dual-source deployments
must prove authoritative-source or correlation behavior before release.
