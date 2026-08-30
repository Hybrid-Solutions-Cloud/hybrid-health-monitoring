#Requires -Version 7.0
<#
.SYNOPSIS
    Collects read-only SCOM evidence for Hyper-V Private Cloud Monitoring v2.

.DESCRIPTION
    Connects to a pre-production Operations Manager management group, verifies the expected
    imported product identities and topology, inventories authored workflows and views, and
    checks for a recent HealthService diagnostic-task result. It writes a detailed snapshot and
    an explicitly unapproved release-evidence draft. Fault, recovery, scale, upgrade, override,
    removal, and Default Management Pack comparison gates remain manual lab activities.

.PARAMETER ManagementServer
    SCOM management server that runs the System Center Data Access service.

.PARAMETER ProductVersion
    Expected four-part version of every HCS sealed product Management Pack.

.PARAMETER PublicKeyToken
    Expected permanent 16-character public key token of the HCS sealed product MPs.

.PARAMETER ExpectationPath
    JSON file describing the product MPs, override MPs, classes, and minimum instance counts for
    this representative lab lane.

.PARAMETER OutputPath
    New or existing directory where the snapshot and unapproved evidence draft are written.

.PARAMETER Credential
    Optional credential used for the management-group connection. The credential is never written
    to evidence.

.PARAMETER DiagnosticMaximumAgeHours
    Maximum age of a completed diagnostic task result accepted as runtime evidence.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingWriteHost',
    '',
    Justification = 'Certification summaries are intentional operator-facing output.'
)]
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ManagementServer,

    [Parameter(Mandatory)]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$ProductVersion,

    [Parameter(Mandatory)]
    [ValidatePattern('^[0-9a-fA-F]{16}$')]
    [string]$PublicKeyToken,

    [Parameter(Mandatory)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$ExpectationPath,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath,

    [Parameter()]
    [PSCredential]$Credential,

    [Parameter()]
    [ValidateRange(1, 168)]
    [int]$DiagnosticMaximumAgeHours = 24
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HcsObjectProperty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][AllowNull()][object]$InputObject,
        [Parameter(Mandatory)][string]$Name
    )
    if ($null -eq $InputObject) { return $null }
    $property = $InputObject.PSObject.Properties[$Name]
    if ($null -eq $property) { return $null }
    return $property.Value
}

function Add-HcsCheck {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][System.Collections.Generic.List[object]]$List,
        [Parameter(Mandatory)][string]$Category,
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][ValidateSet('Passed', 'Failed', 'Pending')][string]$Status,
        [Parameter(Mandatory)][string]$Evidence
    )
    $List.Add([pscustomobject]@{
            category = $Category
            name = $Name
            status = $Status
            evidence = $Evidence
        })
}

function Test-HcsCategoryPassed {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object[]]$Checks,
        [Parameter(Mandatory)][string[]]$Categories
    )
    $matching = @($Checks | Where-Object { $_.category -in $Categories })
    return $matching.Count -gt 0 -and @($matching | Where-Object status -ne 'Passed').Count -eq 0
}

$resolvedExpectationPath = (Resolve-Path -LiteralPath $ExpectationPath).Path
$expectation = Get-Content -LiteralPath $resolvedExpectationPath -Raw | ConvertFrom-Json
if ([string]$expectation.schemaVersion -ne '1.0') { throw 'Unsupported certification expectation schema. Expected 1.0.' }
if (@($expectation.productManagementPacks).Count -eq 0) { throw 'The expectation must name at least one product Management Pack.' }
if (@($expectation.classes).Count -eq 0) { throw 'The expectation must name at least one discovered class.' }

$operationsManagerModule = Get-Module -ListAvailable OperationsManager | Sort-Object Version -Descending | Select-Object -First 1
if ($null -eq $operationsManagerModule) {
    throw 'The OperationsManager PowerShell module is unavailable. Run this collector from a supported SCOM console or management server.'
}
Import-Module $operationsManagerModule.Path -ErrorAction Stop

$connectionArguments = @{ ComputerName = $ManagementServer; PassThru = $true }
if ($null -ne $Credential) { $connectionArguments.Credential = $Credential }
$session = @(New-SCOMManagementGroupConnection @connectionArguments | Select-Object -First 1)
if ($session.Count -ne 1) { throw "Could not establish a SCOM management-group connection through '$ManagementServer'." }
$scSession = $session[0]

$checks = [System.Collections.Generic.List[object]]::new()
$managementPackEvidence = [System.Collections.Generic.List[object]]::new()
$classEvidence = [System.Collections.Generic.List[object]]::new()
$workflowEvidence = [ordered]@{ discoveries = @(); monitors = @(); rules = @(); tasks = @(); views = @() }
$expectedToken = $PublicKeyToken.ToLowerInvariant()

foreach ($expectedMp in @($expectation.productManagementPacks)) {
    $id = [string]$expectedMp.id
    $mpMatches = @(Get-SCOMManagementPack -Name $id -SCSession $scSession | Where-Object { [string]$_.Name -eq $id })
    if ($mpMatches.Count -ne 1) {
        Add-HcsCheck -List $checks -Category 'CleanImport' -Name $id -Status 'Failed' -Evidence "Expected one imported sealed MP; found $($mpMatches.Count)."
        continue
    }
    $mp = $mpMatches[0]
    $actualVersion = [string](Get-HcsObjectProperty -InputObject $mp -Name 'Version')
    $actualToken = ([string](Get-HcsObjectProperty -InputObject $mp -Name 'KeyToken')).ToLowerInvariant()
    $sealed = [bool](Get-HcsObjectProperty -InputObject $mp -Name 'Sealed')
    $passed = $sealed -and $actualVersion -eq $ProductVersion -and $actualToken -eq $expectedToken
    Add-HcsCheck -List $checks -Category 'CleanImport' -Name $id -Status $(if ($passed) { 'Passed' } else { 'Failed' }) `
        -Evidence "sealed=$sealed; version=$actualVersion; token=$actualToken"
    $managementPackEvidence.Add([pscustomobject]@{ id = $id; version = $actualVersion; publicKeyToken = $actualToken; sealed = $sealed })

    foreach ($workflowType in @(
            @{ Name = 'discoveries'; Command = 'Get-SCOMDiscovery' },
            @{ Name = 'monitors'; Command = 'Get-SCOMMonitor' },
            @{ Name = 'rules'; Command = 'Get-SCOMRule' },
            @{ Name = 'tasks'; Command = 'Get-SCOMTask' }
        )) {
        $command = Get-Command $workflowType.Command -ErrorAction SilentlyContinue
        if ($null -eq $command) { continue }
        $items = @(& $command -ManagementPack $mp -SCSession $scSession -ErrorAction SilentlyContinue)
        $workflowEvidence[$workflowType.Name] += @($items | ForEach-Object { [string]$_.Name } | Sort-Object -Unique)
    }
    if ($mp.PSObject.Methods['GetViews']) {
        $workflowEvidence.views += @($mp.GetViews() | ForEach-Object { [string]$_.Name } | Sort-Object -Unique)
    }
}

foreach ($overrideId in @($expectation.overrideManagementPacks)) {
    $overrideMatches = @(Get-SCOMManagementPack -Name ([string]$overrideId) -SCSession $scSession | Where-Object { [string]$_.Name -eq [string]$overrideId })
    $passed = $overrideMatches.Count -eq 1 -and -not [bool](Get-HcsObjectProperty -InputObject $overrideMatches[0] -Name 'Sealed')
    Add-HcsCheck -List $checks -Category 'CleanImport' -Name ([string]$overrideId) -Status $(if ($passed) { 'Passed' } else { 'Failed' }) `
        -Evidence "Expected one imported unsealed override MP; found $($overrideMatches.Count)."
}

foreach ($expectedClass in @($expectation.classes)) {
    $id = [string]$expectedClass.id
    $minimum = [int]$expectedClass.minimumInstances
    $classes = @(Get-SCOMClass -Name $id -SCSession $scSession | Where-Object { [string]$_.Name -eq $id })
    $instances = if ($classes.Count -eq 1) { @(Get-SCOMClassInstance -Class $classes[0] -SCSession $scSession) } else { @() }
    $count = $instances.Count
    $passed = $classes.Count -eq 1 -and $count -ge $minimum
    $category = if ([string]$expectedClass.category -eq 'Capability') { 'CapabilityIntegrations' } else { 'TopologyDiscovery' }
    Add-HcsCheck -List $checks -Category $category -Name $id -Status $(if ($passed) { 'Passed' } else { 'Failed' }) `
        -Evidence "classDefinitions=$($classes.Count); instances=$count; minimum=$minimum"
    $classEvidence.Add([pscustomobject]@{ id = $id; category = $category; instances = $count; minimumInstances = $minimum })
}

$requiredWorkflowMap = [ordered]@{
    discoveries = @($expectation.requiredWorkflows.discoveries)
    monitors = @($expectation.requiredWorkflows.monitors)
    rules = @($expectation.requiredWorkflows.rules)
    tasks = @($expectation.requiredWorkflows.tasks)
    views = @($expectation.requiredWorkflows.views)
}
foreach ($kind in $requiredWorkflowMap.Keys) {
    foreach ($id in $requiredWorkflowMap[$kind]) {
        $passed = [string]$id -in @($workflowEvidence[$kind])
        Add-HcsCheck -List $checks -Category 'WorkflowInventory' -Name ([string]$id) -Status $(if ($passed) { 'Passed' } else { 'Failed' }) `
            -Evidence "Required $kind element present=$passed"
    }
}

$taskId = 'HyperVPrivateCloud.DiagnosticSummary.Task'
$diagnosticTask = @(Get-SCOMTask -Name $taskId -SCSession $scSession | Where-Object { [string]$_.Name -eq $taskId } | Select-Object -First 1)
$diagnosticEvidence = $null
if ($diagnosticTask.Count -eq 1) {
    $cutoff = [DateTimeOffset]::UtcNow.AddHours(-$DiagnosticMaximumAgeHours)
    $results = @(Get-SCOMTaskResult -Task $diagnosticTask[0] -SCSession $scSession -ErrorAction SilentlyContinue)
    $recent = @($results | Where-Object {
            $finished = Get-HcsObjectProperty -InputObject $_ -Name 'TimeFinished'
            $null -ne $finished -and [DateTimeOffset]$finished -ge $cutoff
        } | Sort-Object { Get-HcsObjectProperty -InputObject $_ -Name 'TimeFinished' } -Descending | Select-Object -First 1)
    if ($recent.Count -eq 1) {
        $status = [string](Get-HcsObjectProperty -InputObject $recent[0] -Name 'Status')
        $output = [string](Get-HcsObjectProperty -InputObject $recent[0] -Name 'Output')
        $runtimePassed = $status -match 'Succeeded|Success' -and $output -match 'PSEdition' -and $output -match 'PowerShellVersion'
        $diagnosticEvidence = [pscustomobject]@{
            status = $status
            timeFinished = [string](Get-HcsObjectProperty -InputObject $recent[0] -Name 'TimeFinished')
            output = $output
        }
        Add-HcsCheck -List $checks -Category 'PowerShellRuntime' -Name $taskId -Status $(if ($runtimePassed) { 'Passed' } else { 'Failed' }) `
            -Evidence "Recent task result status=$status; runtime fields present=$($output -match 'PSEdition' -and $output -match 'PowerShellVersion')."
    }
    else {
        Add-HcsCheck -List $checks -Category 'PowerShellRuntime' -Name $taskId -Status 'Failed' `
            -Evidence "No completed result was found within $DiagnosticMaximumAgeHours hour(s). Run the task against every representative host."
    }
}
else {
    Add-HcsCheck -List $checks -Category 'PowerShellRuntime' -Name $taskId -Status 'Failed' -Evidence 'The diagnostic task is not imported.'
}

$presentationPassed = @($workflowEvidence.views).Count -gt 0 -and
    @($classEvidence | Where-Object { $_.id -eq 'HyperVPrivateCloud.Service' -and $_.instances -ge 1 }).Count -eq 1
Add-HcsCheck -List $checks -Category 'DistributedApplicationAndViews' -Name 'Service topology and views' `
    -Status $(if ($presentationPassed) { 'Passed' } else { 'Failed' }) `
    -Evidence "views=$(@($workflowEvidence.views).Count); serviceInstances=$(@($classEvidence | Where-Object id -eq 'HyperVPrivateCloud.Service' | Select-Object -ExpandProperty instances -ErrorAction SilentlyContinue) -join ',')"

$recentAlertCutoff = [DateTime]::UtcNow.AddHours(-24).ToString('yyyy-MM-dd HH:mm:ss')
$recentAlerts = @(Get-SCOMAlert -Criteria "LastModified > '$recentAlertCutoff'" -SCSession $scSession -ErrorAction SilentlyContinue | Where-Object {
        [string](Get-HcsObjectProperty -InputObject $_ -Name 'Name') -like '*Hyper-V Private Cloud*'
    } | Select-Object Id, Name, Severity, ResolutionState, LastModified)
Add-HcsCheck -List $checks -Category 'HealthAndAlerts' -Name 'Fault and recovery evidence' -Status 'Pending' `
    -Evidence "Captured $($recentAlerts.Count) matching recent alert(s); representative injected-fault and recovery proof is still required."

foreach ($pendingGate in @('Scale', 'UpgradeAndOverrides', 'Removal', 'DefaultManagementPackProtection')) {
    Add-HcsCheck -List $checks -Category $pendingGate -Name $pendingGate -Status 'Pending' -Evidence 'Requires the documented multi-phase representative lab procedure.'
}

$resolvedOutputPath = [IO.Path]::GetFullPath($OutputPath)
[IO.Directory]::CreateDirectory($resolvedOutputPath) | Out-Null
$sourceCommit = (& git -C (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path rev-parse HEAD 2>$null | Select-Object -First 1).ToString().Trim()
if ($sourceCommit -notmatch '^[0-9a-f]{40}$') { $sourceCommit = '0000000000000000000000000000000000000000' }
$snapshotPath = Join-Path $resolvedOutputPath 'management-group-snapshot.json'
$snapshot = [ordered]@{
    schemaVersion = '1.0'
    collectedUtc = [DateTimeOffset]::UtcNow.ToString('o')
    managementServer = $ManagementServer
    expectation = [IO.Path]::GetFileName($resolvedExpectationPath)
    productVersion = $ProductVersion
    publicKeyToken = $expectedToken
    sourceCommit = $sourceCommit
    checks = @($checks)
    managementPacks = @($managementPackEvidence)
    classes = @($classEvidence)
    workflows = $workflowEvidence
    recentDiagnosticTask = $diagnosticEvidence
    recentAlerts = $recentAlerts
}
$snapshot | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $snapshotPath -Encoding utf8NoBOM

$gateCategories = [ordered]@{
    PowerShellRuntime = @('PowerShellRuntime')
    CleanImport = @('CleanImport', 'WorkflowInventory')
    TopologyDiscovery = @('TopologyDiscovery')
    HealthAndAlerts = @('HealthAndAlerts')
    DistributedApplicationAndViews = @('DistributedApplicationAndViews')
    CapabilityIntegrations = @('CapabilityIntegrations')
    Scale = @('Scale')
    UpgradeAndOverrides = @('UpgradeAndOverrides')
    Removal = @('Removal')
    DefaultManagementPackProtection = @('DefaultManagementPackProtection')
}
$evidenceDraftPath = Join-Path $resolvedOutputPath 'release-evidence.draft.json'
$draftGates = foreach ($gate in $gateCategories.GetEnumerator()) {
    $passed = Test-HcsCategoryPassed -Checks @($checks) -Categories $gate.Value
    [ordered]@{ id = $gate.Key; status = $(if ($passed) { 'Passed' } else { 'Pending' }); evidenceLocation = $snapshotPath }
}
[ordered]@{
    schemaVersion = '1.0'
    productVersion = $ProductVersion
    sourceCommit = $sourceCommit
    approved = $false
    approvedBy = ''
    approvedUtc = ''
    gates = @($draftGates)
} | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $evidenceDraftPath -Encoding utf8NoBOM

$failed = @($checks | Where-Object status -eq 'Failed').Count
$pending = @($checks | Where-Object status -eq 'Pending').Count
Write-Host "Certification snapshot: $snapshotPath"
Write-Host "Unapproved evidence draft: $evidenceDraftPath"
Write-Host "Checks: passed=$(@($checks | Where-Object status -eq 'Passed').Count); failed=$failed; pending=$pending"
if ($failed -gt 0) { exit 1 }
