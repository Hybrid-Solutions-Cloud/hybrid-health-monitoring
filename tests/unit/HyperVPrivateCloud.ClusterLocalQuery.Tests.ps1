#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

BeforeAll {
    $script:ClusterProbe = Join-Path $PSScriptRoot '../../src/hyper-v/scom-mp/fragments/capabilities/cluster/Get-HyperVPrivateCloudClusterCsvHealth.ps1.template'
    Import-Module (Join-Path $PSScriptRoot 'HcsProbeFixture.psm1') -Force
}

Describe 'Cluster collection on passive nodes' {
    It 'counts the actual dynamic vote of a paused member without treating it as a down node' {
        $stubs=@'
function Get-Cluster { [pscustomobject]@{Name='fixture-cluster';WitnessDynamicWeight=1} }
function Get-ClusterNode { [pscustomobject]@{State='Up';DynamicWeight=1}; [pscustomobject]@{State='Paused';DynamicWeight=1} }
function Get-ClusterQuorum { [pscustomobject]@{QuorumType='NodeAndFileShareMajority';QuorumResource=[pscustomobject]@{ResourceType='File Share Witness';State='Online'}} }
function Get-ClusterNetwork { [pscustomobject]@{State='Up'} }
function Get-ClusterGroup { [pscustomobject]@{State='Online'} }
function Get-ClusterSharedVolume { @() }
function Get-WinEvent { @() }
'@
        $result=Invoke-HcsFixtureProbe -TemplatePath $script:ClusterProbe -Parameters @{ComputerName='fixture';BoundaryId='cluster:fixture'} -Stubs $stubs
        $result.HcsEventLog | Should -BeNullOrEmpty
        $result.QuorumCurrentVotes | Should -Be 3
        $result.QuorumVoteMarginCount | Should -Be 1
        $result.NodePausedCount | Should -Be 1
        $result.NodeDownCount | Should -Be 0
    }
    It 'uses local cluster queries instead of a remote cluster network name' {
        $parseErrors=$null
        $tokens=$null
        $ast=[Management.Automation.Language.Parser]::ParseFile($script:ClusterProbe,[ref]$tokens,[ref]$parseErrors)
        $parseErrors.Count | Should -Be 0
        $queries=@($ast.FindAll({ param($node) $node -is [Management.Automation.Language.CommandAst] -and $node.GetCommandName() -in @('Get-ClusterNode','Get-ClusterQuorum','Get-ClusterNetwork','Get-ClusterGroup','Get-ClusterSharedVolume') },$true))
        $queries.Count | Should -Be 5
        foreach ($query in $queries) {
            @($query.CommandElements | Where-Object { $_ -is [Management.Automation.Language.CommandParameterAst] -and $_.ParameterName -eq 'Cluster' }).Count | Should -Be 0
        }
    }

    It 'does not report healthy when quorum collection is denied' {
        $stubs=@'
function Get-Cluster { [pscustomobject]@{Name='fixture-cluster';WitnessDynamicWeight=1} }
function Get-ClusterNode { [pscustomobject]@{State='Up';DynamicWeight=1}; [pscustomobject]@{State='Up';DynamicWeight=1} }
function Get-ClusterQuorum { throw [UnauthorizedAccessException]::new('Quorum access denied') }
function Get-ClusterNetwork { [pscustomobject]@{State='Up'} }
function Get-ClusterGroup { [pscustomobject]@{State='Online'} }
function Get-ClusterSharedVolume { @() }
function Get-WinEvent { @() }
'@
        $result=Invoke-HcsFixtureProbe -TemplatePath $script:ClusterProbe -Parameters @{ComputerName='fixture';BoundaryId='cluster:fixture'} -Stubs $stubs
        $result.ClusterCsvHealthState | Should -Be 'Warning'
        $result.HcsEventLog | Should -Match 'local cluster quorum failed: Quorum access denied'
    }
}
