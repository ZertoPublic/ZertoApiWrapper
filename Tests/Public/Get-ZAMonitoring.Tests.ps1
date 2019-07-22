#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        it "$global:function should have exactly 12 parameters defined" {
            (get-command $global:function).Parameters.Count | Should -Be 12
        }

        it "$global:function has a non-mandatory string parameter for the zOrgIdentifier" {
            Get-Command $global:function | Should -HaveParameter zOrgIdentifier -Type String
            Get-Command $global:function | Should -HaveParameter zOrgIdentifier -not -Mandatory
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
