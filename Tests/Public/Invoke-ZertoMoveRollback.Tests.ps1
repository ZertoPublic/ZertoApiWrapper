#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {

        It "$global:function should have exactly 14 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 14
        }

        It "has a mandatory string parameter for the vpgName" {
            Get-Command $global:function | Should -HaveParameter vpgName
            Get-Command $global:function | Should -HaveParameter vpgName -Type string[]
            Get-Command $global:function | Should -HaveParameter vpgName -Mandatory
        }
    }
    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
