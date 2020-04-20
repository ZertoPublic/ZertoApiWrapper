#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 13 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 13
        }

        It "Supports 'SupportsShouldProcess'" {
            Get-Command $global:function | Should -HaveParameter WhatIf
            Get-Command $global:function | Should -HaveParameter Confirm
            $script:ScriptBlock | Should -match 'SupportsShouldProcess'
            $script:ScriptBlock | Should -match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "$global:function::Parameter Functional Tests" {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
            return (Get-Content -Raw "$global:here\Mocks\PairingToken.json" | ConvertFrom-Json)
        }

        It "Returns a Token" {
            $Token = New-ZertoPairingToken
            $Token | Should -Not -Be $Null
            $Token.Token | Should -Be "TH15ISN0T4R3AL70KEN"
        }

        It "Returns a ExpirationDate" {
            $Token = New-ZertoPairingToken
            $Token | Should -Not -Be $Null
            $Token.UtcExpirationDate | Should -Be "10/09/2019 12:55 PM"
        }

        It "Does not return a taskId if '-whatif' is used" {
            $results = New-ZertoPairingToken -WhatIf
            $results | Should -BeNullOrEmpty
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -Exactly 2

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
