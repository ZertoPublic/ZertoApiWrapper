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
            $vmMap = New-Map -InputObject $protectedVms -key "vmIdentifier" -value "vmName"
            $settingsId = New-ZertoVpgSettingsIdentifier -vpgIdentifier $group.vpgIdentifier
            $vmSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $settingsId -vms
            $networks = Get-ZertoVirtualizationSite -siteIdentifier $group.RecoverySite.identifier -networks
            $null = Remove-ZertoVpgSettingsIdentifier -vpgSettingsIdentifier $settingsId
            $networkMap = New-Map -InputObject $networks -key "NetworkIdentifier" -value "VirtualizationNetworkName"
            foreach ($vm in $vmSettings) {
                $nicInfo = [PSCustomObject]@{
                    VPGName              = $group.VPGName
                    VMName               = $vmMap[$($vm.vmIdentifier)]
                    NicIdentifier        = $vm.nics.NicIdentifier
                    LiveNetwork          = $networkMap[$vm.nics.failover.Hypervisor.NetworkIdentifier]
                    LiveShouldReplaceMac = $vm.nics.failover.Hypervisor.ShouldReplaceMacAddress
                    LiveIsDHCP           = $vm.Nics.failover.Hypervisor.IpConfig.IsDhcp
                    LiveIpAddress        = $vm.nics.failover.Hypervisor.IpConfig.StaticIp
                    LiveIpSubnetMask     = $vm.nics.failover.Hypervisor.IpConfig.SubnetMask
                    LiveIpDefaultGateway = $vm.nics.failover.Hypervisor.IpConfig.Gateway
                    LivePrimaryDns       = $vm.nics.failover.Hypervisor.IpConfig.PrimaryDns
                    LiveSecondayDns      = $vm.nics.failover.Hypervisor.IpConfig.SecondaryDns
                    LiveDnsSuffix        = $vm.nics.failover.Hypervisor.DnsSuffix
                    TestNetwork          = $networkMap[$vm.nics.failoverTest.Hypervisor.NetworkIdentifier]
                    TestShouldReplaceMac = $vm.nics.failoverTest.Hypervisor.ShouldReplaceMacAddress
                    TestIsDHCP           = $vm.Nics.failoverTest.Hypervisor.IpConfig.IsDhcp
                    TestIpAddress        = $vm.nics.failoverTest.Hypervisor.IpConfig.StaticIp
                    TestIpSubnetMask     = $vm.nics.failoverTest.Hypervisor.IpConfig.SubnetMask
                    TestIpDefaultGateway = $vm.nics.failoverTest.Hypervisor.IpConfig.Gateway
                    TestPrimaryDns       = $vm.nics.failoverTest.Hypervisor.IpConfig.PrimaryDns
                    TestSecondayDns      = $vm.nics.failoverTest.Hypervisor.IpConfig.SecondaryDns
                    TestDnsSuffix        = $vm.nics.failoverTest.Hypervisor.DnsSuffix
                }
                $nicInfo
            }
        }
        $nicSettings | Export-Csv -Path $OutputFile
    }

    end {
    }
}
