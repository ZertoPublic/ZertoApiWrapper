#Requires -Modules Pester
#Region - Test Setup
$moduleFileName = "ZertoApiWrapper.psd1"
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace("Tests", "ZertoApiWrapper")
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file = Get-ChildItem "$here\$sut"
$modulePath = $here -replace "Public", ""
$moduleFile = Get-ChildItem "$modulePath\$moduleFileName"
Get-Module -Name ZertoApiWrapper | Remove-Module -Force
Import-Module $moduleFile -Force
#EndRegion

Describe $file.BaseName -Tag 'Unit' {

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    Context "$($file.BaseName)::Parameter Unit Tests" {
        It "has a mantatory string parameter for the output file" {
            Get-Command $file.BaseName | Should -HaveParameter OutputFile -Type String -Mandatory
        }

        It "has a non-mandatory string array parameter for vpgName(s) to export" {
            Get-Command $file.BaseName | Should -HaveParameter vpgName -Type String[]
            Get-Command $file.BaseName | Should -HaveParameter vpgName -Not -Mandatory
        }

        It "Output File does not take null or empty string" {
            { Export-ZertoVpg -outputFile "" } | Should -Throw
            { Export-ZertoVpg -outputFile $null } | Should -Throw
        }

        It "Vpg Name parameter does not take null or empty string" {
            { Export-ZertoVpg -outputFile ".\ExportedInfo.csv" -vpgName = "" } | Should -Throw
            { Export-ZertoVpg -outputFile ".\ExportedInfo.csv" -vpgName = $null } | Should -Throw
        }
    }
}
