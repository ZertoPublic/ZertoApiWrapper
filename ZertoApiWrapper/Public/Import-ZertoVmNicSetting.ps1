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
            $NetworkMap = Get-Map -InputObject $RecoveryNetworks -key "VirtualizationNetworkName" -value "NetworkIdentifier"
            $VpgVms = Get-ZertoProtectedVm -vpgName $Vpg
            $VmMap = Get-Map -InputObject $VpgVms -key "vmName" -value "vmIdentifier"
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
                    Write-Error "$($Vm.VMName) does not contain all the required data. Please check the CSV entry for this item and try again. You are required to provide the VPGName, VMName, NicIdentifier, LiveNetwork, and ShouldReplaceMacAddress for each Nic." -ErrorAction Continue
                } else {
                    $uri = "vpgSettings/{0}/vms/{1}" -f $vpgSettingsId, $vmMap[$vm.VMName]
                    $VmNicSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsId -vmIdentifier $vmMap[$vm.VMName]
                    foreach ($nic in $VmNicSettings.nics) {
                        if ($nic.NicIdentifier -eq $vm.NicIdentifier) {
                            $NicUri = "{0}/nics/{1}" -f $uri, $nic.NicIdentifier
                            Invoke-ZertoRestRequest -uri $NicUri -Method "DELETE" > $null
                            $nicSettings = Invoke-ZertoRestRequest -uri $NicUri -Method "GET"
                            $nicSettings.failover.Hypervisor.NetworkIdentifier = $NetworkMap[$vm.LiveNetwork]
                            $nicSettings.failover.Hypervisor.ShouldReplaceMacAddress = $vm.LiveShouldReplaceMac
                            if ($vm.LiveIsDHCP -imatch "true") {
                                $IpConfig = [PSCustomObject]@{
                                    IsDhcp       = $vm.LiveIsDHCP
                                    PrimaryDns   = $vm.LivePrimaryDns
                                    SecondaryDns = $vm.LiveSecondayDns
                                }
                                $nicSettings.failover.Hypervisor.IpConfig = $IpConfig
                                $nicSettings.failover.Hypervisor.DnsSuffix = $vm.LiveDnsSuffix
                            } elseif (($vm.LiveIsDHCP -imatch "false" -or
                                    [string]::IsNullOrWhiteSpace($vm.LiveIsDHCP)) -and
                                -not [string]::IsNullOrWhiteSpace($vm.LiveIpAddress)) {
                                $IpConfig = [PSCustomObject]@{
                                    IsDhcp       = $vm.LiveIsDHCP
                                    StaticIp     = $vm.LiveIpAddress
                                    SubnetMask   = $vm.LiveIpSubnetMask
                                    Gateway      = $vm.LiveIpDefaultGateway
                                    PrimaryDns   = $vm.LivePrimaryDns
                                    SecondaryDns = $vm.LiveSecondayDns
                                }
                                $nicSettings.failover.Hypervisor.IpConfig = $IpConfig
                                $nicSettings.failover.Hypervisor.DnsSuffix = $vm.LiveDnsSuffix
                            }
                            $nicSettings.failoverTest.Hypervisor.NetworkIdentifier = $NetworkMap[$vm.TestNetwork]
                            $nicSettings.failoverTest.Hypervisor.ShouldReplaceMacAddress = $vm.TestShouldReplaceMac
                            if ($vm.TestIsDHCP -imatch "true" ) {
                                $IpConfig = [PsCustomObject]@{
                                    IsDhcp       = $vm.TestIsDHCP
                                    PrimaryDns   = $vm.TestPrimaryDns
                                    SecondaryDns = $vm.TestSecondayDns
                                }
                                $nicSettings.failoverTest.Hypervisor.IpConfig = $IpConfig
                                $nicSettings.failoverTest.Hypervisor.DnsSuffix = $vm.TestDnsSuffix
                            } elseif (($vm.TestIsDHCP -imatch "false" -or
                                    [string]::IsNullOrWhiteSpace($vm.TestIsDHCP)) -and
                                -not [string]::IsNullOrWhiteSpace($vm.TestIpAddress)) {
                                $IpConfig = [PsCustomObject]@{
                                    IsDhcp       = $vm.TestIsDHCP
                                    StaticIp     = $vm.TestIpAddress
                                    SubnetMask   = $vm.TestIpSubnetMask
                                    Gateway      = $vm.TestIpDefaultGateway
                                    PrimaryDns   = $vm.TestPrimaryDns
                                    SecondaryDns = $vm.TestSecondayDns
                                }
                                $nicSettings.failoverTest.Hypervisor.IpConfig = $IpConfig
                                $nicSettings.failoverTest.Hypervisor.DnsSuffix = $vm.TestDnsSuffix
                            }
                            Write-Verbose "Putting Updated Config for VM: $($vm.name), NIC: $($nic.nicidentifier) in VPG: $Vpg"
                            if ($PSCmdlet.ShouldProcess($vm.NicIdentifier, "Updating Nic")) {
                                Invoke-ZertoRestRequest -uri $NicUri -Method "PUT" -Body ($nicSettings | ConvertTo-Json -Depth 10) > $null
                            }
                        }
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
