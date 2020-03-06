#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    InModuleScope -ModuleName ZertoApiWrapper {

        Context "$global:function::Parameter Unit Tests" {

            $testCases = @(
                @{ParameterName = 'uri'; Type = 'String'; Mandatory = $true; TestName = 'URI' }
                @{ParameterName = 'method'; Type = 'String'; Mandatory = $false; TestName = 'Method' }
                @{ParameterName = 'body'; Type = 'String'; Mandatory = $false; TestName = 'Body' }
            )

            It "Parameter present and Type test for: <TestName> " -TestCases $testCases {
                param($parameterName, $type, $Mandatory)
                Get-Command $global:function | Should -HaveParameter $parameterName -Type $type
                if ($Mandatory) {
                    Get-Command $global:function | Should -HaveParameter $parameterName -Mandatory
                } else {
                    Get-Command $global:function | Should -HaveParameter $parameterName -Not -Mandatory
                }
            }

            It "Method parameter default is 'GET'" {
                Get-Command $global:function | Should -HaveParameter Method -DefaultValue "GET"
            }

            $NotNullOrEmptyTests = @(
                @{ParameterName = 'uri'; TestName = 'Uri' }
                @{ParameterName = 'body'; TestName = 'Body' }
            )

            It "<TestName> parameter does not accecpt a null or empty value" -TestCases $NotNullOrEmptyTests {
                param($parameterName)
                $parameterInfo = ( Get-Command Invoke-ZARestRequest ).Parameters[$parameterName]
                $parameterInfo.Attributes.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
            }

            It "method parametert only accecpts 'GET' 'DELETE' 'PUT' 'POST' values" {
                $parameterInfo = ( Get-Command Invoke-ZARestRequest ).Parameters['method']
                $parameterInfo.Attributes.Where{ $_ -is [ValidateSet] }.Count | Should -Be 1
                $validateSet = $parameterInfo.Attributes.Where{ $_ -is [ValidateSet] }
                $validateSet.ValidValues -contains 'GET' | Should -BeTrue
                $validateSet.ValidValues -contains 'PUT' | Should -BeTrue
                $validateSet.ValidValues -contains 'POST' | Should -BeTrue
                $validateSet.ValidValues -contains 'DELETE' | Should -BeTrue
                $validateSet.ValidValues.Count | Should -Be 4
            }
        }

        Context "$global:function::Function Unit Tests" {

            Mock -ModuleName ZertoApiWrapper -CommandName Invoke-RestMethod {
                "Ran Command"
            }

            BeforeEach {
                Set-Variable -Name zaHeaders -Scope Script -Value (@{ "Accept" = "application/json" })
                Set-Variable -Name zaLastActionTime -Scope Script -Value $(Get-Date).Ticks
            }

            It "runs when called" {
                Invoke-ZARestRequest -uri "myuri" | Should Be "Ran Command"
            }

            It "throws when the last action was over 60 minutes ago" {
                $script:zaLastActionTime = (Get-Date).AddMinutes(-61).Ticks
                { Invoke-ZARestRequest -uri "myuri" } | Should Throw "Authorization Token has Expired."
            }

            It "throws when the zaHeaders variable does not exits" {
                Remove-Variable -Name zaHeaders -Scope Script
                { Invoke-ZARestRequest -uri "myuri" } | Should Throw "Zerto Analytics Connection does not Exist."
            }

            It "throws when the zaLastActionTime variable does not exist" {
                Remove-Variable -Name zaLastActionTime -Scope Script
                { Invoke-ZARestRequest -uri "myuri" } | Should Throw "Zerto Analytics Connection does not Exist."
            }

            Assert-MockCalled -CommandName Invoke-RestMethod -ModuleName ZertoApiWrapper -Exactly 1
        }
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
