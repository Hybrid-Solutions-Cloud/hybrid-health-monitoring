#Requires -Version 7.0
<#
.SYNOPSIS
    Audits enabled product unit-monitor paths to the enterprise solution in compiled MP XML.
.DESCRIPTION
    Traverses authored dependencies by health aspect and local class inheritance. Reports one
    representative path per reachable leaf. External monitor/relationship implementations are
    reported separately, not assumed validated. This does not prove live discovery membership.
#>
[CmdletBinding()]
param([Parameter(Mandatory)][string]$Path, [switch]$FailOnMissing)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Normalize-Id([string]$Value) { return ($Value -split '!')[-1] }
$classes=@{}; $relationships=@{}; $monitors=@{}
foreach($file in Get-ChildItem -LiteralPath $Path -Filter 'HyperVPrivateCloud*.xml') {
    [xml]$pack=Get-Content $file.FullName -Raw
    foreach($class in $pack.SelectNodes('//ClassType')) { $classes[$class.ID]=Normalize-Id $class.Base }
    foreach($relationship in $pack.SelectNodes('//RelationshipType')) { $relationships[$relationship.ID]=Normalize-Id $relationship.Target.Type }
    foreach($monitor in $pack.SelectNodes('//UnitMonitor | //DependencyMonitor | //AggregateMonitor')) { $monitors[$monitor.ID]=$monitor }
}
if (-not $classes.ContainsKey('HyperVPrivateCloud.Enterprise.Solution') -or $monitors.Count -eq 0) {
    throw 'A compiled solution root and monitor definitions are required; empty or unrelated input cannot pass the health graph audit.'
}
function Get-ClassChain([string]$Class) {
    $chain=[Collections.Generic.List[string]]::new(); $current=$Class
    while($current -and -not $chain.Contains($current)) { $chain.Add($current); $current=$classes[$current] }
    return @($chain)
}
$pending=[Collections.Generic.Queue[object]]::new()
$pending.Enqueue(@('HyperVPrivateCloud.Enterprise.Solution','System.Health.EntityState','Solution'))
$visited=[Collections.Generic.HashSet[string]]::new()
$reached=@{}; $unresolved=[Collections.Generic.HashSet[string]]::new()
while($pending.Count) {
    $entry=$pending.Dequeue(); $class=$entry[0]; $monitorId=$entry[1]; $trace=$entry[2]
    if(-not $visited.Add("$class|$monitorId")) {continue}
    if($monitorId -eq 'System.Health.EntityState') {
        foreach($aspect in @('Availability','Performance','Configuration','Security')) { $pending.Enqueue(@($class,"System.Health.${aspect}State",$trace)) }; continue
    }
    if($monitorId -like 'System.Health.*' -or ($monitors.ContainsKey($monitorId) -and $monitors[$monitorId].LocalName -eq 'AggregateMonitor')) {
        $chain=Get-ClassChain $class
        foreach($child in @($monitors.Values | Sort-Object ID)) {
            if((Normalize-Id $child.GetAttribute('ParentMonitorID')) -eq $monitorId -and (Normalize-Id $child.GetAttribute('Target')) -in $chain -and $child.GetAttribute('Enabled') -ne 'false') {
                $pending.Enqueue(@($class,$child.ID,($trace+' > '+$child.ID)))
            }
        }; continue
    }
    if(-not $monitors.ContainsKey($monitorId)) { $null=$unresolved.Add($monitorId); continue }
    $monitor=$monitors[$monitorId]
    if($monitor.LocalName -eq 'UnitMonitor') { $reached[$monitorId]=$trace; continue }
    if($monitor.LocalName -eq 'DependencyMonitor') {
        $relation=Normalize-Id $monitor.RelationshipType
        if(-not $relationships.ContainsKey($relation)) {$null=$unresolved.Add($relation);continue}
        $pending.Enqueue(@($relationships[$relation],(Normalize-Id $monitor.MemberMonitor),$trace))
    }
}
$missing=@($monitors.Values|Where-Object {$_.LocalName -eq 'UnitMonitor' -and $_.GetAttribute('Enabled') -ne 'false' -and -not $reached.ContainsKey($_.ID)}|Sort-Object ID|ForEach-Object {[pscustomobject]@{ID=$_.ID;Target=$_.Target;Parent=$_.ParentMonitorID}})
[pscustomobject]@{ReachedUnitMonitors=$reached.Count;NotProvenReachable=$missing;ExternalRelationshipsOrMonitors=@($unresolved);Paths=$reached}|ConvertTo-Json -Depth 6
if ($FailOnMissing -and $missing.Count) { throw "$($missing.Count) enabled product monitors have no proven source-defined path to the solution root." }
