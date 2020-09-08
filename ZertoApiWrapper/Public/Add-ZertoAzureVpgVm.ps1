<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Add-ZertoAzureVpgVm {
    [Cmdletbinding()]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "VPG Settings Identifier of the target VPG.",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [Guid]$VpgSettingsIdentifier,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$VmName,
        [ValidateNotNullOrEmpty()]
        [String]$LiveNetworkName,
        [ValidateNotNullOrEmpty()]
        [String]$LiveSubnetName,
        [ValidateNotNullOrEmpty()]
        [String]$LiveSecurityGroupName,
        [ValidateNotNullOrEmpty()]
        [String]$LiveInstanceType,
        [ValidateSet("UnmanagedStandard", "ManagedPremiumSSD", "ManagedStandardSSD", "ManagedStandardHDD")]
        [String]$LiveDiskType,
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [String]$LiveIpAddress,
        [ValidateNotNullOrEmpty()]
        [String]$TestNetworkName,
        [ValidateNotNullOrEmpty()]
        [String]$TestSubnetName,
        [ValidateNotNullOrEmpty()]
        [String]$TestSecurityGroupName,
        [ValidateNotNullOrEmpty()]
        [String]$TestInstanceType,
        [ValidateSet("UnmanagedStandard", "ManagedPremiumSSD", "ManagedStandardSSD", "ManagedStandardHDD")]
        [String]$TestDiskType,
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [String]$TestIpAddress,
        [ValidateNotNullOrEmpty()]
        [String[]]$TempDrive
    )

    begin {
    }

    process {
        # Get Target Site Identifier from the settings for resource lookups
        $TargetSiteIdentifier = Get-ZertoVpgSetting -vpgSettingsIdentifier $VpgSettingsIdentifier -basic | Select-Object -ExpandProperty RecoverySiteIdentifier

        # Add VM to VPG. Setting to Null as this function returns the VpgSettingsIdentifier
        $null = Add-ZertoVpgVm -vpgSettingsIdentifier $VpgSettingsIdentifier -vm $VmName

        # Getting the VmIdentifier
        $VmIdentifier = Get-ZertoVpgSetting -vpgSettingsIdentifier $VpgSettingsIdentifier -vms | Where-Object { $_.VmName -match $VmName } | Select-Object -ExpandProperty VmIdentifier

        # Setting the URI fragment for use later
        $VmSettingsUri = "vpgSettings/{0}/vms/{1}" -f $VpgSettingsIdentifier, $VmIdentifier

        # Getting all default settings for the specified VM to update per passed parameters
        $VmSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $VpgSettingsIdentifier -vmIdentifier $VmIdentifier

        # Create Maps for quick lookups and validations
        $NetworksMap = GetMap -InputObject (Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -Network) -Key "VirtualNetworkName" -Value "VirtualNetworkIdentifier"
        $SubnetsMap = GetMap -InputObject (Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -Subnet) -Key "SubnetName" -Value "SubnetIdentifier"
        $SecurityGroupsMap = GetMap -InputObject (Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -SecurityGroup) -Key "SecurityGroupName" -Value "SecurityGroupIdentifier"
        $Instances = Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -VmInstanceType

        # Iterate through the bound parameters and set attributes accordingly
        Switch ($PSBoundParameters.Keys) {
            "LiveNetworkName" {
                if ($null -eq $NetworksMap[$LiveNetworkName]) {
                    Write-Error "Unable to find network with name $LiveNetworkName. Please check the name and try again." -ErrorAction Stop
                } else {
                    $VmSettings.Recovery.PublicCloud.Failover.VirtualNetworkIdentifier = $NetworksMap[$LiveNetworkName]
                }
            }

            "LiveSubnetName" {
                if ($null -eq $SubnetsMap[$LiveSubnetName]) {
                    Write-Error "Unable to find subnet with name $LiveSubnetName. Please check the name and try again." -ErrorAction Stop
                } else {
                    $VmSettings.Nics[0].Failover.PublicCloud.SubnetIdentifier = $SubnetsMap[$LiveSubnetName]
                }
            }

            "LiveSecurityGroupName" {
                if ($null -eq $null -eq $SecurityGroupsMap[$LiveSecurityGroupName]) {
                    Write-Error "Unable to find security group with name $LiveSecurityGroupName. Please check the name and try again." -ErrorAction Stop
                } else {
                    $VmSettings.Nics[0].Failover.PublicCloud.SecurityGroupIdentifier = $SecurityGroupsMap[$LiveSecurityGroupName]
                }
            }

            "LiveInstanceType" {
                if ($LiveInstanceType -notin $Instances.VmInstanceType) {
                    Write-Error "Unable to find a supported VM Instance Type with name $LiveInstanceType. Please check the name and try again." -ErrorAction Stop
                } else {
                    $LiveInstanceType = $Instances.Where( { $_.VmInstanceType -match $LiveInstanceType }) | Select-Object -ExpandProperty VmInstanceType
                    $VmSettings.Recovery.PublicCloud.Failover.VmInstanceType = $LiveInstanceType
                }
            }

            "TestNetworkName" {
                if ($null -eq $NetworksMap[$TestNetworkName]) {
                    Write-Error "Unable to find network with name $TestNetworkName. Please check the name and try again." -ErrorAction Stop
                } else {
                    $VmSettings.Recovery.PublicCloud.FailoverTest.VirtualNetworkIdentifier = $NetworksMap[$TestNetworkName]
                }
            }

            "TestSubnetName" {
                if ($null -eq $SubnetsMap[$TestSubnetName]) {
                    Write-Error "Unable to find subnet with name $TestSubnetName. Please check the name and try again." -ErrorAction Stop
                } else {
                    $VmSettings.Nics[0].FailoverTest.PublicCloud.SubnetIdentifier = $SubnetsMap[$TestSubnetName]
                }
            }

            "TestSecurityGroupName" {
                if ($null -eq $SecurityGroupsMap) {
                    Write-Error "Unable to find security group with name $TestSecurityGroupName. Please check the name and try again." -ErrorAction Stop
                } else {
                    $VmSettings.Nics[0].FailoverTest.PublicCloud.SecurityGroupIdentifier = $SecurityGroupsMap[$TestSecurityGroupName]
                }
            }

            "TestInstanceType" {
                if ($TestInstanceType -notin $Instances.VmInstanceType) {
                    Write-Error "Unable to find a supported VM Instance Type with name $TestInstanceType. Please check the name and try again." -ErrorAction Stop
                } else {
                    $TestInstanceType = $Instances.Where( { $_.VmInstanceType -match $TestInstanceType }) | Select-Object -ExpandProperty VmInstanceType
                    $VmSettings.Recovery.PublicCloud.FailoverTest.VmInstanceType = $TestInstanceType
                }
            }

            "LiveDiskType" {
                $VmSettings.Recovery.PublicCloud.Failover.Azure.RecoveryDiskType = $LiveDiskType
            }

            "TestDiskType" {
                $VmSettings.Recovery.PublicCloud.FailoverTest.Azure.RecoveryDiskType = $TestDiskType
            }

            "LiveIpAddress" {
                $VmSettings.Nics[0].Failover.PublicCloud.PrivateIP = $LiveIpAddress
            }

            "TestIpAddress" {
                $VmSettings.Nics[0].FailoverTest.PublicCloud.PrivateIP = $TestIpAddress
            }
        } # End Switch Statement

        # Update the VPG VM Settings Object with the updated attributes
        $null = Invoke-ZertoRestRequest -uri $VmSettingsUri -method PUT -body ($VmSettings | ConvertTo-Json -Depth 10)

        # If any Temp Drives are specified, loop through them and set them as such
        if ($PSBoundParameters.Keys -contains "TempDrive") {
            foreach ($drive in $TempDrive) {
                $driveUri = "{0}/volumes/{1}" -f $VmSettingsUri, $drive
                $driveSettings = Invoke-ZertoRestRequest -uri $driveUri
                $driveSettings.IsSwap = $True
                $null = Invoke-ZertoRestRequest -uri $driveUri -method PUT -body ($driveSettings | ConvertTo-Json -Depth 10)
            }
        }
    }

    end {
    }
}
