#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {

        $ParameterTestCases = @(
            @{ParameterName = 'OutputFile'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'vpgName'; Type = 'String[]'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory)
            Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
        }

        it "<ParameterName> has <Validation> validation set" -TestCases $ParameterTestCases {
            param($ParameterName)
            $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
            $attrs.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
        }
    }

    Context "$global:function::Function Unit Tests" {
        
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
