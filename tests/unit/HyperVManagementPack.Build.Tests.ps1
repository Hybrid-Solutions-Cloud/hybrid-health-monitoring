#Requires -Version 7.0
<#
.SYNOPSIS
    Tests the Hyper-V SCOM Management Pack development build.

.DESCRIPTION
    Validates product boundaries, topology identity, workflows, Distributed Application rollups,
    presentation, and customer-owned override generation.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
    Version: 1.1.0
#>

BeforeAll {
    Set-StrictMode -Version Latest
    $ErrorActionPreference = 'Stop'

    $script:RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
    $script:SourceRoot = Join-Path $script:RepositoryRoot 'src/hyper-v/scom-mp'
    $script:BuildScript = Join-Path $script:SourceRoot 'tools/Build-HyperVManagementPacks.ps1'
    $script:ContractScript = Join-Path $script:SourceRoot 'tools/Test-HyperVManagementPacks.ps1'
    $script:OverrideScript = Join-Path $script:SourceRoot 'tools/New-HyperVOverrideManagementPacks.ps1'
    $script:OverrideExampleScript = Join-Path $script:SourceRoot 'tools/Update-HyperVOverrideExamples.ps1'
    $script:V2DependencyContract = Join-Path $script:SourceRoot 'contracts/dependencies.v2.json'
}

Describe 'Hyper-V Management Pack development build' {
    It 'records the approved v2 product identity and authoritative Microsoft dependency contracts' {
        $contract = Get-Content -LiteralPath $script:V2DependencyContract -Raw | ConvertFrom-Json
        $contract.schemaVersion | Should -Be '1.0'
        $contract.product.displayName | Should -Be 'Hyper-V Private Cloud Monitoring'
        $contract.product.consoleRoot | Should -Be 'Hyper-V Private Cloud'
        $contract.product.namespace | Should -Be 'HybridSolutionsCloud.HyperVPrivateCloud'

        $cluster = $contract.capabilities | Where-Object id -eq 'FailoverCluster'
        $cluster.status | Should -Be 'Approved'
        $cluster.packageVersion | Should -Be '10.1.0.0'
        $cluster.authoritativeClasses | Should -Contain 'Microsoft.Windows.Cluster.Node'

        $csv = $contract.capabilities | Where-Object id -eq 'ClusterSharedVolume'
        $csv.status | Should -Be 'Approved'
        $csv.packageVersion | Should -Be '10.1.2.2'
        $csv.authoritativeClasses | Should -Contain 'Microsoft.Windows.Server.ClusterSharedVolumeMonitoring.ClusterSharedVolume'

        $s2d = $contract.capabilities | Where-Object id -eq 'StorageSpacesDirect'
        $s2d.status | Should -Be 'Approved'
        $s2d.packageVersion | Should -Be '1.0.47.4'
        $s2d.identityKey | Should -Be 'UniqueID'
        $s2d.managementPacks | Should -Contain 'Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect'
        $s2d.authoritativeClasses | Should -Contain 'Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem'

        $sdn = $contract.capabilities | Where-Object id -eq 'SoftwareDefinedNetworking'
        $sdn.status | Should -Be 'Approved'
        $sdn.packageVersion | Should -Be '10.0.0.2'
        $sdn.identityKey | Should -Be 'Id'
        $sdn.managementPacks | Should -Contain 'Microsoft.Windows.10.SDNMonitoring'
        $sdn.authoritativeClasses | Should -Contain 'SDNMonitoringMP.SDNMonitoring.Stamp'

        $pure = $contract.capabilities | Where-Object id -eq 'PureStorage'
        $pure.status | Should -Be 'ApprovedWithSupportBoundary'
        $pure.packageVersion | Should -Be '2.0.120.0'
        $pure.publicKeyToken | Should -Be 'a9d994eedb5e7179'
        $pure.supportedScomVersions | Should -Be @('2016', '2019', '2022')
        $pure.unsupportedScomVersions | Should -Contain '2025'
        $pure.managementPacks | Should -Contain 'PureStorageFlashArray'
        $pure.secureReference | Should -Be 'PureStorage.FlashArray.FlashArrayAdminAccount'
        $pure.authoritativeClasses | Should -Contain 'PureStorage.FlashArray.PureVolume'
    }

    It 'passes the repository contract suite' {
        $result = & $script:ContractScript
        $result | Should -Contain 'Hyper-V Management Pack contract tests passed.'
    }

    It 'generates the five intended product projects' {
        $inventoryPath = & $script:BuildScript `
            -Version '0.1.0.0' `
            -PublicKeyToken '0123456789abcdef' `
            -OutputPath $TestDrive `
            -IncludeReporting

        $inventory = Get-Content -LiteralPath $inventoryPath -Raw | ConvertFrom-Json
        $inventory.artifacts.Count | Should -Be 5
        $inventory.releaseReady | Should -BeFalse
        $inventory.artifacts.id | Should -Contain 'HybridSolutionsCloud.HyperV.Library'
        $inventory.artifacts.id | Should -Contain 'HybridSolutionsCloud.HyperV.Discovery'
        $inventory.artifacts.id | Should -Contain 'HybridSolutionsCloud.HyperV.Monitoring'
        $inventory.artifacts.id | Should -Contain 'HybridSolutionsCloud.HyperV.Presentation'
        $inventory.artifacts.id | Should -Contain 'HybridSolutionsCloud.HyperV.Reporting'
    }

    It 'rejects an invalid public key token' {
        {
            & $script:BuildScript `
                -PublicKeyToken 'not-a-token' `
                -OutputPath $TestDrive
        } | Should -Throw
    }

    It 'implements stable Hyper-V topology identities' {
        $outputPath = Join-Path $TestDrive 'topology'
        & $script:BuildScript -PublicKeyToken '0123456789abcdef' -OutputPath $outputPath | Out-Null
        [xml]$library = Get-Content (Join-Path $outputPath 'HybridSolutionsCloud.HyperV.Library.xml') -Raw

        @($library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType')).Count | Should -Be 13
        @($library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/RelationshipTypes/RelationshipType')).Count | Should -Be 20
        $vmClass = $library.SelectSingleNode("//ClassType[@ID='HybridSolutionsCloud.HyperV.VirtualMachine']")
        $vmClass.Hosted | Should -Be 'false'
        @($vmClass.Property | Where-Object Key -eq 'true').ID | Should -Be @('BoundaryId', 'VMId')
        @($library.SelectNodes("//ClassType[contains(@ID, 'Component')]") | ForEach-Object Base | Sort-Object -Unique) | Should -Be @('ServiceDesigner!Microsoft.SystemCenter.ServiceDesigner.ServiceComponentGroup')
    }

    It 'implements staged discovery and Distributed Application population' {
        $outputPath = Join-Path $TestDrive 'discovery'
        & $script:BuildScript -PublicKeyToken '0123456789abcdef' -OutputPath $outputPath | Out-Null
        [xml]$discovery = Get-Content (Join-Path $outputPath 'HybridSolutionsCloud.HyperV.Discovery.xml') -Raw

        @($discovery.SelectNodes('/ManagementPack/Monitoring/Discoveries/Discovery')).Count | Should -Be 2
        $discovery.OuterXml | Should -Match 'HybridSolutionsCloud\.HyperV\.Service'
        $discovery.OuterXml | Should -Match 'Get-ClusterSharedVolume'
        $discovery.OuterXml | Should -Match 'Get-NetIntent'
        $discovery.OuterXml | Should -Not -Match '\$(?:data|target)\b(?!/)'
    }

    It 'implements health, collection, alert, task, and rollup workflows' {
        $outputPath = Join-Path $TestDrive 'monitoring'
        & $script:BuildScript -PublicKeyToken '0123456789abcdef' -OutputPath $outputPath | Out-Null
        [xml]$monitoring = Get-Content (Join-Path $outputPath 'HybridSolutionsCloud.HyperV.Monitoring.xml') -Raw

        @($monitoring.SelectNodes('/ManagementPack/Monitoring/Monitors/UnitMonitor')).Count | Should -Be 9
        @($monitoring.SelectNodes('/ManagementPack/Monitoring/Monitors/DependencyMonitor')).Count | Should -Be 10
        $rules = @($monitoring.SelectNodes('/ManagementPack/Monitoring/Rules/Rule'))
        $rules.Count | Should -Be 16
        @($rules | Where-Object Category -eq 'PerformanceCollection').Count | Should -Be 12
        @($rules | Where-Object Category -eq 'Alert').Count | Should -Be 4
        @($monitoring.SelectNodes('/ManagementPack/Monitoring/Tasks/Task')).Count | Should -Be 1
        @($monitoring.SelectNodes('/ManagementPack/LanguagePacks/LanguagePack/KnowledgeArticles/KnowledgeArticle')).Count | Should -Be 13
        @($monitoring.SelectNodes("//*[local-name()='section']") | Where-Object { @($_.SelectNodes("./*[local-name()='title']")).Count -ne 1 }).Count | Should -Be 0
        foreach ($unitMonitor in @($monitoring.SelectNodes('/ManagementPack/Monitoring/Monitors/UnitMonitor'))) {
            $healthStates = @($unitMonitor.OperationalStates.OperationalState.HealthState)
            @($healthStates | Sort-Object -Unique).Count | Should -Be $healthStates.Count
        }
    }

    It 'implements operator views for services, inventory, alerts, events, and performance' {
        $outputPath = Join-Path $TestDrive 'presentation'
        & $script:BuildScript -PublicKeyToken '0123456789abcdef' -OutputPath $outputPath | Out-Null
        [xml]$presentation = Get-Content (Join-Path $outputPath 'HybridSolutionsCloud.HyperV.Presentation.xml') -Raw

        @($presentation.SelectNodes('/ManagementPack/Presentation/Views/View')).Count | Should -Be 10
        @($presentation.SelectNodes('/ManagementPack/Presentation/Folders/Folder')).Count | Should -Be 4
        @($presentation.SelectNodes('/ManagementPack/Presentation/FolderItems/FolderItem')).Count | Should -Be 10
    }

    It 'renders separate customer-owned Discovery and Monitoring override MPs for every starter profile' {
        foreach ($tuningProfile in @('Lab', 'Standard', 'Strict')) {
            $outputPath = Join-Path $TestDrive "overrides-$tuningProfile"
            & $script:OverrideScript -TuningProfile $tuningProfile -OrganizationId Contoso -OrganizationName Contoso -Version '2.0.0.0' -ProductVersion '0.2.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $outputPath

            [xml]$discoveryOverrides = Get-Content (Join-Path $outputPath 'Contoso.HybridSolutionsCloud.HyperV.Discovery.Overrides.xml') -Raw
            [xml]$monitoringOverrides = Get-Content (Join-Path $outputPath 'Contoso.HybridSolutionsCloud.HyperV.Monitoring.Overrides.xml') -Raw
            [string]$discoveryOverrides.ManagementPack.Manifest.Identity.Version | Should -Be '2.0.0.0'
            [string]$monitoringOverrides.ManagementPack.Manifest.Identity.Version | Should -Be '2.0.0.0'
            @($discoveryOverrides.ManagementPack.Manifest.References.Reference.Version | Select-Object -Unique) | Should -Be @('0.2.0.0')
            @($monitoringOverrides.ManagementPack.Manifest.References.Reference.Version | Select-Object -Unique) | Should -Be @('0.2.0.0')
            @($discoveryOverrides.SelectNodes('/ManagementPack/Monitoring/Overrides/*')).Count | Should -BeGreaterThan 0
            @($monitoringOverrides.SelectNodes('/ManagementPack/Monitoring/Overrides/*')).Count | Should -BeGreaterThan 0
        }
    }

    It 'renders official public Discovery and Monitoring override MPs for every tuning profile' {
        foreach ($tuningProfile in @('Lab', 'Standard', 'Strict')) {
            $outputPath = Join-Path $TestDrive "public-overrides-$tuningProfile"
            & $script:OverrideScript -TuningProfile $tuningProfile -PublicProfile -Version '1.0.0.0' -ProductVersion '0.2.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $outputPath
            [xml]$discoveryOverrides = Get-Content (Join-Path $outputPath "HybridSolutionsCloud.HyperV.Discovery.Overrides.$tuningProfile.xml") -Raw
            [xml]$monitoringOverrides = Get-Content (Join-Path $outputPath "HybridSolutionsCloud.HyperV.Monitoring.Overrides.$tuningProfile.xml") -Raw
            [string]$discoveryOverrides.ManagementPack.Manifest.Identity.ID | Should -Be "HybridSolutionsCloud.HyperV.Discovery.Overrides.$tuningProfile"
            [string]$monitoringOverrides.ManagementPack.Manifest.Identity.ID | Should -Be "HybridSolutionsCloud.HyperV.Monitoring.Overrides.$tuningProfile"
            @($discoveryOverrides.SelectNodes('/ManagementPack/Monitoring/Overrides/*')).Count | Should -BeGreaterThan 0
            @($monitoringOverrides.SelectNodes('/ManagementPack/Monitoring/Overrides/*')).Count | Should -BeGreaterThan 0
        }
    }

    It 'requires an explicit sealed product version' {
        {
            & $script:OverrideScript -TuningProfile Standard -OrganizationId Contoso -OrganizationName Contoso -PublicKeyToken '0123456789abcdef' -OutputPath (Join-Path $TestDrive 'missing-product-version')
        } | Should -Throw '*ProductVersion*'
    }

    It 'rejects an unknown override profile schema version' {
        $sourceProfile = Join-Path $script:SourceRoot 'templates/overrides/standard/profile.json'
        $invalidProfile = Join-Path $TestDrive 'unsupported-profile.json'
        $profile = Get-Content -LiteralPath $sourceProfile -Raw | ConvertFrom-Json
        $profile.schemaVersion = '9.9'
        $profile | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $invalidProfile -Encoding utf8NoBOM

        {
            & $script:OverrideScript -TuningProfile Standard -ProfilePath $invalidProfile -OrganizationId Contoso -OrganizationName Contoso -ProductVersion '0.2.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath (Join-Path $TestDrive 'unsupported-schema')
        } | Should -Throw "*Unsupported Hyper-V override profile schemaVersion '9.9'*"
    }

    It 'keeps every committed override example identical to generator output' {
        { & $script:OverrideExampleScript -Check } | Should -Not -Throw
    }

    It 'resolves every generated override target, module, parameter, context, and alias offline' {
        $buildOutput = Join-Path $TestDrive 'semantic-product'
        & $script:BuildScript -Version '0.2.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $buildOutput | Out-Null

        [xml]$library = Get-Content -LiteralPath (Join-Path $buildOutput 'HybridSolutionsCloud.HyperV.Library.xml') -Raw
        [xml]$discovery = Get-Content -LiteralPath (Join-Path $buildOutput 'HybridSolutionsCloud.HyperV.Discovery.xml') -Raw
        [xml]$monitoring = Get-Content -LiteralPath (Join-Path $buildOutput 'HybridSolutionsCloud.HyperV.Monitoring.xml') -Raw
        $classIds = @($library.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType') | ForEach-Object { [string]$_.ID })

        foreach ($tuningProfile in @('Lab', 'Standard', 'Strict')) {
            $overrideOutput = Join-Path $TestDrive "semantic-overrides-$tuningProfile"
            & $script:OverrideScript -TuningProfile $tuningProfile -OrganizationId Contoso -OrganizationName Contoso -Version '1.0.0.0' -ProductVersion '0.2.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $overrideOutput

            foreach ($kind in @('Discovery', 'Monitoring')) {
                $overridePath = Join-Path $overrideOutput "Contoso.HybridSolutionsCloud.HyperV.$kind.Overrides.xml"
                [xml]$overrideDocument = Get-Content -LiteralPath $overridePath -Raw
                $overrides = @($overrideDocument.SelectNodes('/ManagementPack/Monitoring/Overrides/*'))
                $usedAliases = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)

                foreach ($override in $overrides) {
                    $contextParts = ([string]$override.Context).Split('!', 2)
                    $contextParts.Count | Should -Be 2
                    [void]$usedAliases.Add($contextParts[0])
                    $classIds | Should -Contain $contextParts[1]

                    if ($override.LocalName -eq 'DiscoveryConfigurationOverride') {
                        $workflowParts = ([string]$override.Discovery).Split('!', 2)
                        [void]$usedAliases.Add($workflowParts[0])
                        $workflow = $discovery.SelectSingleNode("/ManagementPack/Monitoring/Discoveries/Discovery[@ID='$($workflowParts[1])']")
                        $workflow | Should -Not -BeNullOrEmpty
                        $module = $workflow.SelectSingleNode("DataSource[@ID='$([string]$override.Module)']")
                        $module | Should -Not -BeNullOrEmpty
                        $module.SelectSingleNode([string]$override.Parameter) | Should -Not -BeNullOrEmpty
                    }
                    else {
                        $monitorParts = ([string]$override.Monitor).Split('!', 2)
                        [void]$usedAliases.Add($monitorParts[0])
                        $unitMonitor = $monitoring.SelectSingleNode("/ManagementPack/Monitoring/Monitors/UnitMonitor[@ID='$($monitorParts[1])']")
                        $unitMonitor | Should -Not -BeNullOrEmpty
                        $unitMonitor.SelectSingleNode("Configuration/$([string]$override.Parameter)") | Should -Not -BeNullOrEmpty
                    }
                }

                foreach ($reference in @($overrideDocument.ManagementPack.Manifest.References.Reference)) {
                    $usedAliases.Contains([string]$reference.Alias) | Should -BeTrue
                }
            }
        }
    }
}
