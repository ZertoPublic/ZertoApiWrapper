#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 28 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 28
        }

        $ParameterTestCases = @(
            @{ParameterName = 'startDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'endDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'vpg'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'vpgIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'eventType'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'siteName'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'siteIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'zOrgIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'entityType'; Type = 'String'; Mandatory = $false; Validation = 'Set' }
            @{ParameterName = 'userName'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'category'; Type = 'String'; Mandatory = $false; Validation = 'Set' }
            @{ParameterName = 'eventCategory'; Type = 'String'; Mandatory = $false; Validation = 'Set' }
            @{ParameterName = 'alertIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'eventId'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'categories'; Type = 'Switch'; Mandatory = $true; Validation = $null }
            @{ParameterName = 'entities'; Type = 'Switch'; Mandatory = $true; Validation = $null }
            @{ParameterName = 'types'; Type = 'Switch'; Mandatory = $true; Validation = $null }
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

                'Set' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateSet] }.Count | Should -Be 1
                }

                $null {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.TypeId.Count | Should -Be 2
                }

                default {
                    $true | Should -Be $false -Because "No Validation Selected. Review test cases"
                }
            }
        }

        It "entityType parameter only accecpts 4 different values" {
            (Get-Command $global:function).Parameters['entityType'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues.Count | Should -Be 4
        }

        It "entityType parameter accecpts 'VPG' as a Value" {
            (Get-Command $global:function).Parameters['entityType'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'VPG'
        }

        It "entityType parameter accecpts 'VRA' as a Value" {
            (Get-Command $global:function).Parameters['entityType'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'VRA'
        }

        It "entityType parameter accecpts 'Unknown' as a Value" {
            (Get-Command $global:function).Parameters['entityType'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'Unknown'
        }

        It "entityType parameter accecpts 'Site' as a Value" {
            (Get-Command $global:function).Parameters['entityType'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'Site'
        }

        It "category parameter only accecpts 3 different values" {
            (Get-Command $global:function).Parameters['category'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues.Count | Should -Be 3
        }

        It "category parameter accecpts 'All' as a Value" {
            (Get-Command $global:function).Parameters['category'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'All'
        }

        It "category parameter accecpts 'events' as a Value" {
            (Get-Command $global:function).Parameters['category'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'events'
        }

        It "category parameter accecpts 'alerts' as a Value" {
            (Get-Command $global:function).Parameters['category'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'alerts'
        }

        It "eventCategory parameter only accecpts 3 different values" {
            (Get-Command $global:function).Parameters['eventCategory'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues.Count | Should -Be 3
        }

        It "eventCategory parameter accecpts 'All' as a Value" {
            (Get-Command $global:function).Parameters['eventCategory'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'All'
        }

        It "eventCategory parameter accecpts 'events' as a Value" {
            (Get-Command $global:function).Parameters['eventCategory'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'events'
        }

        It "eventCategory parameter accecpts 'alerts' as a Value" {
            (Get-Command $global:function).Parameters['eventCategory'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'alerts'
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
