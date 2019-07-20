#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {

        $ParameterTestCases = @(
            @{ParameterName = 'alertId'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'entities'; Type = 'Switch'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'helpIdentifiers'; Type = 'Switch'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'levels'; Type = 'Switch'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'startDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'endDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'vpgIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'siteIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'zOrgIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'level'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'helpIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'isDismissed'; Type = 'bool'; Mandatory = $false; Validation = $null }
        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory, $Validation)
            Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
        }

        It "<ParameterName> parameter has correct validation setting"  -TestCases $ParameterTestCases {
            param($ParameterName, $Validation)
            Switch ($Validation) {
                'NotNullOrEmpty' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
                }

                $null {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.TypeId.Count | Should -Be 2
                }
            }
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global

