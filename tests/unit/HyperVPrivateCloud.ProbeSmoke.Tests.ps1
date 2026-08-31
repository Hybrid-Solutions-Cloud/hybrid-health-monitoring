#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
<#
.SYNOPSIS
    Executes every Hyper-V Private Cloud probe and discovery script the way the SCOM agent does.

.DESCRIPTION
    The 2026-08-31 review (ADR 0053) found that the published 1.0.0.0 could never have monitored a real
    host: every failure happened before a script's first statement (a .NET type literal for the COM
    MOM.ScriptAPI, [bool] parameters that pwsh -File cannot bind, a non-existent VMHost property under
    StrictMode) and none of it was visible to the XML, XPath or VSAE layers. This suite closes that gap.

    For every embedded script in the built packs it takes each distinct <Arguments> string, substitutes
    representative values for $Config/...$, $Target/...$ and $MPElement...$ tokens (honouring each
    parameter's type and ValidateSet), replaces the COM script API with an in-process shim that records
    what the script did, and launches pwsh.exe -File exactly as the Library modules do.

    The contract asserted is environment-independent: the process must get past parameter binding and
    API construction, must never write anything but DataItem XML to stdout, and must either return a
    DataItem (exit 0) or fail through the script's own catch path with LogScriptEvent (never a raw
    PowerShell error). Feature-absent paths (no Hyper-V role, no VMM module) are therefore exercised on
    any build machine; a lab host exercises the full paths with the same test.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Describe 'Hyper-V Private Cloud Monitoring probe smoke test' {
    # ---- Discovery phase: build the packs and enumerate every (script, arguments) pair so each becomes its own test.
    $discoveryRepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
    $discoveryBuildTool = Join-Path $discoveryRepoRoot 'src/hyper-v/scom-mp/tools/Build-HyperVPrivateCloudManagementPacks.ps1'
    $discoveryBuilt = Join-Path ([System.IO.Path]::GetTempPath()) ("hcs-hyperv-v2-smoke-built-" + [guid]::NewGuid().ToString('N'))
    & $discoveryBuildTool -Version '2.0.0.0' -PublicKeyToken '0123456789abcdef' -OutputPath $discoveryBuilt | Out-Null
    $discoveryCases = [System.Collections.Generic.List[object]]::new()
    $discoverySeen = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    foreach ($file in Get-ChildItem -LiteralPath $discoveryBuilt -Filter '*.xml') {
        [xml]$pack = Get-Content -LiteralPath $file.FullName -Raw
        foreach ($bodyNode in $pack.SelectNodes('//ScriptBody')) {
            $module = $bodyNode.ParentNode
            $scriptName = [string]$module.SelectSingleNode('ScriptName').InnerText
            $arguments = [string]$module.SelectSingleNode('Arguments').InnerText
            $body = [string]$bodyNode.InnerText
            $typeNode = $module
            while ($null -ne $typeNode -and $typeNode.LocalName -notin @('DataSourceModuleType', 'ProbeActionModuleType', 'WriteActionModuleType', 'Rule', 'UnitMonitor', 'Discovery', 'Task')) { $typeNode = $typeNode.ParentNode }
            $configTypes = @{}
            if ($null -ne $typeNode) {
                foreach ($el in $typeNode.SelectNodes(".//*[local-name()='element' and @name]")) { $configTypes[[string]$el.name] = [string]$el.type }
            }
            $key = "$($file.Name)|$scriptName|$arguments"
            if (-not $discoverySeen.Add($key)) { continue }
            $discoveryCases.Add([pscustomobject]@{ Pack = $file.BaseName; ScriptName = $scriptName; Body = $body; Arguments = $arguments; ConfigTypes = $configTypes })
        }
    }
    Remove-Item -LiteralPath $discoveryBuilt -Recurse -Force -ErrorAction SilentlyContinue
    $discoverySummary = @(@{ CaseCount = $discoveryCases.Count; ScriptCount = @($discoveryCases.ScriptName | Sort-Object -Unique).Count })
    $discoveryData = @($discoveryCases | ForEach-Object { @{ Pack = $_.Pack; ScriptName = $_.ScriptName; Case = $_ } })
    if ($env:HCS_SMOKE_LIMIT) { $discoveryData = @($discoveryData | Select-Object -First ([int]$env:HCS_SMOKE_LIMIT)) }

    BeforeAll {
        $script:Work = Join-Path ([System.IO.Path]::GetTempPath()) ("hcs-hyperv-v2-smoke-" + [guid]::NewGuid().ToString('N'))
        $script:Runs = Join-Path $script:Work 'runs'
        New-Item -ItemType Directory -Path $script:Runs -Force | Out-Null

        # ---- Shim for the COM script API. Injected after the script's param block. ----------------------
        $script:Shim = @'
# ---- HCS smoke-test shim: replaces New-Object -ComObject 'MOM.ScriptAPI' -------------------------------
$script:HcsSmokeMarker = $env:HCS_SMOKE_MARKER
function New-HcsSmokeBag {
    $bag = [pscustomobject]@{ Values = [ordered]@{} }
    $bag | Add-Member -MemberType ScriptMethod -Name AddValue -Value { param($Name, $Value) $this.Values[[string]$Name] = $Value } -Force
    $bag | Add-Member -MemberType ScriptMethod -Name ToXml -Value {
        $sb = [System.Text.StringBuilder]::new('<DataItem type="System.PropertyBagData" time="' + [DateTime]::UtcNow.ToString('o') + '" sourceHealthServiceId="00000000-0000-0000-0000-000000000000">')
        foreach ($k in $this.Values.Keys) { [void]$sb.Append('<Property Name="' + [System.Security.SecurityElement]::Escape([string]$k) + '" VariantType="8">' + [System.Security.SecurityElement]::Escape([string]$this.Values[$k]) + '</Property>') }
        [void]$sb.Append('</DataItem>'); return $sb.ToString() } -Force
    return $bag
}
function New-HcsSmokeDiscoveryData {
    $data = [pscustomobject]@{ Instances = [System.Collections.Generic.List[object]]::new() }
    $data | Add-Member -MemberType ScriptMethod -Name CreateClassInstance -Value { param($TypeId)
        $i = [pscustomobject]@{ TypeId = $TypeId; Properties = [ordered]@{} }
        $i | Add-Member -MemberType ScriptMethod -Name AddProperty -Value { param($Name, $Value) $this.Properties[[string]$Name] = [string]$Value } -Force
        return $i } -Force
    $data | Add-Member -MemberType ScriptMethod -Name CreateRelationshipInstance -Value { param($TypeId)
        return [pscustomobject]@{ TypeId = $TypeId; Source = $null; Target = $null } } -Force
    $data | Add-Member -MemberType ScriptMethod -Name AddInstance -Value { param($Instance) $this.Instances.Add($Instance) } -Force
    $data | Add-Member -MemberType ScriptMethod -Name ToXml -Value {
        return '<DataItem type="System.DiscoveryData" time="' + [DateTime]::UtcNow.ToString('o') + '" sourceHealthServiceId="00000000-0000-0000-0000-000000000000"><DiscoveryType>0</DiscoveryType><Instances count="' + $this.Instances.Count + '" /></DataItem>' } -Force
    return $data
}
function New-HcsSmokeApi {
    Add-Content -LiteralPath $script:HcsSmokeMarker -Value 'API constructed'
    $api = [pscustomobject]@{ Items = [System.Collections.Generic.List[object]]::new() }
    $api | Add-Member -MemberType ScriptMethod -Name CreatePropertyBag -Value { New-HcsSmokeBag } -Force
    $api | Add-Member -MemberType ScriptMethod -Name CreateDiscoveryData -Value { param($a, $b, $c) New-HcsSmokeDiscoveryData } -Force
    $api | Add-Member -MemberType ScriptMethod -Name LogScriptEvent -Value { param($Name, $Id, $Severity, $Text)
        Add-Content -LiteralPath $script:HcsSmokeMarker -Value ("LogScriptEvent {0} {1} {2}: {3}" -f $Name, $Id, $Severity, ([string]$Text -replace '\r?\n', ' ')) } -Force
    $api | Add-Member -MemberType ScriptMethod -Name Return -Value { param($Item) [Console]::Out.WriteLine($Item.ToXml()) } -Force
    $api | Add-Member -MemberType ScriptMethod -Name AddItem -Value { param($Item) $this.Items.Add($Item) } -Force
    $api | Add-Member -MemberType ScriptMethod -Name ReturnItems -Value { foreach ($i in $this.Items) { [Console]::Out.WriteLine($i.ToXml()) }; if ($this.Items.Count -eq 0) { [Console]::Out.WriteLine('<DataItem type="System.PropertyBagData" />') } } -Force
    return $api
}
function New-Object {
    [CmdletBinding(DefaultParameterSetName = 'Net')]
    param(
        [Parameter(ParameterSetName = 'Net', Position = 0)][string]$TypeName,
        [Parameter(ParameterSetName = 'Com')][string]$ComObject,
        [Parameter(ParameterSetName = 'Net', Position = 1)][object[]]$ArgumentList,
        [Parameter()][hashtable]$Property
    )
    if ($PSCmdlet.ParameterSetName -eq 'Com') {
        if ($ComObject -eq 'MOM.ScriptAPI') { return New-HcsSmokeApi }
        return Microsoft.PowerShell.Utility\New-Object -ComObject $ComObject
    }
    if ($null -ne $ArgumentList) { return Microsoft.PowerShell.Utility\New-Object -TypeName $TypeName -ArgumentList $ArgumentList }
    return Microsoft.PowerShell.Utility\New-Object -TypeName $TypeName
}
# ---- end shim -------------------------------------------------------------------------------------------
'@

        # ---- Representative argument values, honouring the script's own parameter contract --------------------
        function Get-HcsParameterContract {
            param([string]$Body)
            $tokens = $null; $errors = $null
            $ast = [System.Management.Automation.Language.Parser]::ParseInput($Body, [ref]$tokens, [ref]$errors)
            $contract = @{}
            if ($null -eq $ast.ParamBlock) { return $contract }
            foreach ($p in $ast.ParamBlock.Parameters) {
                $name = $p.Name.VariablePath.UserPath
                $validateSet = @()
                foreach ($attr in $p.Attributes) {
                    if ($attr -is [System.Management.Automation.Language.AttributeAst] -and $attr.TypeName.Name -eq 'ValidateSet') {
                        $validateSet = @($attr.PositionalArguments | ForEach-Object { $_.Value })
                    }
                }
                $typeName = ''
                foreach ($attr in $p.Attributes) { if ($attr -is [System.Management.Automation.Language.TypeConstraintAst]) { $typeName = $attr.TypeName.Name } }
                $contract[$name] = [pscustomobject]@{ Type = $typeName; ValidateSet = $validateSet }
            }
            return $contract
        }

        function Resolve-HcsArguments {
            param([string]$Arguments, [hashtable]$ConfigTypes, [hashtable]$Contract)
            $resolved = $Arguments
            $resolved = [regex]::Replace($resolved, '\$MPElement\$', { param($m) [guid]::NewGuid().ToString() })
            $resolved = [regex]::Replace($resolved, '\$MPElement\[[^\]]*\]\$', { param($m) 'HyperVPrivateCloud.Smoke.Element' })
            $resolved = [regex]::Replace($resolved, '\$Target/[^$]*\$', { param($m) 'SMOKE-TARGET' })
            $resolved = [regex]::Replace($resolved, '\$Config/([A-Za-z0-9_]+)\$', {
                    param($m)
                    $name = $m.Groups[1].Value
                    $type = if ($ConfigTypes.ContainsKey($name)) { $ConfigTypes[$name] } else { 'xsd:string' }
                    if ($Contract.ContainsKey($name) -and $Contract[$name].ValidateSet.Count -gt 0) { return [string]$Contract[$name].ValidateSet[0] }
                    switch -Regex ($type) {
                        'integer|int|double|decimal' { if ($name -match 'Interval') { return '300' } elseif ($name -match 'Timeout') { return '120' } else { return '2' } }
                        'boolean' { return 'false' }
                        default {
                            if ($name -eq 'ComputerName') { return $env:COMPUTERNAME }
                            if ($name -match 'BoundaryId') { return 'host:' + $env:COMPUTERNAME.ToLowerInvariant() }
                            if ($name -match 'Id$') { return [guid]::NewGuid().ToString() }
                            return 'SmokeValue'
                        }
                    }
                })
            return $resolved
        }

        function Invoke-HcsProbeSmoke {
            param([pscustomobject]$Case)
            $runId = [guid]::NewGuid().ToString('N')
            $dir = Join-Path $script:Runs $runId
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            # Insert the shim after the top-level param block (or after #Requires when there is none).
            $body = $Case.Body
            $tokens = $null; $errors = $null
            $ast = [System.Management.Automation.Language.Parser]::ParseInput($body, [ref]$tokens, [ref]$errors)
            $insertAt = if ($null -ne $ast.ParamBlock) { $ast.ParamBlock.Extent.EndOffset } else { ([regex]::Match($body, '(?m)^#Requires[^\r\n]*\r?\n')).Index + ([regex]::Match($body, '(?m)^#Requires[^\r\n]*\r?\n')).Length }
            $wrapped = $body.Substring(0, $insertAt) + "`r`n" + $script:Shim + "`r`n" + $body.Substring($insertAt)
            $scriptPath = Join-Path $dir $Case.ScriptName
            [System.IO.File]::WriteAllText($scriptPath, $wrapped, [System.Text.UTF8Encoding]::new($true))
            $marker = Join-Path $dir 'marker.txt'
            $contract = Get-HcsParameterContract -Body $Case.Body
            $arguments = Resolve-HcsArguments -Arguments $Case.Arguments -ConfigTypes $Case.ConfigTypes -Contract $contract
            $stdout = Join-Path $dir 'stdout.txt'; $stderr = Join-Path $dir 'stderr.txt'
            $env:HCS_SMOKE_MARKER = $marker
            $commandLine = "-NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File `"$scriptPath`" $arguments"
            $process = Start-Process -FilePath (Get-Command pwsh).Source -ArgumentList $commandLine -Wait -PassThru -NoNewWindow -RedirectStandardOutput $stdout -RedirectStandardError $stderr
            return [pscustomobject]@{
                ExitCode = $process.ExitCode
                StdOut = (Get-Content -LiteralPath $stdout -Raw -ErrorAction SilentlyContinue)
                StdErr = (Get-Content -LiteralPath $stderr -Raw -ErrorAction SilentlyContinue)
                Marker = (Get-Content -LiteralPath $marker -Raw -ErrorAction SilentlyContinue)
                Arguments = $arguments
            }
        }
    }

    AfterAll {
        if (Test-Path -LiteralPath $script:Work) { Remove-Item -LiteralPath $script:Work -Recurse -Force -ErrorAction SilentlyContinue }
    }

    It 'collects every embedded script with its argument variants' -ForEach $discoverySummary {
        $CaseCount | Should -BeGreaterThan 25
        $ScriptCount | Should -BeGreaterThan 20
    }

    It 'runs <Pack> / <ScriptName> under pwsh -File with its real Arguments' -ForEach $discoveryData {
        $result = Invoke-HcsProbeSmoke -Case $Case
        $result | Should -Not -BeNullOrEmpty -Because 'the probe runner must return a result object'
        $stderrText = "$($result.StdErr)"
        $markerText = "$($result.Marker)"
        $context = "pack=$Pack script=$ScriptName args=[$($result.Arguments)] exit=$($result.ExitCode) stderr=[$($stderrText.Trim())] marker=[$($markerText.Trim())]"

        if ($Case.Body -notmatch 'MOM\.ScriptAPI') {
            # Text-output task (no property bag): it must simply run to completion and print something.
            $result.ExitCode | Should -Be 0 -Because "a task script must complete: $context"
            "$($result.StdOut)".Trim().Length | Should -BeGreaterThan 0 -Because "a task must print its output: $context"
            return
        }

        # 1. The process got past parameter binding and constructed the script API (this is where 1.0.0.0 died).
        $markerText | Should -Match 'API constructed' -Because "the script must reach its first statement: $context"

        # 2. stdout carries nothing but DataItem XML (warnings or objects on stdout break the property-bag parse).
        $out = "$($result.StdOut)".Trim()
        if ($out.Length -gt 0) { $out | Should -Match '^<DataItem' -Because "stdout must start with a DataItem: $context" }

        # 3. Either a DataItem came back, or the script failed through its own catch path and logged the reason.
        if ($result.ExitCode -eq 0) {
            $out | Should -Match '<DataItem' -Because "a successful run returns a DataItem: $context"
        }
        else {
            $markerText | Should -Match 'LogScriptEvent' -Because "a failing run must log through the script API, not die on a raw PowerShell error: $context"
            $stderrText | Should -Not -Match 'Cannot process argument transformation|Unable to find type|is not recognized as a name of a cmdlet' -Because "never a binding or type-resolution failure: $context"
        }
    }
}
