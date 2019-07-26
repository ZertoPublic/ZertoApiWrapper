#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 12 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 12
        }

        It "Has a non-mandatory switch parameter for the pairing Statuses" {
            Get-Command $global:function | Should -HaveParameter pairingstatuses
            Get-Command $global:function | Should -HaveParameter pairingstatuses -Type switch
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
