#Requires -Modules Pester
$moduleFileName = "ZertoApiWrapper.psd1"
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace("Tests", "ZertoApiWrapper")
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file = Get-ChildItem "$here\$sut"
$modulePath = $here -replace "Public", ""
$moduleFile = Get-ChildItem "$modulePath\$moduleFileName"
Get-Module -Name ZertoApiWrapper | Remove-Module -Force
Import-Module $moduleFile -Force

Describe $file.BaseName -Tag 'Unit' {

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    it "has a mantatory string parameter for the output path" {
        Get-Command $file.BaseName | Should -HaveParameter outputPath -Mandatory -Type String
    }

    it "has a non-mandatory string array parameter for vpgName(s) to export" {
        Get-Command $file.BaseName | Should -HaveParameter vpgName -Type String[] -Mandatory
    }

    it "has a non-mandatory switch parameter to export all vpgs" {
        Get-Command $file.BaseName | Should -HaveParameter allVpgs -Type Switch -Mandatory
    }

    it "No defined vpgName or AllVpg switch should throw an error" {
        {Export-ZertoVpg -outputPath "."} | Should -Throw
    }
}