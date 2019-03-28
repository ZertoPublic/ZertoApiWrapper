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
        ExcludeRule = @('PSUseDeclaredVarsMoreThanAssignments', 'PSUseShouldProcessForStateChangingFunctions')
    }
    $saresults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings were found"
    }
}

task FileTests CheckPesterInstalled, {
    Invoke-Pester "$BuildRoot\Tests\Public\ZertoApiWrapper.Tests.ps1" -Show Fails
}