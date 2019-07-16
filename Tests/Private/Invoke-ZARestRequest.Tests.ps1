#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    InModuleScope -ModuleName ZertoApiWrapper {

        Context "$global:function::Parameter Unit Tests" {

            it "have a mandatory string parameter for the URI Variable" {
                Get-Command Invoke-ZARestRequest | Should -HaveParameter uri -Mandatory -Type String
            }

            it "have a non-mandatory string parameter for the Method Variable, default to 'GET'" {
                Get-Command Invoke-ZARestRequest | Should -HaveParameter Method -Type String
                Get-Command Invoke-ZARestRequest | Should -HaveParameter Method -Not -Mandatory
                Get-Command Invoke-ZARestRequest | Should -HaveParameter Method -DefaultValue "GET"
            }

            it "have a non-mandatory string parameter for the Body variable" {
                Get-Command Invoke-ZARestRequest | Should -HaveParameter Body -Type String
                Get-Command Invoke-ZARestRequest | Should -HaveParameter Body -Not -Mandatory
            }

            it "have a non-mandatory string parameter for the contentType variable" {
                Get-Command Invoke-ZARestRequest | Should -HaveParameter contentType -Type String
                Get-Command Invoke-ZARestRequest | Should -HaveParameter contentType -Not -Mandatory
                Get-Command Invoke-ZARestRequest | Should -HaveParameter contentType -DefaultValue "application/json"
            }

            it "uri variable does not accecpt a null or empty variable" {
                { Invoke-ZARestRequest -uri $null } | Should Throw
                { Invoke-ZARestRequest -uri "" } | Should Throw
            }

            it "method variable only accecpts 'GET' 'DELETE' 'PUT' 'POST' values" {
                $parameterInfo = ( Get-Command Invoke-ZARestRequest ).Parameters['method']
                $parameterInfo.Attributes.Where{ $_ -is [ValidateSet] }.Count | Should -Be 1
                $validateSet = $parameterInfo.Attributes.Where{ $_ -is [ValidateSet] }
                $validateSet.ValidValues -contains 'GET' | Should -BeTrue
                $validateSet.ValidValues -contains 'PUT' | Should -BeTrue
                $validateSet.ValidValues -contains 'POST' | Should -BeTrue
                $validateSet.ValidValues -contains 'DELETE' | Should -BeTrue
                $validateSet.ValidValues.Count | Should -Be 4
            }

            it "body variable does not accecpt a null or empty variable" {
                { Invoke-ZARestRequest -uri "connect" -body $null } | Should Throw
                { Invoke-ZARestRequest -uri "connect" -body "" } | Should Throw
            }

            it "accecpt variable does not accecpt a null or empty variable" {
                { Invoke-ZARestRequest -uri "connect" -accecpt $null } | Should Throw
                { Invoke-ZARestRequest -uri "connect" -accecpt "" } | Should Throw
            }
        }

        Context "$global:function::Function Unit Tests" {

            Mock -ModuleName ZertoApiWrapper -CommandName Invoke-RestMethod {
                "Ran Command"
            }

            BeforeEach {
                Set-Variable -Name zaHeaders -Scope Script -Value (@{ "Accept" = "application/json" })
                Set-Variable -Name zaLastActionTime -Scope Script -Value $(Get-date).Ticks
            }

            it "runs when called" {
                Invoke-ZARestRequest -uri "myuri" | Should Be "Ran Command"
            }

            it "throws when the last action was over 60 minutes ago" {
                $script:zaLastActionTime = (get-date).AddMinutes(-61).Ticks
                { Invoke-ZARestRequest -uri "myuri" } | Should Throw
            }

            it "throws when the zaHeaders variable does not exits" {
                Remove-Variable -Name zaHeaders -Scope Script
                { Invoke-ZARestRequest -uri "myuri" } | Should Throw
            }

            it "throws when the zaLastActionTime variable does not exits" {
                Remove-Variable -Name zaLastActionTime -Scope Script
                { Invoke-ZARestRequest -uri "myuri" } | Should Throw
            }

            Assert-MockCalled -CommandName Invoke-RestMethod -ModuleName ZertoApiWrapper -Exactly 1
        }
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
