#Requires -Version 7.0

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Describe 'Hyper-V Private Cloud Monitoring override generation' {
    BeforeAll {
        $script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
        $script:V2Root = Join-Path $script:RepoRoot 'src/hyper-v/scom-mp'
        $script:BuildTool = Join-Path $script:V2Root 'tools/Build-HyperVPrivateCloudManagementPacks.ps1'
        $script:Generator = Join-Path $script:V2Root 'tools/New-HyperVPrivateCloudOverrideManagementPacks.ps1'
        $script:ExampleUpdater = Join-Path $script:V2Root 'tools/Update-HyperVPrivateCloudOverrideExamples.ps1'
        $script:CatalogPath = Join-Path $script:V2Root 'templates/overrides/tuning-catalog.json'
        $script:ContractPath = Join-Path $script:V2Root 'contracts/packages.json'
        $script:CommittedExamples = Join-Path $script:V2Root 'templates/overrides/public'
        $script:Catalog = Get-Content -LiteralPath $script:CatalogPath -Raw | ConvertFrom-Json
        $script:Contract = Get-Content -LiteralPath $script:ContractPath -Raw | ConvertFrom-Json
        $script:Scratch = Join-Path ([System.IO.Path]::GetTempPath()) "hcs-hyperv-v2-overrides-$([guid]::NewGuid().ToString('N'))"
        $script:ProductOutput = Join-Path $script:Scratch 'product'
        $script:RegeneratedExamples = Join-Path $script:Scratch 'examples'
        $script:VersionOutput = Join-Path $script:Scratch 'versions'
        [System.IO.Directory]::CreateDirectory($script:Scratch) | Out-Null
        & $script:BuildTool -Version '2.0.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $script:ProductOutput | Out-Null
        & $script:ExampleUpdater -OutputRoot $script:RegeneratedExamples | Out-Null

        $script:ProductMps = @{}
        foreach ($file in Get-ChildItem -LiteralPath $script:ProductOutput -Filter '*.xml' -File) {
            [xml]$managementPack = Get-Content -LiteralPath $file.FullName -Raw
            $script:ProductMps[[string]$managementPack.ManagementPack.Manifest.Identity.ID] = $managementPack
        }
    }

    AfterAll {
        if (Test-Path -LiteralPath $script:Scratch) {
            Remove-Item -LiteralPath $script:Scratch -Recurse -Force
        }
    }

    It 'uses an explicit recognized schema for every workflow, context, and module' {
        $script:Catalog.schemaVersion | Should -Be '2.0'
        foreach ($targetSet in $script:Catalog.targetSets) {
            [string]$targetSet.id | Should -Not -BeNullOrEmpty
            [string]$targetSet.kind | Should -BeIn @('Discovery', 'Monitor', 'Rule')
            foreach ($target in $targetSet.targets) {
                [string]$target.workflowRef | Should -Not -BeNullOrEmpty
                [string]$target.workflowId | Should -Not -BeNullOrEmpty
                [string]$target.contextRef | Should -Not -BeNullOrEmpty
                [string]$target.contextClassId | Should -Not -BeNullOrEmpty
                if ([string]$targetSet.kind -in @('Discovery', 'Rule')) {
                    [string]$target.module | Should -Not -BeNullOrEmpty
                }
            }
        }
        (Get-Content -LiteralPath $script:Generator -Raw) | Should -Not -Match 'Host\.\$|MonitorId\s*=|contextClassId\s*='
    }

    It 'commits the solution override examples as byte-identical deterministic generator output' {
        $expected = @(Get-ChildItem -LiteralPath $script:CommittedExamples -Filter '*.xml.example' -File -Recurse)
        $actual = @(Get-ChildItem -LiteralPath $script:RegeneratedExamples -Filter '*.xml.example' -File -Recurse)
        $expected.Count | Should -Be 2
        $actual.Count | Should -Be 2
        $expectedRelative = @($expected | ForEach-Object { [System.IO.Path]::GetRelativePath($script:CommittedExamples, $_.FullName) } | Sort-Object)
        $actualRelative = @($actual | ForEach-Object { [System.IO.Path]::GetRelativePath($script:RegeneratedExamples, $_.FullName) } | Sort-Object)
        $actualRelative | Should -Be $expectedRelative
        foreach ($relativePath in $expectedRelative) {
            # Newline-insensitive: checkout and platform newline conventions vary, content must not.
            $expectedText = (Get-Content -LiteralPath (Join-Path $script:CommittedExamples $relativePath) -Raw) -replace "`r`n", "`n"
            $actualText = (Get-Content -LiteralPath (Join-Path $script:RegeneratedExamples $relativePath) -Raw) -replace "`r`n", "`n"
            $actualText | Should -Be $expectedText -Because "'$relativePath' must be generated, never hand-maintained"
        }
    }

    It 'keeps customer override and sealed product versions independent' {
        & $script:Generator -DeploymentProfile CompletePrivateCloud -TuningTier Strict `
            -OrganizationId Contoso -OrganizationName 'Contoso' -Version '2.0.0.0' `
            -ProductVersion '0.2.0.0' -PublicKeyToken '0123456789abcdef' `
            -OutputPath $script:VersionOutput | Out-Null
        foreach ($file in Get-ChildItem -LiteralPath $script:VersionOutput -Filter '*.xml' -File) {
            [xml]$managementPack = Get-Content -LiteralPath $file.FullName -Raw
            $managementPack.ManagementPack.Manifest.Identity.Version | Should -Be '2.0.0.0'
            foreach ($reference in $managementPack.SelectNodes("/ManagementPack/Manifest/References/Reference[starts-with(ID,'HyperVPrivateCloud')]") ) {
                $reference.Version | Should -Be '0.2.0.0'
                $reference.PublicKeyToken | Should -Be '0123456789abcdef'
            }
        }
    }

    It 'emits all capability references in the solution override pack' {
        $aliasByCapability = @{
            Cluster = 'HCSV2Cluster'; Storage = 'HCSV2Storage'
            S2D = 'HCSV2S2D'; FileServices = 'HCSV2FileServices'; NetworkATC = 'HCSV2NetworkATC'
            PhysicalNetwork = 'HCSV2PhysicalNetwork'; SDN = 'HCSV2SDN'; VMM = 'HCSV2VMM'
        }
        $monitoringPack = [xml](Get-Content -LiteralPath (Join-Path $script:RegeneratedExamples 'HyperVPrivateCloud.Monitoring.Overrides.xml.example') -Raw)
        $aliases = @($monitoringPack.SelectNodes('/ManagementPack/Manifest/References/Reference') | ForEach-Object { [string]$_.Alias })
        foreach ($entry in $aliasByCapability.GetEnumerator()) {
            $aliases | Should -Contain $entry.Value
        }
    }

    It 'resolves every generated workflow, context, module, property, and parameter' {
        foreach ($file in Get-ChildItem -LiteralPath $script:RegeneratedExamples -Filter '*.xml.example' -File -Recurse) {
            [xml]$overridePack = Get-Content -LiteralPath $file.FullName -Raw
            $references = @{}
            foreach ($reference in $overridePack.SelectNodes('/ManagementPack/Manifest/References/Reference')) {
                $references[[string]$reference.Alias] = [string]$reference.ID
                $overridePack.OuterXml | Should -Match ([regex]::Escape("$($reference.Alias)!")) -Because "every declared alias in '$($file.Name)' must be used"
            }
            $localClasses = @($overridePack.SelectNodes('//ClassType') | ForEach-Object { [string]$_.ID })

            foreach ($override in $overridePack.SelectNodes('/ManagementPack/Monitoring/Overrides/*')) {
                $workflowAttribute = @('Discovery', 'Monitor', 'Rule') | Where-Object { $override.HasAttribute($_) } | Select-Object -First 1
                $workflowReference = [string]$override.GetAttribute($workflowAttribute)
                $workflowParts = $workflowReference -split '!', 2
                $references.ContainsKey($workflowParts[0]) | Should -BeTrue
                $productId = $references[$workflowParts[0]]
                $script:ProductMps.ContainsKey($productId) | Should -BeTrue -Because "'$workflowReference' must resolve to a built v2 product MP"
                $productMp = $script:ProductMps[$productId]
                $workflowNode = switch ($workflowAttribute) {
                    'Discovery' { $productMp.SelectSingleNode("//Discovery[@ID='$($workflowParts[1])']") }
                    'Monitor' { $productMp.SelectSingleNode("//UnitMonitor[@ID='$($workflowParts[1])']") }
                    'Rule' { $productMp.SelectSingleNode("//Rule[@ID='$($workflowParts[1])']") }
                }
                $workflowNode | Should -Not -BeNullOrEmpty

                $workflowTargetClass = ([string]$workflowNode.Target -split '!', 2)[-1]
                $context = [string]$override.Context
                if ($context -like '*!*') {
                    $contextParts = $context -split '!', 2
                    $references.ContainsKey($contextParts[0]) | Should -BeTrue
                    $contextParts[1] | Should -Be $workflowTargetClass
                }
                else {
                    $localClasses | Should -Contain $context
                    $group = $overridePack.SelectSingleNode("//ClassType[@ID='$context']")
                    $group.Base | Should -Be 'InstanceGroup!Microsoft.SystemCenter.InstanceGroup'
                    $member = $overridePack.SelectSingleNode("//Discovery[@Target='$context']//MembershipRule/MonitoringClass").InnerText
                    (($member -replace '^\$MPElement\[Name="', '') -replace '"\]\$$', '' -split '!', 2)[-1] | Should -Be $workflowTargetClass
                }

                if ($override.LocalName -like '*ConfigurationOverride') {
                    $parameter = [string]$override.Parameter
                    if ($workflowAttribute -eq 'Monitor') {
                        @($workflowNode.Configuration.ChildNodes | Where-Object NodeType -eq Element | ForEach-Object LocalName) | Should -Contain $parameter
                    }
                    else {
                        $moduleId = [string]$override.Module
                        $module = if ($workflowAttribute -eq 'Discovery') {
                            $workflowNode.SelectSingleNode("DataSource[@ID='$moduleId']")
                        }
                        else {
                            $workflowNode.SelectSingleNode("DataSources/DataSource[@ID='$moduleId']")
                        }
                        $module | Should -Not -BeNullOrEmpty
                        @($module.ChildNodes | Where-Object NodeType -eq Element | ForEach-Object LocalName) | Should -Contain $parameter
                    }
                }
                else {
                    $workflowNode.HasAttribute([string]$override.Property) | Should -BeTrue
                }
            }
        }
    }

    It 'preserves cookdown by applying shared acquisition values to every shared monitor' {
        $path = Join-Path $script:RegeneratedExamples 'HyperVPrivateCloud.Monitoring.Overrides.xml.example'
        [xml]$managementPack = Get-Content -LiteralPath $path -Raw
        foreach ($parameter in @('IntervalSeconds', 'CpuWarningPercent', 'CpuCriticalPercent', 'MemoryWarningMB', 'MemoryCriticalMB', 'PagesInputWarningPerSecond', 'PagesInputCriticalPerSecond', 'CheckpointWarningHours', 'CheckpointCriticalHours')) {
            $nodes = @($managementPack.SelectNodes("//MonitorConfigurationOverride[contains(@Monitor,'.Host.') and @Parameter='$parameter']"))
            $nodes.Count | Should -Be 13
            @($nodes.Value | Sort-Object -Unique).Count | Should -Be 1
        }
        foreach ($parameter in @('IntervalSeconds', 'CheckpointWarningHours', 'CheckpointCriticalHours')) {
            $nodes = @($managementPack.SelectNodes("//MonitorConfigurationOverride[contains(@Monitor,'.VmRuntime.') and @Parameter='$parameter']"))
            $nodes.Count | Should -Be 9
            @($nodes.Value | Sort-Object -Unique).Count | Should -Be 1
        }
    }

    It 'ships the Standard worked group in the same unsealed MP as its overrides' {
        $path = Join-Path $script:RegeneratedExamples "HyperVPrivateCloud.Monitoring.Overrides.xml.example"
        [xml]$managementPack = Get-Content -LiteralPath $path -Raw
        $group = $managementPack.SelectSingleNode('//ClassType[contains(@ID,".Group.AllHosts")]')
        $group | Should -Not -BeNullOrEmpty
        $managementPack.SelectSingleNode("//Discovery[@Target='$($group.ID)']") | Should -Not -BeNullOrEmpty
        @($managementPack.SelectNodes("//Overrides/*[@Context='$($group.ID)']")).Count | Should -BeGreaterThan 0
    }

    It 'rejects unknown schemas, unknown capabilities, and cross-MP group references' {
        $unknownSchemaPath = Join-Path $script:Scratch 'unknown-schema.json'
        [System.IO.File]::WriteAllText($unknownSchemaPath, '{"schemaVersion":"9.9","id":"Custom","capabilities":[]}', [System.Text.UTF8Encoding]::new($false))
        {
            & $script:Generator -DeploymentProfile Custom -TuningTier Lab -OrganizationId Contoso -OrganizationName Contoso `
                -ProductVersion '2.0.0.0' -PublicKeyToken '0123456789abcdef' -ProfilePath $unknownSchemaPath -OutputPath (Join-Path $script:Scratch 'bad-schema')
        } | Should -Throw '*Unsupported deployment profile schemaVersion*'

        $unknownCapabilityPath = Join-Path $script:Scratch 'unknown-capability.json'
        [System.IO.File]::WriteAllText($unknownCapabilityPath, '{"schemaVersion":"2.0","id":"Custom","capabilities":["Imaginary"]}', [System.Text.UTF8Encoding]::new($false))
        {
            & $script:Generator -DeploymentProfile Custom -TuningTier Lab -OrganizationId Contoso -OrganizationName Contoso `
                -ProductVersion '2.0.0.0' -PublicKeyToken '0123456789abcdef' -ProfilePath $unknownCapabilityPath -OutputPath (Join-Path $script:Scratch 'bad-capability')
        } | Should -Throw '*unknown capability*'

        $crossMpPath = Join-Path $script:Scratch 'cross-mp.json'
        $crossMp = @{
            schemaVersion = '2.0'; id = 'Custom'; capabilities = @()
            groups = @(@{ id = 'WrongPack'; kind = 'Discovery'; displayName = 'Wrong pack'; memberClassRef = 'HCSV2Library'; memberClassId = 'HyperVPrivateCloud.HostRole' })
            targeting = @(@{ targetSet = 'Core.HostMonitors'; type = 'group'; groupRef = 'WrongPack' })
        } | ConvertTo-Json -Depth 6
        [System.IO.File]::WriteAllText($crossMpPath, $crossMp, [System.Text.UTF8Encoding]::new($false))
        {
            & $script:Generator -DeploymentProfile Custom -TuningTier Lab -OrganizationId Contoso -OrganizationName Contoso `
                -ProductVersion '2.0.0.0' -PublicKeyToken '0123456789abcdef' -ProfilePath $crossMpPath -OutputPath (Join-Path $script:Scratch 'cross-mp')
        } | Should -Throw '*Cross-MP group reference is not allowed*'
    }

    It 'never writes to the Default Management Pack and emits UTF-8 without BOM' {
        foreach ($file in Get-ChildItem -LiteralPath $script:RegeneratedExamples -Filter '*.xml.example' -File -Recurse) {
            $text = Get-Content -LiteralPath $file.FullName -Raw
            $text | Should -Not -Match 'Microsoft\.SystemCenter\.DefaultUser'
            $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
            @($bytes[0], $bytes[1], $bytes[2]) -join ',' | Should -Not -Be '239,187,191'
        }
    }
}
