function Edit-ZertoVra {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Identifier of the VRA to be updated."
        )]
        [Alias("Identifier")]
        [string]$vraIdentifier,
        [Parameter(
            HelpMessage = "Bandwidth group to assign to the VRA. If unspecified will not modify current assignment"
        )]
        [string]$groupName,
        [Parameter(
            ParameterSetName = "Dhcp",
            Mandatory = $true,
            HelpMessage = "Assign a DHCP address to the VRA."
        )]
        [switch]$Dhcp,
        [Parameter(
            ParameterSetName = "StaticIp",
            HelpMessage = "Static IP address to assign to the VRA."
        )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$vraIpAddress,
        [Parameter(
            ParameterSetName = "StaticIp",
            HelpMessage = "Default gateway to assign to the VRA"
        )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$defaultGateway,
        [Parameter(
            ParameterSetName = "StaticIp",
            HelpMessage = "Subnetmask to be assigned to the VRA"
        )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$subnetMask

    )

    begin {
        $baseUri = "vras/{0}" -f $vraIdentifier
        $vra = Get-ZertoVra -vraIdentifier $vraIdentifier
    }

    process {
        $vraUpdate = [ordered]@{}
        $vraNetwork = [ordered]@{}
        if ( $PSBoundParameters.ContainsKey('GroupName')) {
            $vraUpdate['GroupName'] = $vra.VraGroup
        }
        if ( $PSCmdlet.ParameterSetName -eq 'Dhcp' ) {
            $vraNetwork['VraIPConfigurationTypeApi'] = "Dhcp"
            $vraUpdate['VraNetworkDataApi'] = $vraNetwork
        } elseif ( $PSCmdlet.ParameterSetName -eq 'StaticIp' ) {
            if ( $PSBoundParameters.ContainsKey('defaultGateway') ) {
                $vraUpdate['DefaultGateway'] = $defaultGateway
            } else {
                $vraUpdate['DefaultGateway'] = $vra.VraNetworkDataApi.DefaultGateway
            }
            if ( $PSBoundParameters.ContainsKey('subnetMask') ) {
                $vraUpdate['SubnetMask'] = $subnetMask
            } else {
                $vraUpdate['SubnetMask'] = $vra.VraNetworkDataApi.SubnetMask
            }
            if ( $PSBoundParameters.ContainsKey('vraIpAddress') ) {
                $vraUpdate['VraIpAddress'] = $vraIpAddress
            } else {
                $vraUpdate['VraIpAddress'] = $vra.VraNetworkDataApi.VraIpAddress
            }
            $vraNetwork['VraIPConfigurationTypeApi'] = "Static"
            $vraUpdate['VraNetworkDataApi'] = $vraNetwork
        }
        Invoke-ZertoRestRequst -uri $baseUri -body $($vraUpdate | ConvertTo-Json) -method "PUT"
    }

    end {
        # Nothing to Do
    }
}
