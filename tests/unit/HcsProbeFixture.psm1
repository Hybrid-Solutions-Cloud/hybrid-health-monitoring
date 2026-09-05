#Requires -Version 7.0
<#
    Probe fixture harness.

    Runs an embedded probe script in a child pwsh with MOM.ScriptAPI replaced by a capture shim and
    with platform cmdlets stubbed, then returns the property bag it produced. This lets a probe be
    exercised for an environment this build host does not have -- a cluster, a VMM server, SAN
    storage, Network ATC, a reachable switch -- so a probe that reports Good on a failure, or an
    alerting state on an absent capability, is caught here rather than in a management group.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:CaptureShim = @'
$script:HcsEvents = [System.Collections.Generic.List[string]]::new()
class HcsBag {
    [string]$Kind = 'Bag'
    [string]$TypeId = ''
    [hashtable]$Values = @{}
    [System.Collections.Generic.List[object]]$Instances = [System.Collections.Generic.List[object]]::new()
    [object]$Source
    [object]$Target
    [void] AddValue([string]$name, $value) { $this.Values[$name] = $value }
    [void] AddProperty([string]$name, $value) { $this.Values[$name] = $value }
    # A discovery data object is also a bag here, so it must answer the discovery surface too.
    [object] CreateClassInstance([string]$id) { $item = [HcsBag]::new(); $item.Kind = 'Class'; $item.TypeId = $id; return $item }
    [object] CreateRelationshipInstance([string]$id) { $item = [HcsBag]::new(); $item.Kind = 'Relationship'; $item.TypeId = $id; return $item }
    [void] AddInstance($instance) { $this.Instances.Add($instance) }
}
class HcsApi {
    [System.Collections.Generic.List[object]]$Bags = [System.Collections.Generic.List[object]]::new()
    [object] CreatePropertyBag() { return [HcsBag]::new() }
    [object] CreateDiscoveryData([int]$a, [string]$b, [string]$c) { return [HcsBag]::new() }
    [object] CreateClassInstance([string]$a) { return [HcsBag]::new() }
    [object] CreateRelationshipInstance([string]$a) { return [HcsBag]::new() }
    [void] AddInstance($bag) { $this.Bags.Add($bag) }
    [void] Return($bag) { $this.Bags.Add($bag) }
    [void] AddItem($bag) { $this.Bags.Add($bag) }
    [void] ReturnItems() { }
    [void] LogScriptEvent([string]$s, [int]$id, [int]$severity, [string]$message) { $script:HcsEvents.Add(('{0}|{1}' -f $id, $message)) }
}
# Intercept ONLY the SCOM script API. Everything else -- TcpClient, StringBuilder, generic lists --
# must reach the real New-Object, or the probe fails inside the harness and the fixture reports a
# product defect that does not exist.
function New-Object {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)][string]$TypeName,
        [string]$ComObject,
        [Parameter(ValueFromRemainingArguments = $true)]$Rest
    )
    if ($ComObject -eq 'MOM.ScriptAPI') { return [HcsApi]::new() }
    $splat = @{}
    if ($PSBoundParameters.ContainsKey('TypeName')) { $splat['TypeName'] = $TypeName }
    if ($PSBoundParameters.ContainsKey('ComObject')) { $splat['ComObject'] = $ComObject }
    if ($null -ne $Rest -and @($Rest).Count -gt 0) { $splat['ArgumentList'] = $Rest }
    return Microsoft.PowerShell.Utility\New-Object @splat
}

# Discovery templates reference $MPElement, which SCOM substitutes at runtime. Give it a value so a
# discovery script can execute under the fixture.
$MPElement = 'HcsFixtureMPElement'
'@

$script:CaptureTail = @'

$__captured = @{}
foreach ($__bag in $api.Bags) {
    foreach ($__key in $__bag.Values.Keys) { $__captured[[string]$__key] = $__bag.Values[$__key] }
}
$__captured['HcsEventLog'] = ($script:HcsEvents -join ' ;; ')
$__captured['HcsBagCount'] = $api.Bags.Count
# Discovery scripts return one discovery-data object holding many instances; count those too so a
# fixture can assert how many objects a discovery actually created.
$__discovered = 0
foreach ($__bag in $api.Bags) { $__discovered += @($__bag.Instances).Count }
$__captured['HcsInstanceCount'] = $__discovered
$__captured['HcsEmptyClassInstanceCount'] = @($api.Bags | ForEach-Object { $_.Instances } | Where-Object { $_.Kind -eq 'Class' -and $_.Values.Count -eq 0 }).Count
Write-Output ('<<<HCSFIXTURE>>>' + ($__captured | ConvertTo-Json -Depth 4 -Compress))
'@

function Invoke-HcsFixtureProbe {
    <#
    .SYNOPSIS
        Executes a probe template with stubs and returns its property bag as an object.
    .OUTPUTS
        PSCustomObject of bag values, plus HcsEventLog and HcsBagCount. Throws if the probe produced
        no bag, so a broken harness can never be mistaken for a passing assertion.
    #>
    param(
        [Parameter(Mandatory)][string]$TemplatePath,
        [Parameter(Mandatory)][hashtable]$Parameters,
        [string]$Stubs = '',
        [int]$TimeoutSeconds = 120
    )

    if (-not (Test-Path -LiteralPath $TemplatePath)) { throw "Probe template not found: $TemplatePath" }

    $body = [IO.File]::ReadAllText($TemplatePath)
    $body = [regex]::Replace($body, '(?m)^#Requires[^\r\n]*\r?\n', '')
    # Values are injected after the param block, so Mandatory would prompt or fail binding. The
    # attribute is removed from the fixture copy only; the shipped template is untouched.
    $body = [regex]::Replace($body, '\[Parameter\(Mandatory\s*=?\s*\$?\w*\)\]', '')

    # param() must remain the first statement, so the shim and stubs are injected immediately after
    # the param block rather than prepended.
    $tokens = $null
    $errors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseInput($body, [ref]$tokens, [ref]$errors)
    if (@($errors).Count -gt 0) { throw "Probe template does not parse: $(@($errors)[0].Message)" }
    $insertAt = if ($null -ne $ast.ParamBlock) { $ast.ParamBlock.Extent.EndOffset } else { 0 }

    # Parameters are assigned after the param block rather than passed on the command line: pwsh -File
    # splits a value containing commas into an array, which silently mangles seed lists like
    # "LEAF-11=10.0.0.1,LEAF-12=10.0.0.2" into a single joined entry.
    $assignments = ($Parameters.GetEnumerator() | ForEach-Object {
            '${0} = ''{1}''' -f $_.Key, ([string]$_.Value).Replace("'", "''")
        }) -join "`r`n"

    $composed = $body.Substring(0, $insertAt) + "`r`n" + $assignments + "`r`n" + $script:CaptureShim +
        "`r`n" + $Stubs + "`r`n" + $body.Substring($insertAt) + $script:CaptureTail

    $work = Join-Path ([IO.Path]::GetTempPath()) ('hcs-fx-' + [guid]::NewGuid().ToString('N') + '.ps1')
    [IO.File]::WriteAllText($work, $composed)

    $arguments = [System.Collections.Generic.List[string]]::new()
    $arguments.Add('-NoProfile'); $arguments.Add('-NonInteractive')
    $arguments.Add('-ExecutionPolicy'); $arguments.Add('Bypass')
    $arguments.Add('-File'); $arguments.Add($work)

    try {
        $output = & pwsh @arguments 2>&1
        $line = @($output) | Where-Object { "$_" -like '*<<<HCSFIXTURE>>>*' } | Select-Object -Last 1
        if ($null -eq $line) {
            throw "Probe produced no property bag. Output: $((@($output) | Select-Object -Last 5) -join ' | ')"
        }
        $json = ([string]$line -split '<<<HCSFIXTURE>>>', 2)[1]
        return ($json | ConvertFrom-Json)
    }
    finally {
        Remove-Item -LiteralPath $work -Force -ErrorAction SilentlyContinue
    }
}

Export-ModuleMember -Function Invoke-HcsFixtureProbe
