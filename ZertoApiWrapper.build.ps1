#Requires -Modules 'InvokeBuild'

$version = "{0}" -f $(Get-Content .\version.txt)
$moduleOutPath = "{0}\publish\ZertoApiWrapper" -f $BuildRoot

#Define the default task
task . build

#Region - Helper Functions
function ImportSourceModule {
    If (Get-Module -Name ZertoApiWrapper) {
        Remove-Module -Name ZertoApiWrapper -Force -ErrorAction Stop
    }
    Import-Module "$BuildRoot\ZertoApiWrapper\ZertoApiWrapper.psd1" -ErrorAction Stop
}

function ImportBuiltModule {
    If (Get-Module -Name ZertoApiWrapper) {
        Remove-Module -Name ZertoApiWrapper -Force -ErrorAction Stop
    }
    Import-Module ("{0}\ZertoApiWrapper.psd1" -f $moduleOutPath) -ErrorAction Stop
}
#EndRegion

#Region - Module Checks
<# Synopsis: Ensure platyPS is installed #>
task CheckPlatyPSInstalled {
    if ($null -eq (Get-Module -List platyPS)) {
        Install-Module -Scope CurrentUser -Repository PSGallery -Name platyPS
    }
}

<# Synopsis: Ensure Pester is installed #>
task CheckPesterInstalled {
    Get-Module -Name Pester | Remove-Module -Force
    if ($null -eq (Get-Module -List Pester)) {
        Install-Module -Scope CurrentUser -Repository PSGallery -Name Pester -MaximumVersion 4.99
    }
    Import-Module -Name Pester -MaximumVersion 4.99 -Force
}

<# Synopsis: Ensure PSScriptAnalyzer is installed #>
task CheckPSScriptAnalyzerInstalled {
    if ($null -eq (Get-Module -List PSScriptAnalyzer)) {
        Install-Module -Scope CurrentUser -Repository PSGallery -Name PSScriptAnalyzer
    }
}
#EndRegion

#Region - PSSA Tasks
<# Synopsis: Analyze ZertoApiWrapper functions for Code Violations #>
task AnalyzeSourceFiles CheckPSScriptAnalyzerInstalled, {
    $scriptAnalyzerParams = @{
        Path        = "$BuildRoot\ZertoApiWrapper\"
        Severity    = @('Error', 'Warning')
        Recurse     = $true
        Verbose     = $false
        ExcludeRule = @('PSUseToExportFieldsInManifest', 'PSUseBOMForUnicodeEncodedFile', 'PSUseSingularNouns', 'PSReviewUnusedParameter')
    }
    $saresults = Invoke-ScriptAnalyzer @scriptAnalyzerParams
    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings were found"
    }
}

task AnalyzeBuiltFiles CheckPSScriptAnalyzerInstalled, CreatePsm1ForRelease, {
    $scriptAnalyzerParams = @{
        Path        = $moduleOutPath
        Severity    = @('Error', 'Warning')
        Recurse     = $true
        Verbose     = $false
        ExcludeRule = @('PSUseSingularNouns', 'PSUseBOMForUnicodeEncodedFile', 'PSReviewUnusedParameter')
    }
    $saresults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings were found"
    }
}
#EndRegion

#Region - Clean Operations
task CleanPublish {
    if ($(Test-Path "$BuildRoot\publish")) {
        Remove-Item -Recurse -Path "$BuildRoot\publish\*"
    } else {
        New-Item -Path $BuildRoot -Name "publish" -ItemType Directory
    }
    New-Item -Path $moduleOutPath -ItemType "Directory"
}
#EndRegion

#Region - Pester Tests
#task SourceFileTests CheckPesterInstalled, {
#    ImportSourceModule
#    $testResultsFile = "$BuildRoot\Tests\SourceTestResults.xml"
#    $script:results = Invoke-Pester -Script "$BuildRoot" -Tag Unit -OutputFile $testResultsFile -PassThru -Show Fails
#    $FailureMessage = '{0} Unit test(s) failed. Aborting build' -f $results.FailedCount
#    Assert ($results.FailedCount -eq 0) $FailureMessage
#}

#task BuiltFileTests CreatePsm1ForRelease, CheckPesterInstalled, {
#    ImportBuiltModule
#    $testResultsFile = "$BuildRoot\Tests\BuiltTestResults.xml"
#    $script:results = Invoke-Pester -Script "$BuildRoot" -Tag Unit -OutputFile $testResultsFile -PassThru -Show Failed
#    $FailureMessage = '{0} Unit test(s) failed. Aborting build' -f $results.FailedCount
#    Assert ($results.FailedCount -eq 0) $FailureMessage
#}
#EndRegion

#Region - Build Help System
$buildMamlParams = @{
    Inputs  = { Get-ChildItem docs\*.md }
    Outputs = "{0}\en-us\ZertoApiWrapper-help.xml" -f $moduleOutPath
}

task BuildMamlHelp CheckPlatyPSInstalled, {
    if (Test-Path $buildMamlParams.Outputs) {
        Remove-Item $buildMamlParams.Outputs
    }
    platyPS\New-ExternalHelp .\docs -Force -OutputPath $buildMamlParams.Outputs
}

task UpdateMarkdownHelp quickBuild, CheckPlatyPSInstalled, {
    ImportBuiltModule
    Update-MarkdownHelpModule -Path docs -AlphabeticParamsOrder
}
#EndRegion

#Region - Build Module Files
task CreatePsd1ForRelease CleanPublish, {
    $functionsToExport = Get-ChildItem -Path 'ZertoApiWrapper\Public\*.ps1' | ForEach-Object { $_.BaseName }
    $releaseNotes = "Please review the [Release Notes](https://github.com/ZertoPublic/ZertoApiWrapper/releases/tag/{0}) on GitHub." -f $version

    $ManifestParams = @{
        Path              = "{0}\ZertoApiWrapper.psd1" -f $moduleOutPath
        RootModule        = 'ZertoApiWrapper.psm1'
        ModuleVersion     = $version
        GUID              = '4c0b9e17-141b-4dd5-8549-fb21cccaa325'
        Author            = 'Wes Carroll'
        CompanyName       = 'Zerto'
        Copyright         = '(c) {0} Wes Carroll. All rights reserved.' -f $(Get-Date -Format 'yyyy')
        Description       = 'Windows PowerShell and PowerShell Core API Wrapper Module for Zerto Virtual Manager'
        PowerShellVersion = '5.1.0'
        ProjectUri        = 'https://github.com/ZertoPublic/ZertoApiWrapper'
        LicenseUri        = 'https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/LICENSE'
        Tags              = @("Zerto", "Automation")
        FunctionsToExport = $functionsToExport
        CmdletsToExport   = @()
        VariablesToExport = @()
        AliasesToExport   = @()
        ReleaseNotes      = $releaseNotes
    }
    New-ModuleManifest @ManifestParams
}

task CreatePsm1ForRelease CreatePsd1ForRelease, {
    $emptyLine = ""
    $psm1Path = "{0}\ZertoApiWrapper.psm1" -f $moduleOutPath
    $lines = '#------------------------------------------------------------#'
    $Private = @( Get-ChildItem -Path $BuildRoot\ZertoApiWrapper\Private\*.ps1 -ErrorAction Stop )
    $Public = @( Get-ChildItem -Path $BuildRoot\ZertoApiWrapper\Public\*.ps1 -ErrorAction Stop )
    Add-Content -Path $psm1Path -Value $lines -Encoding 'utf8'
    Add-Content -Path $psm1Path -Value "#---------------------Private Functions----------------------#"  -Encoding 'utf8'
    Add-Content -Path $psm1Path -Value $lines -Encoding 'utf8'
    Add-Content -Path $psm1Path -Value $emptyLine -Encoding 'utf8'
    foreach ($file in $private) {
        Add-Content -Path $psm1Path -Value $(Get-Content -Path $file.Fullname -Raw) -Encoding 'utf8'
        Add-Content -Path $psm1Path -Value $emptyLine -Encoding 'utf8'
    }
    Add-Content -Path $psm1Path -Value $lines -Encoding 'utf8'
    Add-Content -Path $psm1Path -Value "#----------------------Public Functions----------------------#" -Encoding 'utf8'
    Add-Content -Path $psm1Path -Value $lines -Encoding 'utf8'
    Add-Content -Path $psm1Path -Value $emptyLine -Encoding 'utf8'
    foreach ($file in $public) {
        Add-Content -Path $psm1Path -Value $(Get-Content -Path $file.Fullname -Raw) -Encoding 'utf8'
        Add-Content -Path $psm1Path -Value $emptyLine -Encoding 'utf8'
    }
}
#EndRegion

#Region - Artifacts \ Publish
# Full Build Process - No Publishing
task CreateArtifacts CleanPublish, AnalyzeBuiltFiles, BuiltFileTests, BuildMamlHelp, {
    Compress-Archive -Path $moduleOutPath -DestinationPath .\publish\ZertoApiWrapper.zip
    $MyMatches = Select-String -Path "$BuildRoot\CHANGELOG.md" "^##\s\["
    $data = Get-Content "$BuildRoot\CHANGELOG.md"
    $range = ($MyMatches[0].LineNumber - 1)..($MyMatches[1].LineNumber - 3)
    foreach ($i in $range) {
        Add-Content -Path "$BuildRoot\publish\ReleaseNotes.md" -Value ($data[$i]).replace("## ", "# ") -Encoding utf8
    }
}
#EndRegion

task build CleanPublish, CreatePsm1ForRelease, AnalyzeBuiltFiles, BuiltFileTests, CreateArtifacts
task quickBuild CleanPublish, CreatePsm1ForRelease, AnalyzeBuiltFiles, {
    Get-Module -Name ZertoApiWrapper | Remove-Module -Force
    ImportBuiltModule
}
task release build, {
    Publish-Module -Path $moduleOutPath -NuGetApiKey "1234" -WhatIf
}
