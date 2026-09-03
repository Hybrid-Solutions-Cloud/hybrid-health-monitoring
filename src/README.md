# Product source

Product source is organized **platform first, solution second**. Each solution owns its runtime
artifacts, tests, optional visualizations, versioning, and release lifecycle.

```text
src/
├── azure-local/
│   ├── scom-mp/
│   └── azure-monitor/
└── hyper-v/
    └── scom-mp/
```

## Runtime boundaries

| Platform | Solution | Commitment | Source root |
|---|---|---|---|
| Azure Local | SCOM Management Pack | Committed | `azure-local/scom-mp/` |
| Azure Local | Azure Monitor Health Models | Committed | `azure-local/azure-monitor/` |
| Hyper-V | SCOM Management Pack Suite | Production release (1.0.7.0) | `hyper-v/scom-mp/` |

Azure Local and Hyper-V SCOM are independent products. They do not share sealed libraries,
classes, namespaces, packages, Distributed Applications, signing identities, or runtime references.
Reusable authoring and validation tooling belongs outside these runtime roots under `tools/`.

SquaredUp content is an optional presentation artifact inside the solution that owns its classes
or telemetry. It is not a third platform or a third monitoring solution.
