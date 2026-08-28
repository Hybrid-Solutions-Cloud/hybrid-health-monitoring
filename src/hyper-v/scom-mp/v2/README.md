# Hyper-V Private Cloud Monitoring v2 source

This is the clean v2 authoring root. It is intentionally separate from the published `0.1`
preview source one directory above it. V2 uses the immutable element namespace
`HybridSolutionsCloud.HyperVPrivateCloud` and the console-facing product name **Hyper-V Private
Cloud Monitoring**.

The build manifest records an explicit implementation status for every required artifact. Build
automation refuses to treat a planned artifact as authored, preventing an incomplete source tree
from being packaged as the complete product.

Build the currently authored artifacts with PowerShell 7:

```powershell
./tools/Build-HyperVPrivateCloudManagementPacks.ps1 `
  -Version 2.0.0.0 `
  -PublicKeyToken 0123456789abcdef
```

Development XML is written to `out/development/`. Release sealing remains a separate governed
step and requires the repository signing identity.
