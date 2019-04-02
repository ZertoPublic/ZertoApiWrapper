#Requires -Modules Pester
#Region - Test Setup
$moduleFileName = "ZertoApiWrapper.psd1"
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace("Tests", "ZertoApiWrapper")
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file = Get-ChildItem "$here\$sut"
$modulePath = $here -replace "Public", ""
$moduleFile = Get-ChildItem "$modulePath\$moduleFileName"
Get-Module -Name ZertoApiWrapper | Remove-Module -Force
Import-Module $moduleFile -Force
#EndRegion

Describe $file.BaseName -Tag 'Unit' {

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    Context "$($file.BaseName)::Parameter Unit Tests" {
        it "has a mantatory string parameter for the output path" {
            Get-Command $file.BaseName | Should -HaveParameter outputPath -Type String -Mandatory
        }

        it "has a non-mandatory string array parameter for vpgName(s) to export" {
            Get-Command $file.BaseName | Should -HaveParameter vpgName -Type String[] -Mandatory
        }

        it "has a non-mandatory switch parameter to export all vpgs" {
            Get-Command $file.BaseName | Should -HaveParameter allVpgs -Type Switch -Mandatory
        }

        it "No defined vpgName or AllVpg switch should throw an error" {
            {Export-ZertoVpg -outputPath "."} | Should -Throw
        }

        it "Output path does not take null or empty string" {
            {Export-ZertoVpg -outputPath "" -allVpgs} | Should -Throw
            {Export-ZertoVpg -outputPath $null -allVpgs} | Should -Throw
        }

        it "Vpg Name parameter does not take null or empty string" {
            {Export-ZertoVpg -outputPath "." -vpgName = ""} | Should -Throw
            {Export-ZertoVpg -outputPath "." -vpgName = $null} | Should -Throw
        }
    }

    Context "$($file.BaseName)::Function Unit Tests" {
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

        it "Output path should exist" {
            $outputPath | Should -Exist
        }

        it "Exported JSON file should exist after function called" {
            $vpgName = "HRIS"
            Export-ZertoVpg -outputPath $outputPath -vpgName $vpgName
            $outputFile = "{0}\{1}.json" -f $outputPath, $vpgName
            $outputFile | Should -Exist
            $outputFile | Should -Not -BeNullOrEmpty
        }

        it "Only one file should be present in the TestDrive" {
            (Get-ChildItem $outputPath).Count | Should -BeExactly 1
        }

        it "Should be valid JSON" {
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
