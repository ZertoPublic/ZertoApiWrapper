#Requires -Modules 'InvokeBuild'

. '.\ZertoApiWrapper.settings.ps1'
# import-module "$BuildRoot\ZertoApiWrapper\ZertoApiWrapper.psd1" -Verbose -Force

<# [CmdletBinding()]
param([switch]$Install,
    [string]$Configuration = (property Configuration Release))
$targetDir = "temp/$Configuration/ZertoApiWrapper" #>

task . Analyze, FileTests

<# Synopsis: Ensure platyPS is installed #>
task CheckPlatyPSInstalled {
    if ($null -eq (Get-Module -List platyPS)) {
        Install-Module -Scope CurrentUser -Repository PSGallery -Name platyPS
    }
}

<# Synopsis: Ensure Pester is installed #>
task CheckPesterInstalled {
    if ($null -eq (Get-Module -List Pester)) {
        Install-Module -Scope CurrentUser -Repository PSGallery -Name Pester
    }
}

<# Synopsis: Ensure PSScriptAnalyzer is installed #>
task CheckPSScriptAnalyzerInstalled {
    if ($null -eq (Get-Module -List PSScriptAnalyzer)) {
        Install-Module -Scope CurrentUser -Repository PSGallery -Name PSScriptAnalyzer
    }
}

<# Synopsis: Analyze ZertoApiWrapper functions for Code Violations #>
task Analyze CheckPSScriptAnalyzerInstalled, CheckPesterInstalled, CheckPlatyPSInstalled, {
    $scriptAnalyzerParams = @{
        Path        = "$BuildRoot\ZertoApiWrapper\"
        Severity    = @('Error', 'Warning')
        Recurse     = $true
        Verbose     = $false
        ExcludeRule = @('PSUseDeclaredVarsMoreThanAssignments', 'PSUseShouldProcessForStateChangingFunctions', 'PSUseToExportFieldsInManifest')
    }
    $saresults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings were found"
    }
}

task FileTests CheckPesterInstalled, {
    $testResultsFile = "$BuildRoot\Tests\Public\TestResults.xml"
    Invoke-Pester -Script "$BuildRoot\Tests\Public\ZertoApiWrapper.Tests.ps1" -OutputFile $testResultsFile -PassThru
}

$buildMamlParams = @{
    Inputs  = { Get-ChildItem docs\*.md }
    Outputs = ".\ZertoApiWrapper\Public\en-us\ZertoApiWrapper-help.xml"
}

task BuildMamlHelp CheckPlatyPSInstalled, {
    if (Test-Path $buildMamlParams.Outputs) {
        Remove-Item $buildMamlParams.Outputs
    }
    platyPS\New-ExternalHelp .\docs -Force -OutputPath $buildMamlParams.Outputs
}

task UpdateMarkdownHelp CheckPlatyPSInstalled, {
    remove-module ZertoApiWrapper -force -ErrorAction SilentlyContinue
    Import-Module .\ZertoApiWrapper\ZertoApiWrapper.psm1 -Force
    Update-MarkDownHelp -Path docs -AlphabeticParamsOrder
}
