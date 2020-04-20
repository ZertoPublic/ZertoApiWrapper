#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$($global:function)::Parameter Unit Tests" {
        It "Has a parameter for the Required Credentials that is Mandatory" {
            Get-Command $global:function | Should -HaveParameter credential -Mandatory -Type PSCredential
        }
    }

    Context "$($global:function)::Function Unit Tests" {

        InModuleScope -ModuleName ZertoApiWrapper {
            Mock -CommandName Invoke-ZARestRequest {
                return (Get-Content "$global:here\Mocks\ZAToken.json"-Raw | ConvertFrom-Json)
            }

            $password = 'NotARealPassword' | ConvertTo-SecureString -AsPlainText -Force
            $cred = New-Object pscredential('NotARealUser', $password)

            $results = Connect-ZertoAnalytics -credential $cred

            It "Creates a Script Level Hashtable Variable for the ZertoAnalytics Headers" {
                $script:zaHeaders | Should -BeOfType Hashtable
            }

            It "the ZertoAnalytics Headers variable contains 2 items" {
                $script:zaHeaders.keys | Should -HaveCount 2
            }

            It "the ZertoAnalytics Headers variable has an 'Accept' key" {
                $script:zaHeaders.keys | Should -Contain 'Accept'
            }

            It "thh ZertoAnalytics headers variable 'Accept' key should be JSON" {
                $script:zaHeaders['Accept'] | Should -match 'application/json'
            }

            It "the ZertoAnalytics Headers variable has an 'Authorization' key" {
                $script:zaHeaders.keys | Should -Contain 'Authorization'
            }

            It "the ZertoAnalytics Headers variable 'Authorization' key should start with 'Bearer'" {
                $script:zaHeaders['Authorization'] | Should -Match '^Bearer '
            }

            It "Creates a Script Level Variable for the LastActionTime" {
                $script:zaLastActionTime | Should -BeOfType Long
            }

            It "LastActionTime Variable should be in the past" {
                $script:zaLastActionTime | Should -BeLessThan (Get-Date).Ticks
            }

            It "Returns Header Information" {
                $results | Should -not -BeNullOrEmpty
                $results['Authorization'] | Should -MatchExactly 'Bearer N074r34l70k3n'
                $results['Accept'] | Should -Match 'application/json'
            }
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZARestRequest -Exactly 1
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
