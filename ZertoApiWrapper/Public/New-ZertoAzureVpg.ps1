<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function New-ZertoAzureVpg {
    [CmdletBinding()]
    # Ignoring Should Process PSSA rule. Change is in memory and not committed untill the Save-ZertoVpgSetting function is called.
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "Desired name of the VPG to be created."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(
            HelpMessage = "Replication priority of the VPG to be created. Default value is 'Medium'"
        )]
        [ValidateSet("High", "Medium", "Low")]
        [string]$Priority = "Medium",
        [Parameter(
            HelpMessage = "Desired journal history in hours of the VPG to be created. Min 1 hour, Max 720 hours (30 days). Default is 24 hours."
        )]
        [ValidateRange(1, 720)]
        [Int]$JournalHistoryInHours = 24,
        [Parameter(
            HelpMessage = "Desired RPO alert value in seconds. Min 60 seconds, Max 86400 seconds (24 hours). Default is 300 seconds (5 minutes)."
        )]
        [ValidateRange(60, 86400)]
        [Int]$RpoInSeconds = 300,
        [Parameter(
            HelpMessage = "Desired test interval in minutes. Please review documentation for values. Default is 262080 minutes (6 months)."
        )]
        [ValidateSet(0, 43200, 131040, 262080, 394560, 525600)]
        [Int]$TestIntervalInMinutes = 262080,
        [Parameter(
            HelpMessage = "Turn on or off WAN compression. Recommended this setting is not turned off. Default is to leave WAN compression turned on."
        )]
        [Bool]$UseWanCompression = $True,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the ZCA site for the VPG to target."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$TargetSiteName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default Network (VNet) to use during a live operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$LiveNetworkName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default subnet to use during a live operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$LiveSubnetName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default Security Group to use during a live operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$LiveSecurityGroupName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default VM Instance Type to use during a live operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$LiveInstanceType,
        [Parameter(
            HelpMessage = "Type of disk to select as the default for the VPG during a live operation. Default is 'ManagedPremiumSSD'"
        )]
        [ValidateSet("UnmanagedStandard", "ManagedPremiumSSD", "ManagedStandardSSD", "ManagedStandardHDD")]
        [String]$LiveDiskType = "ManagedPremiumSSD",
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default Network (VNet) to use during a test operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$TestNetworkName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default subnet to use during a test operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$TestSubnetName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default Security Group to use during a test operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$TestSecurityGroupName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the default VM Instance Type to use during a test operation."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$TestInstanceType,
        [Parameter(
            HelpMessage = "Type of disk to select as the default for the VPG during a live operation. Default is 'ManagedPremiumSSD'"
        )]
        [ValidateSet("UnmanagedStandard", "ManagedPremiumSSD", "ManagedStandardSSD", "ManagedStandardHDD")]
        [String]$TestDiskType = "ManagedPremiumSSD"
    )

    begin {
        # Grab local site identifier and target site information and identifier
        $LocalSiteIdentifier = Get-ZertoLocalSite | Select-Object -ExpandProperty SiteIdentifier
        $TargetSiteInfo = Get-ZertoPeerSite | Where-Object { $_.PeerSiteName -match $TargetSiteName }
        $TargetSiteIdentifier = $TargetSiteInfo | Select-Object -ExpandProperty SteIdentifier

        # Validate site identifier and site type.
        if ($null -eq $TargetSiteIdentifier) {
            Write-Error "Unable to find target site with name $TargetSiteName. Please check the name and try again" -ErrorAction Stop
        } elseif ($TargetSiteInfo.SiteType -notmatch "Azure") {
            Write-Error "Specified site is not an Azure site. Please specify an Azure site and try again." -ErrorAction Stop
        }

        # Build Maps for quick lookups and validation
        $NetworksMap = GetMap -InputObject (Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -Network) -Key "VirtualNetworkName" -Value "VirtualNetworkIdentifier"
        $SubnetsMap = GetMap -InputObject (Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -Subnet) -Key "SubnetName" -Value "SubnetIdentifier"
        $SecurityGroupsMap = GetMap -InputObject (Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -SecurityGroup) -Key "SecurityGroupName" -Value "SecurityGroupIdentifier"
        $InstancesMap = GetMap -InputObject (Get-ZertoAzureResource -SiteIdentifier $TargetSiteIdentifier -VmInstanceType) -Key "VmInstanceType" -Value "IsPremiumSupported"

        # Validate instance types and ensure case insensitivity
        $TestInstanceType = $Instances.Where( { $_.VmInstanceType -match $TestInstanceType }) | Select-Object -ExpandProperty VmInstanceType
        $LiveInstanceType = $Instances.Where( { $_.VmInstanceType -match $LiveInstanceType }) | Select-Object -ExpandProperty VmInstanceType

        # Validate parameters are found at target site and Instance and Disk Types are valid
        if ($null -eq $NetworksMap[$LiveNetworkName]) {
            Write-Error "Unable to find network with name $LiveNetworkName. Please check the name and try again." -ErrorAction Stop
        } elseif ($null -eq $SubnetsMap[$LiveSubnetName]) {
            Write-Error "Unable to find subnet with name $LiveSubnetName. Please check the name and try again." -ErrorAction Stop
        } elseif ($null -eq $SecurityGroupsMap[$LiveSecurityGroupName]) {
            Write-Error "Unable to find security group with name $LiveSecurityGroupName. Please check the name and try again." -ErrorAction Stop
        } elseif ($LiveInstanceType -notin $Instances.VmInstanceType) {
            Write-Error "Unable to find a supported VM Instance Type with name $LiveInstanceType. Please check the name and try again." -ErrorAction Stop
        } elseif ($null -eq $NetworksMap[$TestNetworkName]) {
            Write-Error "Unable to find network with name $TestNetworkName. Please check the name and try again." -ErrorAction Stop
        } elseif ($null -eq $SubnetsMap[$TestSubnetName]) {
            Write-Error "Unable to find subnet with name $TestSubnetName. Please check the name and try again." -ErrorAction Stop
        } elseif ($null -eq $SecurityGroupsMap[$TestSecurityGroupName]) {
            Write-Error "Unable to find security group with name $TestSecurityGroupName. Please check the name and try again." -ErrorAction Stop
        } elseif ($TestInstanceType -notin $Instances.VmInstanceType) {
            Write-Error "Unable to find a supported VM Instance Type with name $TestInstanceType. Please check the name and try again." -ErrorAction Stop
        } elseif ($LiveDiskType -eq "ManagedPremiumSSD" -and ( -not $InstancesMap[$LiveInstanceType])) {
            Write-Error "$LiveDiskType disk type is not supported on the selected instance $LiveInstanceType. Please check your settings and try again." -ErrorAction Stop
        } elseif ($LiveDiskType -ne "ManagedPremiumSSD" -and $InstancesMap[$LiveInstanceType]) {
            Write-Error "$TestDiskType disk type is not supported on the selected instance $LiveInstanceType. Please check your settings and try again." -ErrorAction Stop
        } elseif ($TestDiskType -eq "ManagedPremiumSSD" -and ( -not $InstancesMap[$TestInstanceType])) {
            Write-Error "$TestDiskType disk type is not supported on the selected instance $TestInstanceType. Please check your settings and try again." -ErrorAction Stop
        } elseif ($TestDiskType -ne "ManagedPremiumSSD" -and $InstancesMap[$TestInstanceType]) {
            Write-Error "$TestDiskType disk type is not supported on the selected instance $TestInstanceType. Please check your settings and try again." -ErrorAction Stop
        }

        # Create the VPG Settings Identifier and get the skeleton
        $VpgSettingsIdentifier = New-ZertoVpgSettingsIdentifier -newVpg
        $Settings = Get-ZertoVpgSetting -vpgSettingsIdentifier $VpgSettingsIdentifier

        # Set the VPG Settings URI
        $VpgSettingsBaseUri = "vpgSettings/{0}" -f $VpgSettingsIdentifier

        # Populate the skeleton with the basic information
        $Settings.Basic.Name = $Name
        $Settings.Basic.Priority = $Priority
        $Settings.Basic.JournalHistoryInHours = $JournalHistoryInHours
        $Settings.Basic.ProtectedSiteIdentifier = $LocalSiteIdentifier
        $Settings.Basic.RecoverySiteIdentifier = $TargetSiteIdentifier
        $Settings.Basic.RpoInSeconds = $RpoInSeconds
        $Settings.Basic.TestIntervalInMinutes = $TestIntervalInMinutes
        $Settings.Basic.UseWanCompression = $UseWanCompression

        # Put the basic information to get am Azure Skeleton for the remainder of the default settings
        $null = Invoke-ZertoRestRequest -method PUT -uri $VpgSettingsBaseUri -body ($Settings | ConvertTo-Json -Depth 10)
        Start-Sleep -Milliseconds 500

        # Get an updated Skeleton with Azure specific settings to populate and populate them
        $Settings = Get-ZertoVpgSetting -vpgSettingsIdentifier $VpgSettingsIdentifier
        $Settings.Networks.Failover.PublicCloud.VirtualNetworkIdentifier = $NetworksMap[$LiveNetworkName]
        $Settings.Networks.Failover.PublicCloud.SubnetIdentifier = $SubnetsMap[$LiveSubnetName]
        $Settings.Networks.Failover.PublicCloud.SecurityGroupIdentifier = $SecurityGroupsMap[$LiveSecurityGroupName]
        $Settings.Networks.FailoverTest.PublicCloud.VirtualNetworkIdentifier = $NetworksMap[$TestNetworkName]
        $Settings.Networks.FailoverTest.PublicCloud.SubnetIdentifier = $SubnetsMap[$TestSubnetName]
        $Settings.Networks.FailoverTest.PublicCloud.SecurityGroupIdentifier = $SecurityGroupsMap[$TestSecurityGroupName]
        $Settings.Recovery.PublicCloud.Failover.VmInstanceType = $LiveInstanceType
        $Settings.Recovery.PublicCloud.Failover.Azure.RecoveryDiskType = $LiveDiskType
        $Settings.Recovery.PublicCloud.FailoverTest.VmInstanceType = $TestInstanceType
        $Settings.Recovery.PublicCloud.FailoverTest.Azure.RecoveryDiskType = $TestDiskType

        # Update the VPG Settings on the Server with a PUT request
        $null = Invoke-ZertoRestRequest -method PUT -uri $VpgSettingsBaseUri -body ($Settings | ConvertTo-Json -Depth 10)

        # Return the VPG Settings Identifier to use when adding VMs to the VPG.
        $VpgSettingsIdentifier
    }

    process {

    }

    end {

    }
}
