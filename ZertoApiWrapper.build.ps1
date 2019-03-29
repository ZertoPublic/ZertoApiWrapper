#Requires -Modules 'InvokeBuild'

. '.\ZertoApiWrapper.settings.ps1'
# import-module "$BuildRoot\ZertoApiWrapper\ZertoApiWrapper.psd1" -Verbose -Force

<# [CmdletBinding()]
param([switch]$Install,
    [string]$Configuration = (property Configuration Release))
$targetDir = "temp/$Configuration/ZertoApiWrapper" #>

$versionMajor = '0'
$versionMinor = '1'
$versionBuild = "{0}" -f $(get-date -format 'yyyyMMdd')

task . AnalyzeSourceFiles, CreateModule

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
task AnalyzeSourceFiles CheckPSScriptAnalyzerInstalled, {
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

task AnalyzeBuiltFiles CheckPSScriptAnalyzerInstalled, CreatePsm1ForRelease, {
    $scriptAnalyzerParams = @{
        Path        = "$BuildRoot\temp\"
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
    $testResultsFile = "$BuildRoot\Tests\TestResults.xml"
    $script:results = Invoke-Pester -Script "$BuildRoot" -Tag Unit -OutputFile $testResultsFile -PassThru
    $FailureMessage = '{0} Unit test(s) failed. Aborting build' -f $results.FailedCount
    assert ($results.FailedCount -eq 0) $FailureMessage
}

$buildMamlParams = @{
    Inputs  = { Get-ChildItem docs\*.md }
    Outputs = "$BuildRoot\temp\en-us\ZertoApiWrapper-help.xml"
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

task CreatePsd1ForRelease CleanTemp, {
    $functionsToExport = Get-ChildItem -Path 'ZertoApiWrapper\Public\*.ps1' | ForEach-Object { $_.BaseName }
    $ManifestParams = @{
        Path              = "$BuildRoot\temp\ZertoApiWrapper.psd1"
        RootModule        = 'ZertoApiWrapper.psm1'
        ModuleVersion     = '{0}.{1}.{2}' -f $versionMajor, $versionMinor, $versionBuild
        GUID              = '4c0b9e17-141b-4dd5-8549-fb21cccaa325'
        Author            = 'Wes Carroll'
        CompanyName       = 'Zerto'
        Copyright         = '(c) {0} Wes Carroll. All rights reserved.' -f $(Get-Date -format 'yyyy')
        Description       = 'PowerShell Core Wrapper Module for Zerto Virtual Manager API'
        PowerShellVersion = '6.0.0'
        ProjectUri        = 'https://github.com/wcarroll/ZertoApiWrapper'
        LicenseUri        = 'https://github.com/wcarroll/ZertoApiWrapper/blob/master/LICENSE'
        Tags              = @("Zerto", "Automation")
        FunctionsToExport = $functionsToExport
        CmdletsToExport   = @()
        VariablesToExport = @()
        AliasesToExport   = @()
    }
    New-ModuleManifest @ManifestParams
}

task CleanTemp {
    if (-not $(Test-Path "$BuildRoot\temp")) {
        New-Item -Path $BuildRoot -Name "temp" -ItemType "Directory"
    }
    Remove-Item -Recurse -Path "$BuildRoot\temp\*"
}

task CreatePsm1ForRelease CreatePsd1ForRelease, {
    $emptyLine = ""
    $psm1Path = "$BuildRoot\temp\ZertoApiWrapper.psm1"
    $lines = '#------------------------------------------------------------#'
    $Public = @( Get-ChildItem -Path $BuildRoot\ZertoApiWrapper\Public\*.ps1 -ErrorAction SilentlyContinue )
    $functionCount = 0
    $exportString = ""
    foreach ($file in $Public) {
        if ($functionCount -eq 0) {
            $functionCount++
            $exportString = "{0}" -f $file.BaseName
        } else {
            $functionCount++
            $exportString = "{0}, {1}" -f $exportString, $file.BaseName
        }
    }
    $export = "Export-ModuleMember -Function $exportString"
    $Private = @( Get-ChildItem -Path $BuildRoot\ZertoApiWrapper\Private\*.ps1 -ErrorAction SilentlyContinue )
    Add-Content -Path $psm1Path -Value $lines
    Add-Content -Path $psm1Path -Value "#---------------------Private Functions----------------------#"
    Add-Content -Path $psm1Path -Value $lines
    Add-Content -Path $psm1Path -Value $emptyLine
    foreach ($file in $private) {
        Add-Content -Path $psm1Path -Value $(Get-Content -Path $file.Fullname -Raw)
        Add-Content -Path $psm1Path -Value $emptyLine
    }
    Add-Content -Path $psm1Path -Value $lines
    Add-Content -Path $psm1Path -Value "#----------------------Public Functions----------------------#"
    Add-Content -Path $psm1Path -Value $lines
    Add-Content -Path $psm1Path -Value $emptyLine
    foreach ($file in $public) {
        Add-Content -Path $psm1Path -Value $(Get-Content -Path $file.Fullname -Raw)
        Add-Content -Path $psm1Path -Value $emptyLine
    }
    Add-Content -Path $psm1Path -Value $emptyLine
    Add-Content -Path $psm1Path -Value "Export-ModuleMember -Function $exportString"
}

task CreateModule CleanTemp, FileTests, AnalyzeBuiltFiles, BuildMamlHelp, {

}
