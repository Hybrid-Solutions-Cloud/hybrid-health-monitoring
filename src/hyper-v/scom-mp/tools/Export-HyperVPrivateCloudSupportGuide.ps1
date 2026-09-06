#Requires -Version 7.0
<#
.SYNOPSIS
    Exports source-generated console knowledge as a searchable Markdown support reference.
.DESCRIPTION
    Requires already built management packs. Does not connect to SCOM or change monitoring.
    Output files are generated artifacts; edit templates or support-catalog.psd1, then regenerate.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$InputPath,
    [Parameter(Mandatory)][string]$OutputPath
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-SupportMarkdownText {
    param([AllowEmptyString()][string]$Text)
    # Preserve SCOM expressions and XML-looking values without allowing VitePress to treat them as Vue.
    return [System.Net.WebUtility]::HtmlEncode($Text).Replace('|','&#124;').Replace('`','&#96;')
}

$source = (Resolve-Path -LiteralPath $InputPath).Path
$healthGraph = & (Join-Path $PSScriptRoot 'Test-HyperVPrivateCloudHealthGraph.ps1') -Path $source -FailOnMissing | ConvertFrom-Json -AsHashtable
$destination = [IO.Path]::GetFullPath($OutputPath)
[void][IO.Directory]::CreateDirectory($destination)
$index = [Collections.Generic.List[string]]::new()
$index.Add('# Object and monitor support reference')
$index.Add('')
$index.Add('Generated from the candidate management-pack source. This reference can include changes not yet present in an installed sealed release. Compare the installed version and effective overrides. Edit the source knowledge/support catalog, not these generated pages.')
$index.Add('')
$index.Add('Each page includes object types, monitors, dependencies, rules and tasks with diagnostic and recovery guidance. Start with [day-2 triage](index.md).')
$index.Add('')
$index.Add('| Management pack | Object types | Unit monitors | Health dependencies | Rules | Tasks |')
$index.Add('|---|---:|---:|---:|---:|---:|')
foreach ($file in Get-ChildItem -LiteralPath $source -Filter 'HyperVPrivateCloud*.xml' | Sort-Object Name) {
    [xml]$pack = Get-Content -LiteralPath $file.FullName -Raw
    $elements = @($pack.SelectNodes('//ClassType | //UnitMonitor | //DependencyMonitor | //Rule | //Task'))
    if ($elements.Count -eq 0) { continue }
    $packId = $pack.ManagementPack.Manifest.Identity.ID
    $pageName = ($packId -replace '^HyperVPrivateCloud\.','' -replace '\.','-').ToLowerInvariant() + '.md'
    $lines = [Collections.Generic.List[string]]::new()
    $lines.Add('# ' + (ConvertTo-SupportMarkdownText $pack.ManagementPack.Manifest.Name))
    $lines.Add('')
    $lines.Add('Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).')
    $lines.Add('')
    $lines.Add('Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.')
    foreach ($element in $elements) {
        $id = $element.GetAttribute('ID')
        $display = $pack.SelectSingleNode("//DisplayString[@ElementID='$id' and not(@SubElementID)]")
        $name = if ($display) { $display.SelectSingleNode('Name').InnerText } else { $id }
        $lines.Add(''); $lines.Add('## ' + (ConvertTo-SupportMarkdownText $name) + ' {#' + $id.ToLowerInvariant() + '}'); $lines.Add('')
        $lines.Add('`' + $id + '`'); $lines.Add('')
        if ($display -and $display.SelectSingleNode('Description')) { $lines.Add((ConvertTo-SupportMarkdownText $display.SelectSingleNode('Description').InnerText)); $lines.Add('') }
        if ($element.LocalName -eq 'UnitMonitor' -and $healthGraph.Paths.ContainsKey($id)) {
            $lines.Add('### Representative root health path'); $lines.Add('')
            $lines.Add((ConvertTo-SupportMarkdownText $healthGraph.Paths[$id])); $lines.Add('')
            $lines.Add('This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.'); $lines.Add('')
        }
        $article = $pack.SelectSingleNode("//KnowledgeArticle[@ElementID='$id']")
        if (-not $article) { throw "Missing support knowledge: $id" }
        foreach ($section in $article.SelectNodes('MamlContent/*[local-name()="section"]')) {
            $title = $section.SelectSingleNode('*[local-name()="title"]')
            if ($title) { $lines.Add('### ' + (ConvertTo-SupportMarkdownText $title.InnerText)); $lines.Add('') }
            foreach ($para in $section.SelectNodes('.//*[local-name()="para"]')) {
                $link = $para.SelectSingleNode('*[local-name()="navigationLink"]')
                if ($link) {
                    $label = $link.SelectSingleNode('*[local-name()="linkText"]').InnerText
                    $url = $link.SelectSingleNode('*[local-name()="uri"]').GetAttribute('href')
                    $lines.Add('[' + $label + '](' + $url + ')')
                }
                else { $lines.Add((ConvertTo-SupportMarkdownText $para.InnerText)) }
                $lines.Add('')
            }
        }
    }
    [IO.File]::WriteAllText((Join-Path $destination $pageName), ($lines -join "`n").TrimEnd([char[]]"`r`n") + "`n", [Text.UTF8Encoding]::new($false))
    $counts = @('ClassType','UnitMonitor','DependencyMonitor','Rule','Task') | ForEach-Object { @($elements | Where-Object LocalName -eq $_).Count }
    $index.Add('| [' + $packId + '](' + $pageName + ') | ' + ($counts -join ' | ') + ' |')
}
[IO.File]::WriteAllText((Join-Path $destination 'catalog.md'), ($index -join "`n") + "`n", [Text.UTF8Encoding]::new($false))
Write-Output "Exported source-derived support reference to $destination"
