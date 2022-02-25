#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Mock -ModuleName ZertoApiWrapper Invoke-ZertoRestRequest {
        Get-Content $global:here\Mocks\TaskId.txt
    }

    Mock -ModuleName ZertoApiWrapper Get-ZertoVra -ParameterFilter { $vraIdentifier -in @("MyVraIdentifier", "PasswordVraIdentifier") } {
        Get-Content $global:here\Mocks\GetSingleVra.json -Raw | ConvertFrom-Json
    }

    Mock -ModuleName ZertoApiWrapper Get-ZertoVra -ParameterFilter { $vraIdentifier -eq "DoesNotExist" } {
        $null
    }

    Mock -ModuleName ZertoApiWrapper Get-ZertoVra -ParameterFilter { $vraIdentifier -eq "DhcpVraIdentifier" } {
        Get-Content $global:here\Mocks\GetDhcpVra.json -Raw | ConvertFrom-Json
    }

    Context "$($global:function)::Parameter Unit Tests" {

        $ParameterTestCases = @(
            @{ParameterName = 'vraIdentifier'; Type = 'String'; Mandatory = $true }
            @{ParameterName = 'groupName'; Type = 'String'; Mandatory = $false }
            @{ParameterName = 'vraIpAddress'; Type = 'String'; Mandatory = $false }
            @{ParameterName = 'defaultGateway'; Type = 'String'; Mandatory = $false }
            @{ParameterName = 'subnetMask'; Type = 'String'; Mandatory = $false }
            @{ParameterName = 'HostRootPassword'; Type = 'securestring'; Mandatory = $false }
        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory)
            Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
        }

        $StringTestCases = @(
            @{ ParameterName = 'vraIdentifier' }
            @{ ParameterName = 'groupName' }
        )

        It "<ParameterName> validates against null or empty values" -TestCases $StringTestCases {
            param($ParameterName)
            $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
            $attrs.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
        }

        $IpAddrTestCases = @(
            @{ParameterName = 'vraIpAddress' }
            @{ParameterName = 'defaultGateway' }
            @{ParameterName = 'subnetMask' }
        )

        It "<ParameterName> validates string for a valid IP Address" -TestCases $IpAddrTestCases {
            param($ParameterName)
            $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
            $attrs.Where{ $_ -is [ValidateScript] }.Count | Should -Be 1
            $attrs.Where{ $_ -is [ValidateScript] }.ScriptBlock | Should -Match '\$_ \-match \[IPAddress\]\$_'
        }

        It "Supports 'SupportsShouldProcess'" {
            Get-Command $global:function | Should -HaveParameter WhatIf
            Get-Command $global:function | Should -HaveParameter Confirm
            (Get-Command $global:function).ScriptBlock | Should -Match 'SupportsShouldProcess'
            (Get-Command $global:function).ScriptBlock | Should -Match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "$($global:function)::Function Unit Tests" {

        It "Returns a task id string" {
            $results = Edit-ZertoVra -vraIdentifier "MyVraIdentifier" -groupName "MyGroup"
            $results | Should not benullorempty
            $results | Should -BeOfType "String"
            $results | Should -BeExactly "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }

        It "Throws an error when the VPG does not exist" {
            { Edit-ZertoVra -vraIdentifier "DoesNotExist" -groupName "MyNewGroup" } | Should Throw "VRA with Identifier:"
        }

        It "Runs when passed static IP information" {
            Edit-ZertoVra -vraIdentifier "MyVraIdentifier" -vraIpAddress "192.168.1.250" -defaultGateway "192.168.1.254" -subnetMask "255.255.255.0"
        }

        It "Processes a VRA with a DHCP address" {
            Edit-ZertoVra -vraIdentifier "DhcpVraIdentifier" -groupName "MyNewGroup" | Should -BeExactly "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }

        It "Runs with root password provided" {
            $SecurePassword = 'NotARealPassword' | ConvertTo-SecureString -AsPlainText -Force
            Edit-ZertoVra -vraIdentifier "PasswordVraIdentifier" -HostRootPassword $SecurePassword | Should -BeExactly "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }

    }
    Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -Exactly 4
    Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoVra -Exactly 5
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
