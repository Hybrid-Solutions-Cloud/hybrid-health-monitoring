#Requires -Version 7.0

Describe 'Hyper-V Private Cloud v2 release tooling' {
    BeforeAll {
        $script:RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
        $script:V2Root = Join-Path $script:RepositoryRoot 'src/hyper-v/scom-mp/v2'
        $script:PackageTool = Join-Path $script:V2Root 'tools/New-HyperVPrivateCloudReleasePackage.ps1'
        $script:ValidationTool = Join-Path $script:V2Root 'tools/Test-HyperVPrivateCloudReleasePackage.ps1'
        $script:SealProject = Join-Path $script:RepositoryRoot 'tools/scom/SealManagementPack.proj'
        $script:EvidenceExample = Join-Path $script:V2Root 'release/release-evidence.example.json'
        $script:ReleaseWorkflow = Join-Path $script:RepositoryRoot '.github/workflows/release-hyper-v-v2.yml'
        $script:PackageText = Get-Content -LiteralPath $script:PackageTool -Raw
        $script:ValidationText = Get-Content -LiteralPath $script:ValidationTool -Raw
        $script:WorkflowText = Get-Content -LiteralPath $script:ReleaseWorkflow -Raw
        [xml]$script:SealXml = Get-Content -LiteralPath $script:SealProject -Raw
    }

    It 'ships parseable PowerShell 7 package and validation tools' {
        foreach ($path in @($script:PackageTool, $script:ValidationTool)) {
            Test-Path -LiteralPath $path -PathType Leaf | Should -BeTrue
            (Get-Content -LiteralPath $path -First 1) | Should -Be '#Requires -Version 7.0'
            $tokens = $null
            $errors = $null
            [System.Management.Automation.Language.Parser]::ParseFile($path, [ref]$tokens, [ref]$errors) | Out-Null
            @($errors).Count | Should -Be 0
        }
    }

    It 'seals only through the Microsoft VSAE SealMp task with full signing' {
        $namespace = [System.Xml.XmlNamespaceManager]::new($script:SealXml.NameTable)
        $namespace.AddNamespace('m', 'http://schemas.microsoft.com/developer/msbuild/2003')
        $script:SealXml.SelectSingleNode('/m:Project/m:UsingTask[@TaskName="SealMp"]', $namespace) | Should -Not -BeNullOrEmpty
        $sealTask = $script:SealXml.SelectSingleNode('/m:Project/m:Target[@Name="Seal"]/m:SealMp', $namespace)
        $sealTask | Should -Not -BeNullOrEmpty
        [string]$sealTask.DelaySign | Should -Be 'false'
        $script:PackageText | Should -Match 'tools/scom/SealManagementPack\.proj'
        $script:PackageText | Should -Not -Match '&\s+\$FastSealDirectory'
    }

    It 'preserves the Management Pack identity as the temporary MPB verification filename' {
        $script:PackageText | Should -Match 'mpb-remapped/\$\(\$artifact\.id\)'
        $script:PackageText | Should -Match '"\$\(\$artifact\.id\)\.xml"'
        $script:PackageText | Should -Not -Match '\$\(\$artifact\.id\)\.mpb-remapped\.xml'
    }

    It 'prevents test output or incomplete evidence from becoming a release' {
        $script:PackageText | Should -Match "Release mode cannot skip Microsoft VSAE verification"
        $script:PackageText | Should -Match "Release mode requires -ApprovedReleaseSigningIdentity"
        $script:PackageText | Should -Match "Release mode requires -ReleaseEvidencePath"
        $script:PackageText | Should -Match "approved=true"
        $script:PackageText | Should -Match "Release mode requires a clean Git worktree"
        $script:PackageText | Should -Match "Release evidence sourceCommit"
        $script:PackageText | Should -Match "SigningKeyPath must be outside the repository"
        $script:ValidationText | Should -Match 'RequireReleaseEligible'
        $script:ValidationText | Should -Match "Publication requires a Release-mode package"
    }

    It 'defines every mandatory representative release-evidence gate' {
        $evidence = Get-Content -LiteralPath $script:EvidenceExample -Raw | ConvertFrom-Json
        $evidence.schemaVersion | Should -Be '1.0'
        $evidence.approved | Should -BeFalse
        @($evidence.gates).Count | Should -Be 10
        foreach ($gateId in @(
                'PowerShellRuntime', 'CleanImport', 'TopologyDiscovery', 'HealthAndAlerts',
                'DistributedApplicationAndViews', 'CapabilityIntegrations', 'Scale',
                'UpgradeAndOverrides', 'Removal', 'DefaultManagementPackProtection'
            )) {
            @($evidence.gates.id) | Should -Contain $gateId
            $script:PackageText | Should -Match ([regex]::Escape("'$gateId'"))
        }
    }

    It 'defines the complete public asset contract' {
        foreach ($name in @(
                'Hyper-V-Private-Cloud-Monitoring-Complete.zip',
                'Hyper-V-Private-Cloud-Monitoring-Core.zip',
                'Hyper-V-Private-Cloud-Monitoring-Overrides.zip',
                'release-manifest.json',
                'release-assets.json',
                'SHA256SUMS.txt'
            )) {
            $script:PackageText | Should -Match ([regex]::Escape($name))
        }
        $script:PackageText | Should -Match 'foreach \(\$deploymentProfile in \$contract\.profiles\)'
        $script:PackageText | Should -Match 'foreach \(\$tier in \$contract\.overrideTiers\)'
        $script:ValidationText | Should -Match "Complete ZIP has the wrong override count"
    }

    It 'excludes signing material and validates every published checksum' {
        $script:PackageText | Should -Match "\.Extension -in @\('\.snk', '\.pfx', '\.p12'\)"
        $script:ValidationText | Should -Match "\.snk', '\.pfx', '\.p12', '\.key"
        $script:ValidationText | Should -Match 'SHA256SUMS does not cover the exact release asset set'
        $script:ValidationText | Should -Match 'ZIP contains an unsafe path'
    }

    It 'records and validates publisher dependency provenance without exposing local paths' {
        $script:PackageText | Should -Match 'dependencyEvidence'
        $script:PackageText | Should -Match 'sourceFile = \[System\.IO\.Path\]::GetFileName'
        $script:PackageText | Should -Match 'sha256 = Get-HcsFileHashValue'
        $script:ValidationText | Should -Match 'No dependency evidence resolves prerequisite'
        $script:ValidationText | Should -Match 'Dependency evidence exposes a path'
        $script:ValidationText | Should -Match 'MPB dependency count differs from dependency evidence'
        $script:PackageText | Should -Match 'Get-AuthenticodeSignature'
        $script:PackageText | Should -Match "Strong-name verification failed for publisher dependency"
        $script:ValidationText | Should -Match 'MPB Authenticode status is unsupported'
    }

    It 'publishes only through the protected Windows release workflow' {
        Test-Path -LiteralPath $script:ReleaseWorkflow -PathType Leaf | Should -BeTrue
        $script:WorkflowText | Should -Match "github\.ref == 'refs/heads/main'"
        $script:WorkflowText | Should -Match 'runs-on: \[self-hosted, Windows, X64, scom-mp-release\]'
        $script:WorkflowText | Should -Match 'environment: hyper-v-scom-production-release'
        $script:WorkflowText | Should -Match 'uses: azure/login@v3'
        $script:WorkflowText | Should -Match 'az keyvault secret show'
        $script:WorkflowText | Should -Match '\[IO\.Path\]::GetRelativePath'
        $script:WorkflowText | Should -Match '-BuildMode Release'
        $script:WorkflowText | Should -Match '-RequireReleaseEligible'
        $script:WorkflowText | Should -Match "'release', 'create'"
        $script:WorkflowText | Should -Match 'releases/latest/download'
        $script:WorkflowText | Should -Match 'if: always\(\)'
    }
}
