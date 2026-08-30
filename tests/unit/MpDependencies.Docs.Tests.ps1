#Requires -Version 7.0
<#
.SYNOPSIS
    Asserts that the published dependency documentation still matches management pack source.

.DESCRIPTION
    The prerequisite pages carry generated blocks produced by tools/scom/Export-MpDependencies.ps1.
    If a management pack gains, drops, or re-versions a <Reference> and nobody regenerates the docs,
    operators are handed a prerequisite list that will not import. These tests fail the build in that
    case.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Defined at script scope: Pester expands -ForEach during discovery, before BeforeAll would run.
# tests/unit/<file> -> up three levels to the repository root.
$RepoRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSCommandPath))
$Exporter = Join-Path $RepoRoot 'tools/scom/Export-MpDependencies.ps1'
$Pages = @(
    'docs/hyper-v/prerequisites.md'
    'docs/scom-mp/prerequisites.md'
)
$Blocks = @('external-dependencies', 'per-pack-dependencies', 'import-order')

BeforeAll {
    # Recomputed rather than inherited: Pester runs this in a separate scope from discovery.
    $script:RepoRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSCommandPath))
    $script:Exporter = Join-Path $script:RepoRoot 'tools/scom/Export-MpDependencies.ps1'
    $script:Blocks = @('external-dependencies', 'per-pack-dependencies', 'import-order')
}

Describe 'Management pack dependency documentation' {

    It 'has an exporter script' {
        Test-Path -LiteralPath $script:Exporter | Should -BeTrue
    }

    It 'has a prerequisites page at <_>' -ForEach $Pages {
        Test-Path -LiteralPath (Join-Path $script:RepoRoot $_) | Should -BeTrue
    }

    It 'page <_> contains every generated block marker' -ForEach $Pages {
        $content = Get-Content -LiteralPath (Join-Path $script:RepoRoot $_) -Raw
        foreach ($block in $script:Blocks) {
            $content | Should -Match ([regex]::Escape("<!-- BEGIN GENERATED: $block -->"))
            $content | Should -Match ([regex]::Escape("<!-- END GENERATED: $block -->"))
        }
    }

    It 'is in sync with management pack source' {
        # -Check writes nothing and exits non-zero when any generated block is stale.
        & pwsh -NoProfile -File $script:Exporter -Check | Out-String | Write-Verbose
        $LASTEXITCODE | Should -Be 0 -Because 'run tools/scom/Export-MpDependencies.ps1 to regenerate the prerequisite pages'
    }

    It 'documents every external reference found in Hyper-V management pack source' {
        $fragmentRoot = Join-Path $script:RepoRoot 'src/hyper-v/scom-mp/v2/fragments'
        $page = Get-Content -LiteralPath (Join-Path $script:RepoRoot 'docs/hyper-v/prerequisites.md') -Raw

        $referenced = Get-ChildItem -LiteralPath $fragmentRoot -Recurse -Filter 'ManagementPack.xml.template' -File |
            ForEach-Object {
                [regex]::Matches(
                    (Get-Content -LiteralPath $_.FullName -Raw),
                    '<Reference\s+Alias="[^"]+"\s*>\s*<ID>(?<id>[^<]+)</ID>'
                ) | ForEach-Object { $_.Groups['id'].Value }
            } |
            Where-Object { $_ -notlike 'HybridSolutionsCloud.*' -and $_ -notlike 'System.*' -and $_ -notlike 'Microsoft.SystemCenter.*Library' -and $_ -ne 'Microsoft.Windows.Library' } |
            Sort-Object -Unique

        $missing = @($referenced | Where-Object { $page -notmatch [regex]::Escape($_) })
        $missing | Should -BeNullOrEmpty -Because "these referenced packs are absent from the prerequisites page: $($missing -join ', ')"
    }

    It 'never lists a first-party pack as an external prerequisite' {
        $page = Get-Content -LiteralPath (Join-Path $script:RepoRoot 'docs/hyper-v/prerequisites.md') -Raw
        $block = [regex]::Match(
            $page,
            '<!-- BEGIN GENERATED: external-dependencies -->(?<body>.*?)<!-- END GENERATED: external-dependencies -->',
            'Singleline'
        )
        $block.Success | Should -BeTrue
        $block.Groups['body'].Value | Should -Not -Match 'HybridSolutionsCloud\.'
    }
}
