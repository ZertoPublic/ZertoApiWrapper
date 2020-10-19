#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {

        $ParameterTestCases = @(
            @{ParameterName = 'OutputPath'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'vpgName'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'allVpgs'; Type = 'Switch'; Mandatory = $true; Validation = $null }
        )

        It "<ParameterName> parameter is of <Type> type, with correct validation" -TestCases $ParameterTestCases {
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

    Context "$($global:function)::Function Unit Tests" {
        Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpg {
            $returnObj = @{
                VpgName       = "HRIS"
                VpgIdentifier = "dddf2fa8-79e2-4e4f-a83b-f66676afea64"
            }
            return $returnObj
        }

        Mock -ModuleName ZertoApiWrapper -CommandName New-ZertoVpgSettingsIdentifier {
            return "1024d377-afb8-4880-82f0-96eeff413ffd"
        }

        Mock -ModuleName ZertoApiWrapper -CommandName Remove-ZertoVpgSettingsIdentifier {
            return $null
        }

        Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpgSetting {
            $returnObj = @{
                Backup                = $null
                Basic                 = @{
                    JournalHistoryInHours    = 4
                    Name                     = "HRIS"
                    Priority                 = "Medium"
                    ProtectedSiteIdentifier  = "928a122b-1763-4664-ad37-cc00bb883f2f"
                    RecoverySiteIdentifier   = "07f62976-6228-40ff-9542-4d7837114f37"
                    RpoInSeconds             = 300
                    ServiceProfileIdentifier = $null
                    TestIntervalInMinutes    = 43200
                    UseWanCompression        = $true
                    ZorgIdentifier           = $null
                }
                BootGroups            = @{
                    BootGroups = @(
                        @{
                            BootDelayInSeconds  = 0
                            BootGroupIdentifier = "00000000-0000-0000-0000-000000000000"
                            Name                = "Default"
                        }
                    )
                }
                Journal               = @{
                    DatastoreIdentifier = $null
                    Limitation          = @{
                        HardLimitInMB             = 0
                        HardLimitInPercent        = 0
                        WarningThresholdInMb      = 0
                        WarningThresholdInPercent = 0
                    }
                }
                Networks              = @{
                    Failover     = @{
                        Hypervisor = @{
                            DefaultNetworkIdentifier = "48ffb633-2548-879c-5eb1-f53081fb0c21.network-1"
                        }
                        VCD        = $null
                    }
                    FailoverTest = @{
                        Hypervisor = @{
                            DefaultNetworkIdentifier = "48ffb633-2548-879c-5eb1-f53081fb0c21.network-1"
                        }
                        VCD        = $null
                    }
                }
                Protected             = @{
                    VCD = $null
                }
                Recovery              = @{
                    DefaultDatastoreClusterIdentifier = $null
                    DefaultDatastoreIdentifier        = $null
                    DefaultFolderIdentifier           = "48ffb633-2548-879c-5eb1-f53081fb0c21.vm"
                    DefaultHostClusterIdentifier      = $null
                    DefaultHostIdentifier             = $null
                    ResourcePoolIdentifier            = $null
                    VCD                               = $null
                }
                Scripting             = @{
                    PostBackup  = $null
                    PostRecovey = @{
                        Command          = $null
                        Parameters       = $null
                        TimeOutInSeconds = 300
                    }
                    PreRecovery = @{
                        Command          = $null
                        Parameters       = $null
                        TimeOutInSeconds = 300
                    }
                }
                Vms                   = @(
                    @{
                        BootGroupIdentifier = "00000000-0000-0000-0000-000000000000"
                        Journal             = @{
                            DatastoreIdentifier = "48ffb633-2548-879c-5eb1-f53081fb0c21.DS_vSphere-Site02"
                            Limitation          = @{
                                HardLimitInMB             = 0
                                HardLimitInPercent        = 0
                                WarningThresholdInMb      = 0
                                WarningThresholdInPercent = 0
                            }
                        }
                        Nics                = @(
                            @{
                                Failover      = @{
                                    Hypervisor = @{
                                        DnsSuffix               = $null
                                        IpConfig                = $null
                                        NetworkIdentifier       = "48ffb633-2548-879c-5eb1-f53081fb0c21.network-1"
                                        ShouldReplaceMacAddress = $false
                                    }
                                    VCD        = $null
                                }
                                FailoverTest  = @{
                                    Hypervisor = @{
                                        DnsSuffix               = $null
                                        IpConfig                = $null
                                        NetworkIdentifier       = "48ffb633-2548-879c-5eb1-f53081fb0c21.network-1"
                                        ShouldReplaceMacAddress = $false
                                    }
                                    VCD        = $null
                                }
                                NicIdentifier = "HRIS01-nic0"
                            }
                        )
                        Recovery            = @{
                            DatastoreClusterIdentifier = $null
                            DatastoreIdentifier        = "48ffb633-2548-879c-5eb1-f53081fb0c21.DS_vSphere-Site02"
                            FolderIdentifier           = "48ffb633-2548-879c-5eb1-f53081fb0c21.vm"
                            HostClusterIdentifier      = $null
                            HostIdentifier             = "48ffb633-2548-879c-5eb1-f53081fb0c21.znest83esxus-0"
                            ResourcePoolIdentifier     = $null
                            VCD                        = $null
                        }
                        VmIdentifier        = "840f99fb-4689-2f8b-ea10-2a47a5bb00cc.vm-28"
                        Volumes             = @(
                            @{
                                Datastore        = @{
                                    DatastoreClusterIdentifier = $null
                                    DatastoreIdentifier        = "48ffb633-2548-879c-5eb1-f53081fb0c21.DS_vSphere-Site02"
                                    IsThin                     = $true
                                }
                                IsSwap           = $false
                                Preseed          = $null
                                RDM              = $null
                                VCD              = $null
                                VolumeIdentifier = "scsi:0:0"
                            },
                            @{
                                Datastore        = @{
                                    DatastoreClusterIdentifier = $null
                                    DatastoreIdentifier        = "48ffb633-2548-879c-5eb1-f53081fb0c21.DS_vSphere-Site02"
                                    IsThin                     = $true
                                }
                                IsSwap           = $false
                                Preseed          = $null
                                RDM              = $null
                                VCD              = $null
                                VolumeIdentifier = "scsi:0:1"
                            }
                        )
                    }
                )
                VpgIdentifier         = "dddf2fa8-79e2-4e4f-a83b-f66676afea64"
                VpgSettingsIdentifier = "1024d377-afb8-4880-82f0-96eeff413ffd"
            }
            return $returnObj
        }

        $outputPath = "TestDrive:"

        It "Output path should exist" {
            $outputPath | Should -Exist
        }

        It "Exported JSON file should exist after function called" {
            $vpgName = "HRIS"
            Export-ZertoVpg -outputPath $outputPath -vpgName $vpgName
            $outputFile = "{0}\{1}.json" -f $outputPath, $vpgName
            $outputFile | Should -Exist
            $outputFile | Should -Not -BeNullOrEmpty
        }

        It "Only one file should be present in the TestDrive" {
            (Get-ChildItem $outputPath).Count | Should -BeExactly 1
        }

        It "Should be valid JSON" {
            $vpgName = "HRIS"
            Export-ZertoVpg -outputPath $outputPath -vpgName $vpgName
            $outputFile = "{0}\{1}.json" -f $outputPath, $vpgName
            Get-Content -Path $outputFile -Raw | ConvertFrom-Json
        }

        It "Should be able to export more than one VPG" {
            $vpgName = @("HRIS", "HRIS2")
            Export-ZertoVpg -outputPath $outputPath -vpgName $vpgName
            (Get-ChildItem $outputPath).Count | Should -BeExactly 2
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpg
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName New-ZertoVpgSettingsIdentifier
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpgSetting
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
