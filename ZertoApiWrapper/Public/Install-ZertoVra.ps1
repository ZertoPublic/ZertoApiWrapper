<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Install-ZertoVra {
    [cmdletbinding( SupportsShouldProcess )]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "Host name where the VRA is to be installed."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$hostName,
        [Parameter(
            Mandatory,
            HelpMessage = "Datastore name where the VRA is to be installed."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$datastoreName,
        [Parameter(
            Mandatory,
            HelpMessage = "Network name the VRA is to be assigned."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$networkName,
        [Parameter(
            HelpMessage = "Initial amount of memory to assign to the VRA in GB. Default is 3, Minimum is 1, Maximum is 16"
        )]
        [ValidateRange(1, 16)]
        [int]$memoryInGB = 3,
        [Parameter(
            HelpMessage = "Bandwidth group to assign to the VRA. If unspecified will assign to the 'default_group'"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$groupName,
        [Parameter(
            ParameterSetName = "Dhcp",
            Mandatory,
            HelpMessage = "Assign a DHCP address to the VRA."
        )]
        [Parameter(
            ParameterSetName = "DhcpWithRoot",
            Mandatory,
            HelpMessage = "Assign a DHCP address to the VRA."
        )]
        [switch]$Dhcp,
        [Parameter(
            ParameterSetName = "StaticIp",
            Mandatory,
            HelpMessage = "Static IP address to assign to the VRA."
        )]
        [Parameter(
            ParameterSetName = "StaticIpWithRoot",
            Mandatory,
            HelpMessage = "Static IP address to assign to the VRA."
        )]
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [string]$vraIpAddress,
        [Parameter(
            ParameterSetName = "StaticIp",
            Mandatory,
            HelpMessage = "Default gateway to assign to the VRA"
        )]
        [Parameter(
            ParameterSetName = "StaticIpWithRoot",
            Mandatory,
            HelpMessage = "Default gateway to assign to the VRA"
        )]
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [string]$defaultGateway,
        [Parameter(
            ParameterSetName = "StaticIp",
            Mandatory,
            HelpMessage = "Subnetmask to be assigned to the VRA"
        )]
        [Parameter(
            ParameterSetName = "StaticIpWithRoot",
            Mandatory,
            HelpMessage = "Subnetmask to be assigned to the VRA"
        )]
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [string]$subnetMask,
        [Parameter(
            ParameterSetName = "StaticIpWithRoot",
            Mandatory,
            HelpMessage = "Use this switch to install the VRA using the root password install method."
        )]
        [Parameter(
            ParameterSetName = "DhcpWithRoot",
            Mandatory,
            HelpMessage = "Use this switch to install the VRA using the root password install method."
        )]
        [switch]$UseRootCredential,
        [Parameter(
            ParameterSetName = "StaticIpWithRoot",
            Mandatory,
            HelpMessage = "The password for the root user of the ESXi host where the VRA is to be installed."
        )]
        [Parameter(
            ParameterSetName = "DhcpWithRoot",
            Mandatory,
            HelpMessage = "The password for the root user of the ESXi host where the VRA is to be installed."
        )]
        [ValidateNotNullOrEmpty()]
        [securestring]$HostRootPassword
    )

    begin {

    }
    Process {
        # Build the VRA Name.
        $vraName = "Z-VRA-{0}" -f $hostName
        # If the VRA does not exist, proceed with the installation. If it does exist, bypass and
        if ( -not (Get-ZertoVra -vraName $vraName) ) {
            # Get identifiers for each item provided by name.
            $siteIdentifier = (Get-ZertoLocalSite).SiteIdentifier
            $hostIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -hosts | Where-Object { $_.VirtualizationHostName -eq $hostName } | Select-Object hostIdentifier -ExpandProperty hostIdentifier
            $networkIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -networks | Where-Object { $_.VirtualizationNetworkName -eq $networkName } | Select-Object NetworkIdentifier -ExpandProperty NetworkIdentifier
            $datastoreIdentifier = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -datastores | Where-Object { $_.DatastoreName -eq $datastoreName } | Select-Object DatastoreIdentifier -ExpandProperty DatastoreIdentifier
            if ($datastoreIdentifier.count -gt 1) {
                $hostDevices = Get-ZertoVirtualizationSite -siteIdentifier $siteIdentifier -devices -hostIdentifier $hostIdentifier
                $datastoreIdentifier = foreach ($identifier in $datastoreIdentifier) {
                    if ($identifier -in $hostDevices.DatastoreIdentifier) {
                        $identifier
                    }
                }
                if ($datastoreIdentifier.count -gt 1) {
                    Write-Error "Datastore $datastoreName has more than one identifier associated with it on the specified host. Please review and try again."
                    Break
                }
            }

            # Build the JSON object through an Ordered Hashtable.
            $vraBasic = [ordered]@{ }
            $vraBasic['DatastoreIdentifier'] = $datastoreIdentifier.toString()
            if ($PSBoundParameters.ContainsKey('groupName')) {
                $vraBasic['GroupName'] = $groupName
            }
            $vraBasic['HostIdentifier'] = $hostIdentifier.toString()
            $vraBasic['MemoryInGB'] = $memoryInGB
            $vraBasic['NetworkIdentifier'] = $networkIdentifier.toString()
            $vraBasic['UsePublicKeyInsteadOfCredentials'] = $true
            $vraBasicNetwork = [ordered]@{ }
            if ( $PSCmdlet.ParameterSetName -eq "StaticIp" -or $PSCmdlet.ParameterSetName -eq "StaticIpWithRoot") {
                $vraBasicNetwork['DefaultGateway'] = $defaultGateway.toString()
                $vraBasicNetwork['SubnetMask'] = $subnetMask.toString()
                $vraBasicNetwork['VraIPAddress'] = $vraIpAddress.toString()
                $vraBasicNetwork['VraIPConfigurationTypeApi'] = "Static"
            } else {
                $vraBasicNetwork['VraIPConfigurationTypeApi'] = "Dhcp"
            }
            $vraBasic['VraNetworkDataApi'] = $vraBasicNetwork
            if ($PSCmdlet.ParameterSetName -eq "StaticIpWithRoot" -or $PSCmdlet.ParameterSetName -eq "DhcpWithRoot") {
                $HostRootCredential = [pscredential]::new('root', $HostRootPassword)
                $vraBasic['UsePublicKeyInsteadOfCredentials'] = $false
                $vraBasic['HostRootPassword'] = $HostRootCredential.GetNetworkCredential().Password
            }

            # Leverage WhatIf functionality to see what might happen, if WhatIf is not specified, attempt to install.
            if ($PSCmdlet.ShouldProcess($hostName)) {
                Invoke-ZertoRestRequest -uri "vras" -method POST -body $($vraBasic | ConvertTo-Json)
            }
        } else {
            Write-Error "Host $hostName already has a VRA installed. Aborting Install Call"
        }
    }

    End {

    }
}
