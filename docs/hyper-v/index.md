---
title: Hyper-V
description: Hyper-V health monitoring through SCOM and a constrained Azure Monitor track through Arc-enabled SCVMM and Arc-enabled hosts.
---

# Hyper-V Private Cloud Monitoring

Hyper-V Private Cloud Monitoring is the flagship enterprise on-premises monitoring solution in this project. Delivered as a comprehensive, modular suite of System Center Operations Manager (SCOM) Management Packs, it is engineered specifically for private cloud infrastructure built on Windows Server Failover Clustering, Hyper-V, and System Center Virtual Machine Manager (SCVMM).

| Delivery Surface | Commitment | Status | Architecture |
|---|---|---|---|
| **SCOM Management Pack Suite** | Primary Platform Track | **Production Sealed (1.0.7.0)** | 100% on-premises SCOM; zero cloud or Azure dependencies |

::: info Pure SCOM architecture
Hyper-V Private Cloud Monitoring runs entirely through System Center Operations Manager. All health evaluation, property bag probing, topology discovery, diagnostic tasks, and resilient rollups execute on-premises using PowerShell 7+. There is no Azure Monitor or Azure Arc requirement.
:::

**[Download Hyper-V Private Cloud Monitoring](../downloads/hyper-v-private-cloud.md)** | **[Prerequisites Guide](prerequisites.md)** | **[Administration Guide](management-pack-guide.md)** | **[Operations Guide](operations-guide.md)**

## Complete architectural separation from Azure Local

Hyper-V and Azure Local are treated as completely distinct platforms throughout this repository:

1. **Independent Product Lines:** Azure Local (formerly Azure Stack HCI) has a prescribed, cloud-connected lifecycle, opinionated storage, and native Azure Monitor integration. Hyper-V Private Cloud is designed for sovereign, on-premises enterprise virtualization, standalone nodes, general-purpose failover clusters, SAN/Pure/SMB/S2D storage, and SCVMM-managed fabrics.
2. **Zero Runtime Coupling:** The Hyper-V Management Pack suite contains no references to Azure Local management packs, ARM resource IDs, or Azure monitoring extensions. You can deploy Hyper-V monitoring in environments completely air-gapped from Azure.
3. **Dedicated Management Domain:** Enterprise Hyper-V private clouds operate with their own dedicated Active Directory, DNS, and bare-metal deployment infrastructure (PXE/WDS). Our Distributed Application directly monitors and models these critical management services.

See the [Hyper-V SCOM architecture map](../design/hyper-v/scom-mp.md) and the [Distributed Application design](../design/hyper-v/distributed-application.md).

## Hyper-V topology research

The research baseline defines the candidate supported matrix for:

- standalone Hyper-V hosts;
- Hyper-V failover clusters;
- hosts and VMs managed by SCVMM;
- Network ATC-managed, manually managed, and SCVMM/SDN-managed host networking;
- virtual switches, adapters, storage, replication, and VM relationships; and
- supported Windows Server, SCOM, and SCVMM versions.

See [Research spikes](../design/research-spikes.md) and the
[Hyper-V SCOM track](scom-mp.md) for the delivery gate.

Phase-one execution is documented in the [Hyper-V SCOM monitoring research](monitoring-research.md)
plan. Its [catalog policy](monitoring-catalog.md) separates the exhaustive raw inventory from the
smaller default monitoring profile.
