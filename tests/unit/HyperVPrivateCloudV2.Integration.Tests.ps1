#Requires -Version 7.0

Describe 'Hyper-V Private Cloud v2 management-group certification collector' {
    BeforeAll {
        $script:RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
        $script:CollectorPath = Join-Path $script:RepositoryRoot 'tests/integration/Get-HyperVPrivateCloudCertificationSnapshot.ps1'
        $script:ExpectationPath = Join-Path $script:RepositoryRoot 'tests/integration/expectations/core-standalone.example.json'
        $script:CollectorText = Get-Content -LiteralPath $script:CollectorPath -Raw
        $script:Expectation = Get-Content -LiteralPath $script:ExpectationPath -Raw | ConvertFrom-Json
    }

    It 'is a valid PowerShell 7 script with the governed runtime contract' {
        $tokens = $null
        $errors = $null
        [void][Management.Automation.Language.Parser]::ParseFile($script:CollectorPath, [ref]$tokens, [ref]$errors)
        @($errors).Count | Should -Be 0
        $script:CollectorText | Should -Match '#Requires -Version 7\.0'
        $script:CollectorText | Should -Match 'Set-StrictMode -Version Latest'
        $script:CollectorText | Should -Match "\`$ErrorActionPreference = 'Stop'"
    }

    It 'uses supported Operations Manager inventory and task-result surfaces' {
        foreach ($command in @(
                'New-SCOMManagementGroupConnection', 'Get-SCOMManagementPack', 'Get-SCOMClass',
                'Get-SCOMClassInstance', 'Get-SCOMMonitor', 'Get-SCOMRule', 'Get-SCOMTask',
                'Get-SCOMTaskResult', 'Get-SCOMAlert'
            )) {
            $script:CollectorText | Should -Match ([regex]::Escape($command))
        }
    }

    It 'never turns a collected draft into an approved release receipt' {
        $script:CollectorText | Should -Match 'approved = \$false'
        $script:CollectorText | Should -Not -Match 'approved = \$true'
        foreach ($gate in @(
                'PowerShellRuntime', 'CleanImport', 'TopologyDiscovery', 'HealthAndAlerts',
                'DistributedApplicationAndViews', 'CapabilityIntegrations', 'Scale',
                'UpgradeAndOverrides', 'Removal', 'DefaultManagementPackProtection'
            )) {
            $script:CollectorText | Should -Match ([regex]::Escape($gate))
        }
    }

    It 'defines a realistic core standalone expectation' {
        $script:Expectation.schemaVersion | Should -Be '1.0'
        @($script:Expectation.productManagementPacks).Count | Should -Be 4
        @($script:Expectation.overrideManagementPacks).Count | Should -Be 2
        @($script:Expectation.classes).Count | Should -BeGreaterOrEqual 6
        @($script:Expectation.requiredWorkflows.views).Count | Should -BeGreaterOrEqual 3
    }

    It 'requires an actual recent HealthService task result for the runtime gate' {
        $script:CollectorText | Should -Match 'Get-SCOMTaskResult'
        $script:CollectorText | Should -Match 'TimeFinished'
        $script:CollectorText | Should -Match 'PSEdition'
        $script:CollectorText | Should -Match 'PowerShellVersion'
    }
}
