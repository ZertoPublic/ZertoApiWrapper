#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        It "Has a mandatory string array parameter for the settings file to import" {
            Get-Command $global:function | Should -HaveParameter settingsFile
            Get-Command $global:function | Should -HaveParameter settingsFile -Mandatory
            Get-Command $global:function | Should -HaveParameter settingsFile -Type String[]
        }

        It "Will not accecpt a Null or Empty string for the settings file" {
            $attrs = (Get-Command $global:function).Parameters['settingsFile'].Attributes
            $attrs.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
