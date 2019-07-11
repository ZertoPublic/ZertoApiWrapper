#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$script:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $script:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $script:function).ScriptBlock
    }

    Context "$script:function::Parameter Unit Tests" {

        It "Has a mandatory string parameter for the target host" {
            Get-Command $script:function | Should -HaveParameter TargetHost -Mandatory -Type String
        }

        It "Will not take a non-ip address as a 'TargetHost'" {
            { Add-ZertoPeerSite -targetHost 'MyZVMHost' -targetPort '9081' } | Should -Throw
            { Add-ZertoPeerSite -targetHost '192.168.1.266' -targetPort '9081' } | Should -Throw
            { Add-ZertoPeerSite -targetHost '192.168.1' -targetPort '9081' } | Should -Throw
            { Add-ZertoPeerSite -targetHost $null -targetPort '9081' } | Should -Throw
        }

        It "Has a non-mandatory string parameter for the target port with default value of 9081" {
            Get-Command Add-ZertoPeerSite | Should -HaveParameter TargetPort -Not -Mandatory
            Get-Command Add-ZertoPeerSite | Should -HaveParameter TargetPort -Type Int32
            Get-Command Add-ZertoPeerSite | Should -HaveParameter TargetPort -DefaultValue 9081
        }

        It "Will not take a non-int as a port" {
            { Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort 'string' } | Should -Throw
            { Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort $true } | Should -Throw
            { Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort $null } | Should -Throw
        }

        It "Will fail if the specified port is outside of the range 1024 - 65535" {
            { Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort 1023 } | Should -Throw
            { Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort 65536 } | Should -Throw
            { Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort 0 } | Should -Throw
            { Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort -1 } | Should -Throw
        }

        It "Supports 'SupportsShouldProcess'" {
            Get-Command $script:function | Should -HaveParameter WhatIf
            Get-Command $script:function | Should -HaveParameter Confirm
            $script:ScriptBlock | Should -match 'SupportsShouldProcess'
            $script:ScriptBlock | Should -match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "Add-ZertoPeerSite::Functional Unit Tests" {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
            return (Get-Content "$global:here\Mocks\TaskId.txt")
        }

        It "Returns a string value" {
            $results = Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort '9081'
            $results | Should -Not -BeNullOrEmpty
            $results | Should -BeOfType "String"
            $results | Should -BeExactly "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }

        It "Does not return a taskId if '-whatif' is used" {
            $results = Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort '9081' -WhatIf
            $results | Should -BeNullOrEmpty
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -Exactly 1
    }
}

