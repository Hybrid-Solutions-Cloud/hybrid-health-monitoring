# Hyper-V SCOM Management Pack source

This directory owns every runtime and test artifact for the independent Hyper-V SCOM product and
its platform-owned Distributed Application. The `v2/` tree is the current Hyper-V Private Cloud
Monitoring source and produces four core MPs, nine capability MPs, and the public override system.
The unversioned tree is the earlier five-project baseline and is retained for source history.

```text
scom-mp/
├── fragments/
│   ├── library/
│   ├── discovery/
│   ├── monitoring/
│   ├── presentation/
│   └── reporting/
├── templates/
│   └── overrides/     # Lab, Standard, and Strict profiles and structural examples
├── scripts/
├── tests/
└── squaredup/         # Optional post-GA Dashboard Server content
```

The folders implement ADR 0027. The functional development build contains 13 classes, 20
relationships, staged role/topology discovery, a platform-owned Distributed Application, nine
health monitors, ten dependency rollups, twelve performance rules, four event-alert rules, one
read-only diagnostic task, and ten operator views. This earlier five-project output passes
VSAE/SDK verification and ordered transient test sealing but is superseded by the permanently
sealed v2 repository download.

The release keeps product-authored sealed artifacts separate from customer-owned unsealed
overrides. Discovery and Monitoring receive independent generated override MPs for each optional
tuning profile. The generated files are intentionally unsealed and become customer-owned.

No Azure Local or Microsoft Hyper-V 2019 Management Pack runtime element or reference belongs here.

## Development build

Run the contract tests with PowerShell 7:

```powershell
./tools/Test-HyperVManagementPacks.ps1
```

Generate development XML with a non-secret public key token from the approved test-signing
identity:

```powershell
./tools/Build-HyperVManagementPacks.ps1 `
    -Version '1.0.0.0' `
    -ProductVersion '0.1.0.0' `
    -PublicKeyToken '<16-hex-character-public-token>'
```

The build inventory always marks this output as development-only. The build script itself does not
claim verification, sealing, signing, or lab import; those are separate evidence-producing steps
defined by accepted ADR 0031.

## Generate customer-owned overrides

Generate one profile into separate Discovery and Monitoring override MPs:

```powershell
./tools/New-HyperVOverrideManagementPacks.ps1 `
    -TuningProfile Standard `
    -OrganizationId Contoso `
    -OrganizationName 'Contoso' `
    -Version '0.1.0.0' `
    -PublicKeyToken '<16-hex-character-public-token>' `
    -OutputPath './out/contoso-overrides'
```

Review and test the generated XML before import. Never import more than one starter profile and
never store active overrides in the Default Management Pack.

Generate an official public profile for release packaging with `-PublicProfile` instead of the
organization parameters. Public Lab, Standard, and Strict packs use first-party product IDs and
must remain mutually exclusive.

## Microsoft SDK verification

Install System Center Visual Studio Authoring Extensions (VSAE) for Visual Studio 2022 and make the
official sealed dependency MPs from the target SCOM release available locally. Run the verifier
from PowerShell 7; it delegates MP verification to Visual Studio 2022's full-framework MSBuild
host so the sealed SCOM dependencies are loaded by a compatible runtime:

```powershell
./tools/Test-HyperVManagementPacksWithSdk.ps1 `
    -InputPath './out/development' `
    -DependencyPath 'D:/scom/reference-mps'
```

The command fails on missing dependencies as well as schema and verification errors. It currently
passes for all five projects against the installed SCOM 2022 dependency set. SDK success and
transient test sealing do not replace clean lab import, fault/recovery tests, upgrade/removal tests,
or release signing. Verify and seal the Library first, then use the sealed Library while verifying
Discovery and the remaining product MPs in dependency order.
