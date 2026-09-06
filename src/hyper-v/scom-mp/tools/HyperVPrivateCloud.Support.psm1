#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HcsSupportExpression {
    param([System.Xml.XmlElement]$Expression, [hashtable]$Configuration)
    if ($null -eq $Expression) { return 'See the native monitor type and state-change context.' }
    $child = $Expression.FirstChild
    if ($child.LocalName -in @('And','Or')) {
        $parts = @($child.SelectNodes('Expression') | ForEach-Object { ConvertTo-HcsSupportExpression $_ $Configuration })
        return '(' + ($parts -join (' ' + $child.LocalName.ToUpperInvariant() + ' ')) + ')'
    }
    if ($child.LocalName -eq 'SimpleExpression') {
        $operands = @($child.SelectNodes('ValueExpression') | ForEach-Object { $_.InnerText })
        $operators = @{Equal='=';NotEqual='!=';Less='<';LessEqual='<=';Greater='>';GreaterEqual='>='}
        $op = $child.SelectSingleNode('Operator').InnerText
        if ($operators.ContainsKey($op)) { $op = $operators[$op] }
        $text = $operands[0] + ' ' + $op + ' ' + $operands[1]
        foreach ($key in $Configuration.Keys) { $text = $text.Replace(('$Config/' + $key + '$'), [string]$Configuration[$key]) }
        return $text
    }
    return $Expression.InnerXml
}

function Get-HcsSupportSections {
    param([xml]$Document, [System.Xml.XmlElement]$Element, [hashtable]$Profile)
    $sections = [ordered]@{}
    $id = $Element.GetAttribute('ID')
    $kind = $Element.LocalName
    $sections['Support scope'] = @($Profile.Meaning, "Element: $id. Kind: $kind.")
    if ($kind -eq 'UnitMonitor') {
        $config = @{}
        foreach ($entry in $Element.SelectNodes('Configuration/*')) { $config[$entry.LocalName] = $entry.InnerText }
        $sections['Target and health path'] = @("Target class: $($Element.GetAttribute('Target')). Parent health aspect: $($Element.GetAttribute('ParentMonitorID')). Enabled by default: $($Element.GetAttribute('Enabled')). Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.")
        $typeId = $Element.GetAttribute('TypeID')
        $monitorType = $Document.SelectSingleNode("//UnitMonitorType[@ID='$typeId']")
        $states = [System.Collections.Generic.List[string]]::new()
        foreach ($state in $Element.SelectNodes('OperationalStates/OperationalState')) {
            $condition = 'Defined by the referenced monitor type; inspect its product knowledge and current state-change context.'
            if ($monitorType) {
                $detection = $monitorType.SelectSingleNode("MonitorImplementation/RegularDetections/RegularDetection[@MonitorTypeStateID='$($state.GetAttribute('MonitorTypeStateID'))']/Node")
                if ($detection) {
                    $filter = $monitorType.SelectSingleNode("MonitorImplementation/MemberModules/ConditionDetection[@ID='$($detection.GetAttribute('ID'))']/Expression")
                    if ($filter) { $condition = ConvertTo-HcsSupportExpression $filter $config }
                }
            }
            $states.Add("$($state.GetAttribute('HealthState')) [$($state.GetAttribute('ID'))]: $condition")
        }
        $states.Add('These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.')
        if ($config.ContainsKey('WarningThreshold') -and $config.ContainsKey('CriticalThreshold') -and $config.WarningThreshold -eq $config.CriticalThreshold) {
            $states.Add('Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.')
        }
        $sections['Why warning or critical'] = @($states)
        $settings = @($config.Keys | Sort-Object | ForEach-Object { "$_=$($config[$_])" })
        $sections['Sampling and effective policy'] = @('Compiled configuration: ' + ($settings -join '; '), 'Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.')
        $alert = $Element.SelectSingleNode('AlertSettings')
        if ($alert) {
            $sections['Alert and recovery behavior'] = @("Alert starts at $($alert.SelectSingleNode('AlertOnState').InnerText); severity=$($alert.SelectSingleNode('AlertSeverity').InnerText); AutoResolve=$($alert.SelectSingleNode('AutoResolve').InnerText). A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.")
        }
    }
    elseif ($kind -eq 'DependencyMonitor') {
        $sections['Why warning or critical'] = @("Target=$($Element.GetAttribute('Target')); relationship=$($Element.GetAttribute('RelationshipType')); member monitor=$($Element.GetAttribute('MemberMonitor')); parent=$($Element.GetAttribute('ParentMonitorID')); algorithm=$($Element.SelectSingleNode('Algorithm').InnerText); unavailable-member policy=$($Element.SelectSingleNode('MemberUnAvailable').InnerText). The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.")
    }
    elseif ($kind -eq 'ClassType') {
        $properties = @($Element.SelectNodes('Property') | ForEach-Object { $_.GetAttribute('ID') }) -join ', '
        $sections['Identity and monitoring ownership'] = @("Base class=$($Element.GetAttribute('Base')); hosted=$($Element.GetAttribute('Hosted')); singleton=$($Element.GetAttribute('Singleton')); declared properties=$properties. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.")
    }
    elseif ($kind -eq 'Task') {
        $sections['Execution safety'] = @("Target=$($Element.GetAttribute('Target')); enabled=$($Element.GetAttribute('Enabled')); timeout=$($Element.GetAttribute('Timeout')). Read the task's original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.")
    }
    elseif ($kind -eq 'Rule') {
        $sections['Alert versus health'] = @("Target=$($Element.GetAttribute('Target')); enabled=$($Element.GetAttribute('Enabled')); category=$($Element.SelectSingleNode('Category').InnerText). Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.")
    }
    $sections['Read-only investigation'] = @($Profile.Diagnose)
    $sections['Corrective action and escalation'] = @($Profile.Repair, 'Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.')
    $sections['Verify recovery'] = @($Profile.Verify)
    return $sections
}

function Add-HcsSupportKnowledge {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Content, [Parameter(Mandatory)][string]$CatalogPath)
    $catalog = Import-PowerShellDataFile -LiteralPath $CatalogPath
    [xml]$document = $Content
    $language = $document.SelectSingleNode('/ManagementPack/LanguagePacks/LanguagePack[@ID="ENU"]')
    if (-not $language) { throw 'ENU language pack is required for support knowledge.' }
    $articles = $language.SelectSingleNode('KnowledgeArticles')
    if (-not $articles) {
        $articles = $document.CreateElement('KnowledgeArticles')
        [void]$language.AppendChild($articles)
    }
    foreach ($element in $document.SelectNodes('//ClassType | //UnitMonitor | //DependencyMonitor | //Rule | //Task')) {
        $id = $element.GetAttribute('ID')
        $profile = @($catalog.Profiles | Where-Object { $id -match $_.Match })[0]
        $article = $articles.SelectSingleNode("KnowledgeArticle[@ElementID='$id']")
        if (-not $article) {
            $article = $document.CreateElement('KnowledgeArticle')
            $article.SetAttribute('ElementID',$id)
            $article.SetAttribute('Visible','true')
            [void]$articles.AppendChild($article)
            [void]$article.AppendChild($document.CreateElement('MamlContent'))
        }
        $maml = $article.SelectSingleNode('MamlContent')
        $sections = Get-HcsSupportSections $document $element $profile
        if ($element.LocalName -eq 'UnitMonitor' -and $catalog.StateReasons.ContainsKey($id)) {
            $sections['Probe-specific state reasons'] = @($catalog.StateReasons[$id], 'Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.')
        }
        elseif ($element.LocalName -eq 'UnitMonitor' -and $element.SelectSingleNode('Configuration/DeviceKind')) {
            $sections['Probe-specific state reasons'] = @($catalog.StateReasons['FabricDeviceState'])
        }
        if ($element.LocalName -eq 'ClassType') {
            if (-not $catalog.Classes.ContainsKey($id)) { throw "Missing object-specific support description: $id" }
            $sections['What this object represents'] = @($catalog.Classes[$id])
            $display = $language.SelectSingleNode("DisplayStrings/DisplayString[@ElementID='$id' and not(@SubElementID)]")
            if ($display) {
                $description = $display.SelectSingleNode('Description')
                if (-not $description) { $description = $document.CreateElement('Description'); [void]$display.AppendChild($description) }
                $description.InnerText = $catalog.Classes[$id]
            }
        }
        if ($catalog.Replacements.ContainsKey($id)) {
            $maml.RemoveAll()
            $display = $language.SelectSingleNode("DisplayStrings/DisplayString[@ElementID='$id' and not(@SubElementID)]")
            if ($display) {
                $display.SelectSingleNode('Description').InnerText = $catalog.Replacements[$id].Summary
                if ($catalog.Replacements[$id].ContainsKey('Name')) {
                    $display.SelectSingleNode('Name').InnerText = $catalog.Replacements[$id].Name
                    $alertDisplay = $language.SelectSingleNode("DisplayStrings/DisplayString[@ElementID='$id.Message']/Name")
                    if ($alertDisplay) { $alertDisplay.InnerText = $catalog.Replacements[$id].Name + ' threshold breached' }
                }
            }
            $reviewed = [ordered]@{}
            foreach ($title in @('Summary','Causes','Resolution')) { $reviewed[$title] = @($catalog.Replacements[$id][$title]) }
            foreach ($title in $sections.Keys) { $reviewed[$title] = $sections[$title] }
            $sections = $reviewed
        }
        foreach ($title in $sections.Keys) {
            $section = $document.CreateElement('maml','section','http://schemas.microsoft.com/maml/2004/10')
            $heading = $document.CreateElement('maml','title','http://schemas.microsoft.com/maml/2004/10')
            $heading.InnerText = $title
            [void]$section.AppendChild($heading)
            foreach ($paragraph in $sections[$title]) {
                $para = $document.CreateElement('maml','para','http://schemas.microsoft.com/maml/2004/10')
                $para.InnerText = [string]$paragraph
                [void]$section.AppendChild($para)
            }
            [void]$maml.AppendChild($section)
        }
        $references = $document.CreateElement('maml','section','http://schemas.microsoft.com/maml/2004/10')
        $title = $document.CreateElement('maml','title','http://schemas.microsoft.com/maml/2004/10')
        $title.InnerText = 'Microsoft references'
        [void]$references.AppendChild($title)
        foreach ($url in $profile.Links) {
            $para = $document.CreateElement('maml','para','http://schemas.microsoft.com/maml/2004/10')
            $link = $document.CreateElement('maml','navigationLink','http://schemas.microsoft.com/maml/2004/10')
            $text = $document.CreateElement('maml','linkText','http://schemas.microsoft.com/maml/2004/10')
            $text.InnerText = 'Microsoft Learn: ' + (($url -split '/')[-1] -replace '\?.*$','' -replace '-',' ')
            $uri = $document.CreateElement('maml','uri','http://schemas.microsoft.com/maml/2004/10')
            $uri.SetAttribute('href', $url)
            [void]$link.AppendChild($text); [void]$link.AppendChild($uri)
            [void]$para.AppendChild($link); [void]$references.AppendChild($para)
        }
        [void]$maml.AppendChild($references)
    }
    return $document.OuterXml
}

Export-ModuleMember -Function Add-HcsSupportKnowledge, Get-HcsSupportSections, ConvertTo-HcsSupportExpression
