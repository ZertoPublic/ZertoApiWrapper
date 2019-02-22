function Install-ZertoVra {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter( Mandatory = $true )]
        [string]$hostName,
        [Parameter( Mandatory = $true )]
        [string]$datastoreName,
        [Parameter( Mandatory = $true )]
        [string]$networkName,
        [Parameter( HelpMessage = "Initial amount of memory to assign to the VRA in GB. Minimum is 1, Maximum is 16" )]
        [ValidateRange(1, 16)]
        [int]$memoryInGB = 3,
        [Parameter()]
        [string]$groupName,
        [Parameter( ParameterSetName = "Dhcp", Mandatory = $true )]
        [switch]$Dhcp,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$vraIpAddress,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$defaultGateway,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$subnetMask

    )
    #TODO - Test to see if VRA already exists!
    $vraName = "Z-VRA-{0}" -f $hostName
    if ( -not (Get-ZertoVra -vraName $vraName) ) {
        $siteIdentifier = $script:zvmLocalInfo.SiteIdentifier
        $hostIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -hosts | Where-Object {$_.VirtualizationHostName -eq $hostName} | Select-Object hostIdentifier -ExpandProperty hostIdentifier
        $networkIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -networks | Where-Object {$_.VirtualizationNetworkName -eq $networkName} | Select-Object NetworkIdentifier -ExpandProperty NetworkIdentifier
        $datastoreIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -datastores | Where-Object {$_.DatastoreName -eq $datastoreName} | Select-Object DatastoreIdentifier -ExpandProperty DatastoreIdentifier
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
        if ($PSCmdlet.ShouldProcess("Preforming operation 'Install-Vra' on Host $hostName with the following data \n $($vraBasic | convertto-json)")) {
            Invoke-ZertoRestRequest -uri "vras" -method POST -body $($vraBasic | ConvertTo-Json)
        }
    } else {
        Write-Error "Host $hostName already has a VRA installed. Aborting Install Call"
    }
}
