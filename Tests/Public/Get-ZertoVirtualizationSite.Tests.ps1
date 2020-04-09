#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 23 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 23
        }

        $ParameterTestCases = @(
            @{ParameterName = 'siteIdentifier'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'hostIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'folders'; Type = 'Switch'; Mandatory = $true; Validation = $Null }
            @{ParameterName = 'hostClusters'; Type = 'Switch'; Mandatory = $true; Validation = $Null }
            @{ParameterName = 'hosts'; Type = 'Switch'; Mandatory = $true; Validation = $Null }
            @{ParameterName = 'networks'; Type = 'Switch'; Mandatory = $true; Validation = $Null }
            @{ParameterName = 'resourcePools'; Type = 'Switch'; Mandatory = $true; Validation = $Null }
            @{ParameterName = 'vms'; Type = 'Switch'; Mandatory = $true; Validation = $Null }
            @{ParameterName = 'repositories'; Type = 'Switch'; Mandatory = $true; Validation = $Null }
        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory)
            Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
        }

        It "<ParameterName> parameter has correct validation setting of <Validation>"  -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Validation)
            $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
            Switch ($Validation) {

                'NotNullOrEmpty' {
                    $attrs.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
                }

                $Null {
                    $Type -match 'Switch' | Should -BeTrue -Because "Only Switch Parameters should not have validation"
                }

                default {
                    $true | Should -BeFalse -Because "No Validation Selected. Review test cases"
                }

            }
        }

        It "$($global:function) does not have 'SupportsShouldProcess'" {
            Get-Command $global:function | Should -not -HaveParameter WhatIf
            Get-Command $global:function | Should -not -HaveParameter Confirm
            $script:ScriptBlock | Should -not -match 'SupportsShouldProcess'
            $script:ScriptBlock | Should -not -match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }

    }

    Context "$global:function::Parameter Functional Tests" {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter  {
            $uri -eq 'virtualizationsites'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-NoParams.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/devices'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-devices.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/devices?hostIdentifier=4567'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-devices-hostid.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/hosts'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-hosts.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/hosts/4567'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-hosts-hostid.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-SiteId.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/datastores'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-datastores.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/datastoreclusters'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-datastoreClusters.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/networks'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-Networks.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/folders'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-Folders.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/hostclusters'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-hostClusters.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/resourcepools'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-ResourcePools.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/vms'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-VMs.json" -Raw) | ConvertFrom-Json
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/repositories'
        } {
            return (Get-Content "$global:here\Mocks\VirtualSite-repositories.json" -Raw) | ConvertFrom-Json
        } -Verifiable

        It "Should return all known sites when called without parameters" {
            $results = Get-ZertoVirtualizationSite
            $results.Count | Should -BeExactly 2
        }

        It "Should return a single site when a siteIdentifier is provided" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234'
            $results.VirtualizationSiteName | Should -BeExactly 'cavc.nc.lab'
            $results.siteIdentifier | Should -BeExactly '8e1c9f53-4973-4a4a-b2dd-1ebb293614d8'
        }

        It "Should return a list of devices with the '-devices' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -devices
            $results.Count | Should -BeExactly 5
        }

        It "Should return a list of devices with the '-devices' switch and hostIdentifier provided" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -devices -hostIdentifier '4567'
            $results.Count | Should -BeExactly 5
        }

        It "Should return a list of hosts with the '-hosts' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -hosts
            $results.Count | Should -BeExactly 3
        }

        It "Should return a single host with the '-hosts' switch and hostIdentifier provided" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -hosts -hostIdentifier '4567'
            $results.VirtualizationHostName | Should -BeExactly "caesx3.nc.lab"
            $results.hostIdentifier | Should -BeExactly "09db6c5b-b956-430f-9589-b58876ca377a.host-18"
        }

        It "Should return a list of datastores with the '-datastores' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -datastores
            $results.Count | Should -BeExactly 8
        }

        It "Should return a list of datastores with the '-datastoreClusters' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -datastoreClusters
            $results.DatastoreClusterIdentifier | Should -BeExactly "09db6c5b-b956-430f-9589-b58876ca377a.group-p44"
            $results.DatastoreClusterName | Should -BeExactly "CA_DS_Cluster"
        }

        It "Should return a list of Networks with the '-networks' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -networks
            $results.NetworkIdentifier | Should -BeExactly "09db6c5b-b956-430f-9589-b58876ca377a.network-20"
            $results.VirtualizationNetworkName | Should -BeExactly "VM Network"
        }

        It "Should return a list of folders with the '-folders' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -folders
            $results.Count | Should -BeExactly 3
        }

        It "Should return a list of Host Clusters with the '-hostClusters' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -hostClusters
            $results.ClusterIdentifier | Should -BeExactly "09db6c5b-b956-430f-9589-b58876ca377a.domain-c7"
            $results.VirtualizationClusterName | Should -BeExactly "CA Cluster"
        }

        It "Should return a list of Resource Pools with the '-resourcePools' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -resourcePools
            $results.ResourcePoolIdentifier | Should -BeExactly "09db6c5b-b956-430f-9589-b58876ca377a.resgroup-8"
            $results.ResourcePoolName | Should -BeExactly "Resources"
        }

        It "Should return a list of VMs with the '-VMs' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -vms
            $results.Count | Should -BeExactly 4
        }

        It "Should return a list of LTR Repositories with the '-repositories' switch" {
            $results = Get-ZertoVirtualizationSite -siteIdentifier '1234' -repositories
            $results.ConnectionType | Should -BeExactly "ServerMessageBlock"
            $results.RepositoryIdentifier | Should -BeExactly "120355ce-fcd0-4820-a971-787d0470793b"
            $results.RepositoryName | Should -BeExactly "Synology"
            $results.StorageType | Should -BeExactly "NetworkShare"
            $results.Path | Should -not -be $null
        }

        Assert-VerifiableMock

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/devices'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/devices?hostIdentifier=4567'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/hosts'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/hosts/4567'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/datastores'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/datastoreclusters'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/networks'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/folders'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/hostclusters'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/resourcepools'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/vms'
        } -Exactly 1
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq 'virtualizationsites/1234/repositories'
        } -Exactly 1
    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
