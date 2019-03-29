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
    Context "Basic Features" {

        Mock -ModuleName ZertoApiWrapper Invoke-ZertoRestRequest {
            return "9a49f42e-2bbd-4bf8-b571-77908a2e5e98.928a122b-1763-4664-ad37-cc00bb883f2f"
        }

        It "is valid Powershell (Has no script errors)" {
            $contents = Get-Content -Path $file -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
            $errors | Should -HaveCount 0
        }

        it "Should be return a string value" {
            $results = Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort '9081'
            $results | should not benullorempty
            $results.gettype().name | should -be "String"
        }

        it "Should not take a non-int as a port" {
            {Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort 'string'} | should -Throw
        }

        it "Should not take a non-ip address as a 'TargetHost'" {
            {Add-ZertoPeerSite -targetHost 'MyZVMHost' -targetPort '9081'} | should -Throw
            {Add-ZertoPeerSite -targetHost '192.168.1.266' -targetPort '9081'} | should -Throw
            {Add-ZertoPeerSite -targetHost '192.168.1' -targetPort '9081'} | should -Throw
        }

        it "Should not require a target port to be defined" {
            Add-ZertoPeerSite -targetHost '192.168.1.100'
        }

        it "Should support '-whatif'" {
            {Add-ZertoPeerSite -targetHost '192.168.1.100' -WhatIf| out-null} | Should -Not -Throw
        }
    }
}

