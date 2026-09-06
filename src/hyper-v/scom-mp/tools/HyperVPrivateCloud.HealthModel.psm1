#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Add-HcsReviewedHealthRoutes {
    <# Missing aspect paths identified by the root-to-leaf graph audit. Explicit additions only:
       do not automatically copy every vendor EntityState into every component. #>
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Content)
    [xml]$document = $Content
    $packId = [string]$document.ManagementPack.Manifest.Identity.ID
    $plans = @{
        'HyperVPrivateCloud.Capability.Storage' = @(
            @('Attachment.Dependency.Monitor','Performance'),
            @('FibreChannelPort.Dependency.Monitor','Performance'))
        'HyperVPrivateCloud.Capability.NetworkATC' = @(
            @('IntentNode.Dependency.Monitor','Configuration'),
            @('NetworkIntent.Dependency.Monitor','Configuration'))
        'HyperVPrivateCloud.Capability.S2D' = @(
            @('StorageSubSystem.Dependency.Monitor','Performance'),
            @('StorageSubSystem.Dependency.Monitor','Configuration'))
        'HyperVPrivateCloud.Capability.PureStorage' = @(
            ,@('Array.Dependency.Monitor','Configuration'))
        'HyperVPrivateCloud.Capability.VMM' = @(
            ,@('Management.Server.Availability.Dependency.Monitor','Performance'))
    }
    $monitors = $document.SelectSingleNode('/ManagementPack/Monitoring/Monitors')
    $displays = $document.SelectSingleNode('/ManagementPack/LanguagePacks/LanguagePack[@ID="ENU"]/DisplayStrings')
    $added = [Collections.Generic.List[object]]::new()
    if ($plans.ContainsKey($packId)) {
        foreach ($plan in $plans[$packId]) {
            $originalId = $packId + '.' + $plan[0]
            $original = $monitors.SelectSingleNode("DependencyMonitor[@ID='$originalId']")
            if (-not $original) { throw "Missing baseline dependency: $originalId" }
            $clone = $original.CloneNode($true)
            $clone.SetAttribute('ID',($originalId -replace '\.Dependency\.Monitor$',('.' + $plan[1] + '.Dependency.Monitor')))
            if ($originalId -like '*.Management.Server.Availability.Dependency.Monitor') {
                $clone.SetAttribute('ID',($originalId -replace '\.Availability\.',('.' + $plan[1] + '.')))
            }
            $clone.SetAttribute('ParentMonitorID',('Health!System.Health.'+$plan[1]+'State'))
            $clone.SetAttribute('MemberMonitor',('Health!System.Health.'+$plan[1]+'State'))
            $clone.SelectSingleNode('Category').InnerText = $plan[1]+'Health'
            [void]$monitors.AppendChild($clone)
            $added.Add($clone)
        }
    }
    $participation = @{
        'HyperVPrivateCloud.Capability.Storage' = @('ComponentContainsHostParticipation','Topology.Discovery')
        'HyperVPrivateCloud.Capability.FileServices' = @('StorageContainsHostParticipation','Discovery')
    }
    if ($participation.ContainsKey($packId)) {
        $relationshipId = $packId + '.' + $participation[$packId][0]
        $discoveryId = $packId + '.' + $participation[$packId][1]
        $discoveryTypes = $document.SelectSingleNode("//Discovery[@ID='$discoveryId']/DiscoveryTypes")
        if (-not $document.SelectSingleNode("//RelationshipType[@ID='$relationshipId']") -or -not $discoveryTypes) { throw "Missing participation topology: $packId" }
        $declaration = $document.CreateElement('DiscoveryRelationship'); $declaration.SetAttribute('TypeID',$relationshipId)
        [void]$discoveryTypes.AppendChild($declaration)
        foreach ($aspect in @('Availability','Performance','Configuration','Security')) {
            $fragment = $document.CreateDocumentFragment()
            $fragment.InnerXml = '<DependencyMonitor ID="'+$packId+'.Participation.'+$aspect+'.Dependency.Monitor" Accessibility="Public" Enabled="true" Target="HCSV2Library!HyperVPrivateCloud.StorageComponent" ParentMonitorID="Health!System.Health.'+$aspect+'State" Remotable="true" Priority="Normal" RelationshipType="'+$relationshipId+'" MemberMonitor="Health!System.Health.'+$aspect+'State"><Category>'+$aspect+'Health</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Success</MemberUnAvailable></DependencyMonitor>'
            $monitor = $fragment.FirstChild
            [void]$monitors.AppendChild($monitor); $added.Add($monitor)
        }
        # The baseline builder may already have generated a display for the new relationship.
        # Update that display, never append the same ElementID twice (SDK rejects duplicates).
        $display = $displays.SelectSingleNode("DisplayString[@ElementID='$relationshipId' and not(@SubElementID)]")
        if (-not $display) {
            $display = $document.CreateElement('DisplayString'); $display.SetAttribute('ElementID',$relationshipId)
            [void]$displays.AppendChild($display)
        }
        $name = $display.SelectSingleNode('Name')
        if (-not $name) { $name=$document.CreateElement('Name'); [void]$display.AppendChild($name) }
        $name.InnerText = 'Storage component contains '+($packId -split '\.')[-1]+' host participation'
        $description = $display.SelectSingleNode('Description')
        if (-not $description) { $description=$document.CreateElement('Description'); [void]$display.AppendChild($description) }
        $description.InnerText = 'Links only discovered participating hosts into the Storage branch; absent capability does not create a synthetic failure.'
    }
    foreach ($monitor in $added) {
        $display = $document.CreateElement('DisplayString'); $display.SetAttribute('ElementID',$monitor.ID)
        $name = $document.CreateElement('Name'); $name.InnerText = 'Roll up '+($monitor.MemberMonitor -replace '^.*System.Health\.','' -replace 'State$','')+' through '+($monitor.RelationshipType -replace '^.*Capability\.','')
        $description = $document.CreateElement('Description'); $description.InnerText = 'Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.'
        [void]$display.AppendChild($name); [void]$display.AppendChild($description); [void]$displays.AppendChild($display)
    }
    return $document.OuterXml
}

Export-ModuleMember -Function Add-HcsReviewedHealthRoutes
