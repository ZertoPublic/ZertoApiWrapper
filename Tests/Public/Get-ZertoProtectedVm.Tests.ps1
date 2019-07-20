#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {

    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
