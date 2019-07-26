#Requires -Modules 'InvokeBuild'

$version = "{0}.{1}" -f $(Get-Content .\version.txt), $(Get-Date -format 'yyyyMMdd')

#Define the default task
task . CreateArtifacts

#Region - Helper Functions
function ImportSourceModule() {
    If (Get-Module -Name ZertoApiWrapper) {
        Remove-Module -Name ZertoApiWrapper -Force -ErrorAction Stop
    }
    Import-Module "$BuildRoot\ZertoApiWrapper\ZertoApiWrapper.psd1" -ErrorAction Stop
}

function ImportBuiltModule() {
    If (Get-Module -Name ZertoApiWrapper) {
        Remove-Module -Name ZertoApiWrapper -Force -ErrorAction Stop
    }
    Import-Module "$BuildRoot\temp\ZertoApiWrapper.psd1" -ErrorAction Stop
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
#EndRegion

#Region - PSSA Tasks
<# Synopsis: Analyze ZertoApiWrapper functions for Code Violations #>
task AnalyzeSourceFiles CheckPSScriptAnalyzerInstalled, {
    $scriptAnalyzerParams = @{
        Path        = "$BuildRoot\ZertoApiWrapper\"
        Severity    = @('Error', 'Warning')
        Recurse     = $true
        Verbose     = $false
        ExcludeRule = @('PSUseToExportFieldsInManifest', 'PSUseBOMForUnicodeEncodedFile', 'PSUseSingularNouns')
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
        ExcludeRule = @('PSUseSingularNouns', 'PSUseBOMForUnicodeEncodedFile')
    }
    $saresults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings were found"
    }
}
#EndRegion

#Region - Clean Operations
task CleanTemp {
    if (-not $(Test-Path "$BuildRoot\temp")) {
        New-Item -Path $BuildRoot -Name "temp" -ItemType "Directory"
    }
    Remove-Item -Recurse -Path "$BuildRoot\temp\*"
}

task CleanPublish {
    if ($(Test-Path "$BuildRoot\publish")) {
        Remove-Item -Recurse -Path "$BuildRoot\publish\*"
    }
}
#EndRegion

#Region - Pester Tests
task SourceFileTests CheckPesterInstalled, {
    ImportSourceModule
    $testResultsFile = "$BuildRoot\Tests\SourceTestResults.xml"
    $script:results = Invoke-Pester -Script "$BuildRoot" -Tag Unit -OutputFile $testResultsFile -PassThru -Show Fails
    $FailureMessage = '{0} Unit test(s) failed. Aborting build' -f $results.FailedCount
    Assert ($results.FailedCount -eq 0) $FailureMessage
}

task BuiltFileTests CheckPesterInstalled, {
    ImportBuiltModule
    $testResultsFile = "$BuildRoot\Tests\BuiltTestResults.xml"
    $script:results = Invoke-Pester -Script "$BuildRoot" -Tag Unit -OutputFile $testResultsFile -PassThru -Show Fails
    $FailureMessage = '{0} Unit test(s) failed. Aborting build' -f $results.FailedCount
    Assert ($results.FailedCount -eq 0) $FailureMessage
}
#EndRegion

#Region - Build Help System
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
    ImportSourceModule
    Update-MarkdownHelpModule -Path docs -AlphabeticParamsOrder
}
#EndRegion

#Region - Build Module Files
task CreatePsd1ForRelease CleanTemp, {
    $functionsToExport = Get-ChildItem -Path 'ZertoApiWrapper\Public\*.ps1' | ForEach-Object { $_.BaseName }
    $releaseNotes = "# {0}{1}" -f $version, $(Get-Content .\RELEASENOTES.md -Raw)

    $ManifestParams = @{
        Path              = "$BuildRoot\temp\ZertoApiWrapper.psd1"
        RootModule        = 'ZertoApiWrapper.psm1'
        ModuleVersion     = $version
        GUID              = '4c0b9e17-141b-4dd5-8549-fb21cccaa325'
        Author            = 'Wes Carroll'
        CompanyName       = 'Zerto'
        Copyright         = '(c) {0} Wes Carroll. All rights reserved.' -f $(Get-Date -format 'yyyy')
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
    $psm1Path = "$BuildRoot\temp\ZertoApiWrapper.psm1"
    $lines = '#------------------------------------------------------------#'
    $Private = @( Get-ChildItem -Path $BuildRoot\ZertoApiWrapper\Private\*.ps1 -ErrorAction Stop )
    $Public = @( Get-ChildItem -Path $BuildRoot\ZertoApiWrapper\Public\*.ps1 -ErrorAction Stop )
    <# $functionCount = 0
     $exportString = ""
    foreach ($file in $Public) {
        if ($functionCount -eq 0) {
            $functionCount++
            $exportString = "{0}" -f $file.BaseName
        } else {
            $functionCount++
            $exportString = "{0}, {1}" -f $exportString, $file.BaseName
        }
    } #>
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
    # Add-Content -Path $psm1Path -Value $emptyLine
    # Add-Content -Path $psm1Path -Value "Export-ModuleMember -Function $exportString"
}
#EndRegion

#Region - Artifacts \ Publish
# Full Build Process - No Publishing
task CreateArtifacts CleanPublish, CleanTemp, AnalyzeSourceFiles, SourceFileTests, AnalyzeBuiltFiles, BuiltFileTests, BuildMamlHelp, {
    if (-not $(Test-Path "$BuildRoot\publish")) {
        New-Item -Path $BuildRoot -Name "publish" -ItemType Directory
    }
    Compress-Archive -Path .\temp\* -DestinationPath .\publish\ZertoApiWrapper.zip
    ImportBuiltModule
    (Get-Module ZertoApiWrapper).ReleaseNotes | Add-Content .\publish\release-notes.txt
    (Get-Module ZertoApiWrapper).Version.ToString() | Add-Content .\publish\release-version.txt
    Copy-Item "$BuildRoot\ZertoApiWrapper.build.ps1" "$BuildRoot\publish\ZertoApiWrapper.build.ps1"
    Copy-Item "$BuildRoot\ZertoApiWrapper.Depend.psd1" "$BuildRoot\publish\ZertoApiWrapper.Depend.psd1"
    Copy-Item "$BuildRoot\build.ps1" "$BuildRoot\publish\build.ps1"
}
#EndRegion
