#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {

        It "has a non-mandatory string parameter for the datacenterIdentifier" {
            Get-Command $global:function | Should -HaveParameter datastoreIdentifier
            Get-Command $global:function | Should -HaveParameter datastoreIdentifier -Type String[]
        }

        It "datastoreIdentifier parameter does not take null or empty values" {
            (Get-Command $global:function).Parameters['datastoreIdentifier'].Attributes.Where{ $_ -is [ValidateNotNullOrEmpty] }.count | Should Be 1
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
