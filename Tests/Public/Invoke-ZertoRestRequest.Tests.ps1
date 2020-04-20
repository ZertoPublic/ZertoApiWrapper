#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    InModuleScope -ModuleName ZertoApiWrapper {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-RestMethod {
            "Ran Command"
        }

        Context "$global:function::Parameter Unit Tests" {
            $thisCommand = Get-Command Invoke-ZertoRestRequest
            $ParameterNameTestCases = @(
                @{ParameterName = "uri"; Type = "String"; Mandatory = $true; DefaultValue = $null; TestName = "URI" }
                @{ParameterName = "method"; Type = "String"; Mandatory = $false; DefaultValue = 'GET'; TestName = "Method" }
                @{ParameterName = "body"; Type = "String"; Mandatory = $false; DefaultValue = $null; TestName = "Body" }
                @{ParameterName = "credential"; Type = "PSCredential"; Mandatory = $false; DefaultValue = $null; TestName = "Credential" }
                @{ParameterName = "returnHeaders"; Type = "Switch"; Mandatory = $false; DefaultValue = $null; TestName = "Return Headers" }
            )

            It "<TestName> parameter has the right Type, Default Value, and Mandatory Setting" -TestCases $ParameterNameTestCases {
                param($ParameterName, $Type, $DefaultValue, $Mandatory)
                if ($Mandatory) {
                    $thisCommand | Should -HaveParameter $ParameterName -Type $Type -Mandatory
                } else {
                    $thisCommand | Should -HaveParameter $ParameterName -Type $Type
                    $thisCommand | Should -HaveParameter $ParameterName -Not -Mandatory
                }
                if ($null -ne $DefaultValue) {
                    $thisCommand | Should -HaveParameter $ParameterName -DefaultValue $DefaultValue
                }
            }

            $ParameterValidationTestCases = @(
                @{ParameterName = "URI"; TestName = "URI" }
                @{ParameterName = "body"; TestName = "Body" }
            )

            It "<TestName> parameter cannot be null or empty" -TestCases $ParameterValidationTestCases {
                param($ParameterName)
                $thisParameter = $thisCommand.Parameters[$ParameterName]
                $thisParameter.Attributes.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
            }

            It "Method parameter can only be 'GET', 'POST', 'PUT', 'DELETE'" {
                $thisParameter = $thisCommand.Parameters['method']
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.Count | Should -Be 1
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'GET' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'PUT' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'POST' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues -contains 'DELETE' | Should -BeTrue
                $thisParameter.Attributes.Where{ $_ -is [ValidateSet] }.validValues.Count | Should -Be 4
            }
        }

        Context "$global:function::Function Unit Tests" {
            Mock -ModuleName ZertoApiWrapper -CommandName Invoke-RestMethod {
                "Ran Command"
            }

            BeforeEach {
                Set-Variable -Name zvmHeaders -Scope Script -Value (@{ "Accept" = "application/json" })
                Set-Variable -Name zvmLastAction -Scope Script -Value $(Get-Date).Ticks
                Set-Variable -Name zvmServer -Scope Script -Value "192.168.1.100"
                Set-Variable -Name zvmPort -Scope Script -Value 9669
            }

            It "runs when called" {
                Invoke-ZertoRestRequest -uri "MyUri" | Should -Be "Ran Command"
            }

            It "throws an error when zvmLastAction was more than 30 minutes ago" {
                Set-Variable -Name zvmLastAction -Scope Script -Value $(Get-Date).AddMinutes(-31).Ticks
                { Invoke-ZertoRestRequest -uri "MyUri" } | Should Throw "Authorization Token has Expired"
            }

            It "throws an error when the zvmServer variable does not exist" {
                Remove-Variable -Name zvmServer -Scope Script
                { Invoke-ZertoRestRequest -uri "MyUri" } | Should Throw "Zerto Connection does not Exist."
            }

            Assert-MockCalled -CommandName Invoke-RestMethod -ModuleName ZertoApiWrapper -Exactly 1
        }
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
