<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Export-ZertoVmNicSetting {
    [CmdletBinding()]
    param (
        # Vpg(s) to export. If no VPG was named, all data will be exported.
        [Parameter(
            Helpmessage = "VPG(s) to export"
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $VpgName,
        # Output file information
        [Parameter(
            Helpmessage = "File to export the data to. This MUST be a CSV. If a CSV filename is not specified, the file will be forced into a CSV",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]
        $OutputFile
    )

    begin {
    }

    process {
        if (($OutputFile.Split('.')[-1]) -ne 'csv') {
            $OutputFile += '.csv'
        }
        if ( "VpgName" -in $PSBoundParameters.Keys ) {
            $vpgs = Get-ZertoVpg | Where-Object { $_.VpgName -in $VpgName }
            foreach ($group in $VpgName) {
                if ($group -notin $vpgs.VpgName) {
                    Write-Error "$group VPG not found. Skipping." -ErrorAction Continue
                }
            }
        } else {
            $vpgs = Get-ZertoVpg
        }
        $nicSettings = foreach ($group in $vpgs) {
            $protectedVms = Get-ZertoProtectedVm -vpgName ($group.vpgname)
            $vmMap = Get-Map -InputObject $protectedVms -key "vmIdentifier" -value "vmName"
            $settingsId = New-ZertoVpgSettingsIdentifier -vpgIdentifier $group.vpgIdentifier
            $vmSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $settingsId -vms
            $networks = Get-ZertoVirtualizationSite -siteIdentifier $group.RecoverySite.identifier -networks
            $null = Remove-ZertoVpgSettingsIdentifier -vpgSettingsIdentifier $settingsId
            $networkMap = Get-Map -InputObject $networks -key "NetworkIdentifier" -value "VirtualizationNetworkName"
            foreach ($vm in $vmSettings) {
                if ($vm.nics.count -gt 0) {
                    foreach ($nic in $vm.nics) {
                        $nicInfo = [PSCustomObject]@{
                            VPGName              = $group.VPGName
                            VMName               = $vmMap[$vm.vmIdentifier]
                            NicIdentifier        = $nic.NicIdentifier
                            LiveNetwork          = $networkMap[$nic.failover.Hypervisor.NetworkIdentifier]
                            LiveShouldReplaceMac = $nic.failover.Hypervisor.ShouldReplaceMacAddress
                            LiveIsDHCP           = $nic.failover.Hypervisor.IpConfig.IsDhcp
                            LiveIpAddress        = $nic.failover.Hypervisor.IpConfig.StaticIp
                            LiveIpSubnetMask     = $nic.failover.Hypervisor.IpConfig.SubnetMask
                            LiveIpDefaultGateway = $nic.failover.Hypervisor.IpConfig.Gateway
                            LivePrimaryDns       = $nic.failover.Hypervisor.IpConfig.PrimaryDns
                            LiveSecondayDns      = $nic.failover.Hypervisor.IpConfig.SecondaryDns
                            LiveDnsSuffix        = $nic.failover.Hypervisor.DnsSuffix
                            TestNetwork          = $networkMap[$nic.failoverTest.Hypervisor.NetworkIdentifier]
                            TestShouldReplaceMac = $nic.failoverTest.Hypervisor.ShouldReplaceMacAddress
                            TestIsDHCP           = $nic.failoverTest.Hypervisor.IpConfig.IsDhcp
                            TestIpAddress        = $nic.failoverTest.Hypervisor.IpConfig.StaticIp
                            TestIpSubnetMask     = $nic.failoverTest.Hypervisor.IpConfig.SubnetMask
                            TestIpDefaultGateway = $nic.failoverTest.Hypervisor.IpConfig.Gateway
                            TestPrimaryDns       = $nic.failoverTest.Hypervisor.IpConfig.PrimaryDns
                            TestSecondayDns      = $nic.failoverTest.Hypervisor.IpConfig.SecondaryDns
                            TestDnsSuffix        = $nic.failoverTest.Hypervisor.DnsSuffix
                        }
                        $nicInfo
                    }
                }
            }
        }
        $nicSettings | Export-Csv -Path $OutputFile -NoTypeInformation
    }

    end {
    }
}
