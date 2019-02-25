#TODO - Add ability to installed with root password.
function Install-ZertoVra {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter( Mandatory = $true, HelpMessage = "Host name where the VRA is to be installed." )]
        [string]$hostName,
        [Parameter( Mandatory = $true, HelpMessage = "Datastore name where the VRA is to be installed." )]
        [string]$datastoreName,
        [Parameter( Mandatory = $true, HelpMessage = "Network name the VRA is to be assigned." )]
        [string]$networkName,
        [Parameter( HelpMessage = "Initial amount of memory to assign to the VRA in GB. Default is 3, Minimum is 1, Maximum is 16" )]
        [ValidateRange(1, 16)]
        [int]$memoryInGB = 3,
        [Parameter( HelpMessage = "Bandwidth group to assign to the VRA. If unspecified will assign to the 'default_group'" )]
        [string]$groupName,
        [Parameter( ParameterSetName = "Dhcp", Mandatory = $true, HelpMessage = "Assign a DHCP address to the VRA." )]
        [switch]$Dhcp,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true, HelpMessage = "Static IP address to assign to the VRA." )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$vraIpAddress,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true, HelpMessage = "Default gateway to assign to the VRA" )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$defaultGateway,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true, HelpMessage = "Subnetmask to be assigned to the VRA" )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$subnetMask

    )
    # Build the VRA Name.
    $vraName = "Z-VRA-{0}" -f $hostName
    # If the VRA does not exist, proceed with the installation. If it does exist, bypass and
    if ( -not (Get-ZertoVra -vraName $vraName) ) {
        # Get identifiers for each item provided by name.
        $siteIdentifier = $script:zvmLocalInfo.SiteIdentifier
        $hostIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -hosts | Where-Object {$_.VirtualizationHostName -eq $hostName} | Select-Object hostIdentifier -ExpandProperty hostIdentifier
        $networkIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -networks | Where-Object {$_.VirtualizationNetworkName -eq $networkName} | Select-Object NetworkIdentifier -ExpandProperty NetworkIdentifier
        $datastoreIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -datastores | Where-Object {$_.DatastoreName -eq $datastoreName} | Select-Object DatastoreIdentifier -ExpandProperty DatastoreIdentifier

        # Build the JSON object through an Ordered Hashtable.
        $vraBasic = [ordered]@{}
        $vraBasic['DatastoreIdentifier'] = $datastoreIdentifier.toString()
        if ($PSBoundParameters.ContainsKey('groupName')) {
            $vraBasic['GroupName'] = $groupName
        }
        $vraBasic['HostIdentifier'] = $hostIdentifier.toString()
        $vraBasic['MemoryInGB'] = $memoryInGB
        $vraBasic['NetworkIdentifier'] = $networkIdentifier.toString()
        $vraBasic['UsePublicKeyInsteadOfCredentials'] = $true
        $vraBasicNetwork = [ordered]@{}
        if ( $PSCmdlet.ParameterSetName -eq "StaticIp" ) {
            $vraBasicNetwork['DefaultGateway'] = $defaultGateway.toString()
            $vraBasicNetwork['SubnetMask'] = $subnetMask.toString()
            $vraBasicNetwork['VraIPAddress'] = $vraIpAddress.toString()
            $vraBasicNetwork['VraIPConfigurationTypeApi'] = "Static"
        } else {
            $vraBasicNetwork['VraIPConfigurationTypeApi'] = "Dhcp"
        }
        $vraBasic['VraNetworkDataApi'] = $vraBasicNetwork

        # Leverage WhatIf functionality to see what might happen, if WhatIf is not specified, attempt to install.
        if ($PSCmdlet.ShouldProcess("Preforming operation 'Install-Vra' on Host $hostName with the following data \n $($vraBasic | convertto-json)")) {
            Invoke-ZertoRestRequest -uri "vras" -method POST -body $($vraBasic | ConvertTo-Json)
        }
    } else {
        Write-Error "Host $hostName already has a VRA installed. Aborting Install Call"
    }
}
