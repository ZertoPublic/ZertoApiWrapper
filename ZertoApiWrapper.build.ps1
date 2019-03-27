task . InstallDependencies, Analyze

task InstallDependencies {
    Install-Module Pester -Force
    Install-Module PSScriptAnalyzer -Force
}

task Analyze {
    $scriptAnalyzerParams = @{
        Path        = "$BuildRoot\ZertoApiWrapper\"
        Severity    = @('Error', 'Warning')
        Recurse     = $true
        Verbose     = $false
        ExcludeRule = 'PSUseDeclaredVarsMoreThanAssignments'
    }
    $saresults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings were found"
    }
}

task FileTests {
    Invoke-Pester "$BuildRoot\Tests\Public\ZertoApiWrapper.Tests.ps1"
}

task BuildPsd1 {
    $functionsToExportPath = "{0}\ZertoApiWrapper\Public\" -f $MyInvocation.MyCommand.PSPath
    $functionsToExport = (Get-ChildItem -Path $functionsToExportPath -File).name.Replace('.ps1', '')
    $functionsToExport
}
