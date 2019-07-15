<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Import-ZertoVmNicSetting {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # File to process for import
        [Parameter(Helpmessage = "CSV file containing the required VM NIC settings", Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $InputFile
    )

    begin {
    }

    process {
        if (-not (Test-Path $InputFile)) {
            Write-Error "Unable to find $InputFile. Please check the name and path and try again." -ErrorAction Stop
        } elseif ((Get-Item $InputFile).Extension -notmatch '.csv') {
            Write-Error "$InputFile does not have a 'csv' extension. Please check the name and path and try again." -ErrorAction Stop
        }
        $ExpectedHeaders = "VPGName", "VMName", "NicIdentifier", "LiveNetwork", "LiveShouldReplaceMac", "LiveIsDHCP", "LiveIpAddress", "LiveIpSubnetMask", "LiveIpDefaultGateway", "LivePrimaryDns", "LiveSecondayDns", "LiveDnsSuffix", "TestNetwork", "TestShouldReplaceMac", "TestIsDHCP", "TestIpAddress", "TestIpSubnetMask", "TestIpDefaultGateway", "TestPrimaryDns", "TestSecondayDns", "TestDnsSuffix"
        $HeaderLine = ((Get-Content -Path $InputFile -First 1).Replace('"', '')).Split(',')
        foreach ($header in $ExpectedHeaders) {
            if ($header -notin $HeaderLine) {
                Write-Error "$InputFile is malformed. Please ensure all headers are present." -ErrorAction Stop
            }
        }
        $ImportData = Import-Csv -Path $InputFile
        $VpgsToUpdate = $ImportData.VPGName | Select-Object -Unique
        foreach ($Vpg in $VpgsToUpdate) {
            $VpgInfo = Get-ZertoVpg -vpgName $Vpg
            $VpgIdentifier = $VpgInfo.VpgIdentifier
            $RecoveryNetworks = Get-ZertoVirtualizationSite -siteIdentifier $VpgInfo.RecoverySite.Identifier -networks
            $NetworkMap = New-Map -InputObject $RecoveryNetworks -key "VirtualizationNetworkName" -value "NetworkIdentifier"
            $VpgVms = Get-ZertoProtectedVm -vpgName $Vpg
            $VmMap = New-Map -InputObject $VpgVms -key "vmName" -value "vmIdentifier"
            $VpgSettingsId = New-ZertoVpgSettingsIdentifier -vpgIdentifier $VpgIdentifier
            $VmsToUpdate = $ImportData | Where-Object { $_.VPGName -eq $Vpg }
            foreach ($vm in $VmsToUpdate) {
                if ([string]::IsNullOrWhiteSpace($vm.VpgName) -or
                    [string]::IsNullOrWhiteSpace($Vm.VMName) -or
                    [string]::IsNullOrWhiteSpace($Vm.NicIdentifier) -or
                    [string]::IsNullOrWhiteSpace($Vm.LiveNetwork) -or
                    [string]::IsNullOrWhiteSpace($Vm.LiveShouldReplaceMac) -or
                    [string]::IsNullOrWhiteSpace($Vm.TestNetwork) -or
                    [string]::IsNullOrWhiteSpace($Vm.TestShouldReplaceMac)) {
                    Write-Error "$($Vm.VMName) does not contain all the required data. Please check the CSV entry for this item and try again." -ErrorAction Continue
                } else {
                    $uri = "vpgSettings/{0}/vms/{1}" -f $vpgSettingsId, $vmMap[$vm.VMName]
                    $VmNicSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsId -vmIdentifier $vmMap[$vm.VMName]
                    foreach ($nic in $VmNicSettings.nics) {
                        if ($nic.NicIdentifier -eq $vm.NicIdentifier) {
                            $nic.failover.Hypervisor.NetworkIdentifier = $NetworkMap[$vm.LiveNetwork]
                            $nic.failover.Hypervisor.ShouldReplaceMacAddress = $vm.LiveShouldReplaceMac
                            if ($null -eq $nic.failover.Hypervisor.IpConfig -and ($null -ne $vm.LiveIsDHCP -or $null -ne $vm.LiveIpAddress)) {
                                $IpConfig = [PSCustomObject]@{
                                    IsDhcp       = $vm.LiveIsDHCP
                                    StaticIp     = $vm.LiveIpAddress
                                    SubnetMask   = $vm.LiveIpSubnetMask
                                    Gateway      = $vm.LiveIpDefaultGateway
                                    PrimaryDns   = $vm.LivePrimaryDns
                                    SecondaryDns = $vm.LiveSecondayDns
                                }
                                $nic.failover.Hypervisor.IpConfig = $IpConfig
                            } elseif ($null -eq $nic.failover.Hypervisor.IpConfig -and $null -eq $vm.LiveIsDHCP -and $null -eq $vm.LiveIpAddress) {
                                $nic.failover.Hypervisor.IpConfig = $null
                            } else {
                                $nic.failover.Hypervisor.IpConfig.IsDhcp = $vm.LiveIsDHCP
                                $nic.failover.Hypervisor.IpConfig.StaticIp = $vm.LiveIpAddress
                                $nic.failover.Hypervisor.IpConfig.SubnetMask = $vm.LiveIpSubnetMask
                                $nic.failover.Hypervisor.IpConfig.Gateway = $vm.LiveIpDefaultGateway
                                $nic.failover.Hypervisor.IpConfig.PrimaryDns = $vm.LivePrimaryDns
                                $nic.failover.Hypervisor.IpConfig.SecondaryDns = $vm.LiveSecondayDns
                            }
                            $nic.failover.Hypervisor.DnsSuffix = $vm.LiveDnsSuffix
                            $nic.failoverTest.Hypervisor.NetworkIdentifier = $NetworkMap[$vm.TestNetwork]
                            $nic.failoverTest.Hypervisor.ShouldReplaceMacAddress = $vm.TestShouldReplaceMac
                            if ($null -eq $nic.failoverTest.Hypervisor.IpConfig -and ($null -ne $vm.TestIsDHCP -or $null -ne $vm.TestIpAddress)) {
                                $IpConfig = [PsCustomObject]@{
                                    IsDhcp       = $vm.TestIsDHCP
                                    StaticIp     = $vm.TestIpAddress
                                    SubnetMask   = $vm.TestIpSubnetMask
                                    Gateway      = $vm.TestIpDefaultGateway
                                    PrimaryDns   = $vm.TestPrimaryDns
                                    SecondaryDns = $vm.TestSecondayDns
                                }
                                $nic.failoverTest.Hypervisor.IpConfig = $IpConfig
                            } elseif ($null -eq $nic.failoverTest.Hypervisor.IpConfig -and $null -eq $vm.TestIsDHCP -and $null -eq $vm.TestIpAddress) {
                                $nic.failoverTest.Hypervisor.IpConfig = $null
                            } else {
                                $nic.failoverTest.Hypervisor.IpConfig.IsDhcp = $vm.TestIsDHCP
                                $nic.failoverTest.Hypervisor.IpConfig.StaticIp = $vm.TestIpAddress
                                $nic.failoverTest.Hypervisor.IpConfig.SubnetMask = $vm.TestIpSubnetMask
                                $nic.failoverTest.Hypervisor.IpConfig.Gateway = $vm.TestIpDefaultGateway
                                $nic.failoverTest.Hypervisor.IpConfig.PrimaryDns = $vm.TestPrimaryDns
                                $nic.failoverTest.Hypervisor.IpConfig.SecondaryDns = $vm.TestSecondayDns
                            }
                            $nic.failoverTest.Hypervisor.DnsSuffix = $vm.TestDnsSuffix
                        }
                    }
                    Write-Verbose "Putting Updated Config for VM: $($vm.vmname) in Vpg: $Vpg"
                    if ($PSCmdlet.ShouldProcess($vm.NicIdentifier, "Updating Nic")) {
                        Invoke-ZertoRestRequest -uri $uri -Method "PUT" -Body ($VmNicSettings | ConvertTo-Json -Depth 10) > $null
                    }
                }
            }
            Write-Verbose "Saving updated configuration for VPG: $Vpg"
            if ($PSCmdlet.ShouldProcess($Vpg, "Saving Changes")) {
                Save-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsId
            }
            Write-Verbose "Waiting 5 Seconds for Next VPG Update"
            Start-Sleep 5
        }
    }


    end {
    }
}
