#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    InModuleScope -ModuleName ZertoApiWrapper {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-RestMethod {
            "Ran Command"
        }

        Context "$global:function::Parameter Unit Tests" {
            $thisCommand = get-command Invoke-ZertoRestRequest
            it "has a mandatory string parameter for the uri" {
                $thisCommand | Should -HaveParameter uri -Mandatory -Type String
            }

            it "uri parameter cannot be null or empty" {
                $thisParameter = $thisCommand.Parameters['uri']
                $thisParameter.Attributes.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should Be 1
            }

            it "has a non-mandatory string parameter for the method" {
                $thisCommand | Should -HaveParameter method -Not -Mandatory
                $thisCommand | Should -HaveParameter method -Type String
            }

            it "method parameter can only be 'GET', 'POST', 'PUT', 'DELETE'" {
                $thisParameter = $thisCommand.Parameters['method']
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.Count | Should Be 1
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'GET' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'PUT' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'POST' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'DELETE' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues.Count | Should -Be 4
            }

            it "has a non-mandatory string parameter for the apiVersion, default 'v1'" {
                $thisCommand | Should -HaveParameter apiVersion -Not -Mandatory
                $thisCommand | Should -HaveParameter apiVersion -Type String
                $thisCommand | Should -HaveParameter apiVersion -DefaultValue "v1"
            }

            it "apiVersion parameter cannot be null or empty" {
                $thisParameter = $thisCommand.Parameters['apiVersion']
                $thisParameter.Attributes.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should Be 1
            }

            it "has a non-mandatory string parameter for the body" {
                $thisCommand | Should -HaveParameter body -Not -Mandatory
                $thisCommand | Should -HaveParameter body -Type String
            }

            it "apiVersion parameter cannot be null or empty" {
                $thisParameter = $thisCommand.Parameters['body']
                $thisParameter.Attributes.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should Be 1
            }

            it "has a non-mandatory string parameter for the contentType" {
                $thisCommand | Should -HaveParameter contentType -Not -Mandatory
                $thisCommand | Should -HaveParameter contentType -Type String
                $thisCommand | Should -HaveParameter contentType -DefaultValue "application/json"
            }

            it "apiVersion parameter cannot be null or empty" {
                $thisParameter = $thisCommand.Parameters['contentType']
                $thisParameter.Attributes.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should Be 1
            }

            it "has a non-mandatory PSCredential parameter for the credential" {
                $thisCommand | Should -HaveParameter credential -Type PSCredential
                $thisCommand | Should -HaveParameter credential -not -mandatory
            }

            it "has a non-mandatory switch parameter to ReturnHeaders" {
                $thisCommand | Should -HaveParameter returnHeaders -Type Switch
                $thisCommand | Should -HaveParameter returnHeaders -Not -Mandatory
            }

        }

        Context "$global:function::Function Unit Tests" {
            Mock -ModuleName ZertoApiWrapper -CommandName Invoke-RestMethod {
                "Ran Command"
            }

            BeforeEach {
                Set-Variable -Name zvmHeaders -Scope Script -Value (@{ "Accept" = "application/json" })
                Set-Variable -Name zvmLastAction -Scope Script -Value $(Get-date).Ticks
                Set-Variable -Name zvmServer -Scope Script -Value "192.168.1.100"
                Set-Variable -Name zvmPort -Scope Script -Value 9669
            }

            it "runs when called" {
                Invoke-ZertoRestRequest -uri "MyUri" | Should -Be "Ran Command"
            }

            it "throws an error when zvmLastAction was more than 30 minutes ago" {
                Set-Variable -Name zvmLastAction -Scope Script -Value $(Get-date).AddMinutes(-31).Ticks
                { Invoke-ZertoRestRequest -uri "MyUri" } | Should Throw
            }

            it "throws an error when the zvmServer variable does not exist" {
                Remove-Variable -Name zvmServer -Scope Script
                { Invoke-ZertoRestRequest -uri "MyUri" } | Should Throw
            }

            Assert-MockCalled -CommandName Invoke-RestMethod -ModuleName ZertoApiWrapper -Exactly 1
        }
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
