#Requires -Modules 'InvokeBuild'

. '.\ZertoApiWrapper.settings.ps1'
# import-module "$BuildRoot\ZertoApiWrapper\ZertoApiWrapper.psd1" -Verbose -Force

<# [CmdletBinding()]
param([switch]$Install,
    [string]$Configuration = (property Configuration Release))

$targetDir = "temp/$Configuration/ZertoApiWrapper" #>

task . Analyze

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

$buildMamlParams = @{
    Inputs  = { Get-ChildItem docs/*.md }
    Outputs = "$targetDir/en-us/ZertoApiWrapper-help.xml"
}

task BuildMamlHelp @buildMamlParams {
    platyPS\New-ExternalHelp .\docs -Force -OutputPath $buildMamlParams.Outputs
}

task FileTests CheckPesterInstalled, {
    Invoke-Pester "$BuildRoot\Tests\Public\ZertoApiWrapper.Tests.ps1" -Show Fails
}

task UpdateModuleFunctions {
    $functionsToExportPath = "$BuildRoot\ZertoApiWrapper\Public\"
    Update-ModuleManifest -Path "$BuildRoot\ZertoApiWrapper\ZertoApiWrapper.psd1" -FunctionsToExport $(Get-ChildItem -Path $functionsToExportPath -File).name.Replace('.ps1', '')
}

task UpdateVersion {
    try {
        $moduleManifestFile = "$BuildRoot\ZertoApiWrapper\ZertoApiWrapper.psd1"
        $manifestContent = Get-Content $moduleManifestFile -Raw
        [version]$version = [regex]::matches($manifestContent, "ModuleVersion\s=\s\'(?<version>(\d+\.)?(\d+\.)?(\*|\d+))") | ForEach-Object {$_.groups['version'].value}
        $newVersion = "{0}.{1}.{2}" -f $version.Major, $version.Minor, ($version.Build + 1)

        $replacements = @{
            "ModuleVersion = '.*'" = "ModuleVersion = '$newVersion'"
        }

        $replacements.GetEnumerator() | ForEach-Object {
            $manifestContent = $manifestContent -replace $_.Key, $_.Value
        }

        $manifestContent | Set-Content -Path "$moduleManifestFile"
    } catch {
        Write-Error -Message $_.Exception.Message
        $host.SetShouldExit($LastExitCode)
    }
}
