#Requires -Version 7.0
<#
.SYNOPSIS
    Regenerates or verifies the committed Hyper-V override example files.

.DESCRIPTION
    Invokes the supported override generator for Lab, Standard, and Strict with deterministic
    sentinel values, replaces those values with documented placeholder tokens, and either updates
    the committed examples or fails when they have drifted.

.PARAMETER Check
    Verifies that every committed example is byte-identical to generator output without modifying
    the source tree.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
    Version: 1.0.0
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'HCS scripting standard requires Write-Host for operator status.')]
[CmdletBinding()]
param(
    [Parameter()]
    [switch]$Check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$sourceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$generator = Join-Path $PSScriptRoot 'New-HyperVOverrideManagementPacks.ps1'
$temporaryRoot = Join-Path ([System.IO.Path]::GetTempPath()) "hcs-hyperv-examples-$([guid]::NewGuid().ToString('N'))"
$expectedTemporaryParent = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

$sentinels = [ordered]@{
    '{{ORGANIZATION_ID}}' = 'ExampleOrganization'
    '{{ORGANIZATION_NAME}}' = 'Example Organization'
    '{{VERSION}}' = '9.9.9.9'
    '{{PRODUCT_VERSION}}' = '8.8.8.8'
    '{{PUBLIC_KEY_TOKEN}}' = 'abcdef0123456789'
}

try {
    [System.IO.Directory]::CreateDirectory($temporaryRoot) | Out-Null

    foreach ($tuningProfile in @('Lab', 'Standard', 'Strict')) {
        $generatedRoot = Join-Path $temporaryRoot $tuningProfile
        & $generator -TuningProfile $tuningProfile -OrganizationId $sentinels['{{ORGANIZATION_ID}}'] -OrganizationName $sentinels['{{ORGANIZATION_NAME}}'] -Version $sentinels['{{VERSION}}'] -ProductVersion $sentinels['{{PRODUCT_VERSION}}'] -PublicKeyToken $sentinels['{{PUBLIC_KEY_TOKEN}}'] -OutputPath $generatedRoot

        foreach ($kind in @('Discovery', 'Monitoring')) {
            $generatedPath = Join-Path $generatedRoot "ExampleOrganization.HybridSolutionsCloud.HyperV.$kind.Overrides.xml"
            $expected = [System.IO.File]::ReadAllText($generatedPath)
            foreach ($placeholder in $sentinels.Keys) {
                $expected = $expected.Replace($sentinels[$placeholder], $placeholder)
            }

            $destination = Join-Path $sourceRoot "templates/overrides/$($tuningProfile.ToLowerInvariant())/$kind.Overrides.xml.example"
            if ($Check) {
                if (-not (Test-Path -LiteralPath $destination -PathType Leaf)) {
                    throw "Missing generated override example: $destination"
                }
                $actual = [System.IO.File]::ReadAllText($destination)
                if (-not [string]::Equals($actual, $expected, [StringComparison]::Ordinal)) {
                    throw "Generated override example drift detected: $destination. Run Update-HyperVOverrideExamples.ps1."
                }
                Write-Host "Verified override example: $destination" -ForegroundColor Green
            }
            else {
                [System.IO.File]::WriteAllText($destination, $expected, $utf8NoBom)
                Write-Host "Updated override example: $destination" -ForegroundColor Green
            }
        }
    }
}
finally {
    if (Test-Path -LiteralPath $temporaryRoot) {
        $resolvedTemporaryRoot = [System.IO.Path]::GetFullPath($temporaryRoot)
        if (-not $resolvedTemporaryRoot.StartsWith($expectedTemporaryParent, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to remove unexpected temporary path: $resolvedTemporaryRoot"
        }
        Remove-Item -LiteralPath $resolvedTemporaryRoot -Recurse -Force
    }
}
