<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Edit-ZertoVra {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Identifier of the VRA to be updated."
        )]
        [Alias("vraId")]
        [string]$vraIdentifier,
        [Parameter(
            HelpMessage = "Bandwidth group to assign to the VRA. If unspecified will not modify current assignment"
        )]
        [string]$groupName,
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
        # Get the current VRA information for use if an updated parameter is not supplied
        $vra = Get-ZertoVra -vraIdentifier $vraIdentifier
    }

    process {
        # Create ordered hashtables to be converted later to JSON.
        $vraUpdate = [ordered]@{}
        $vraNetwork = [ordered]@{}
        # If a new group name is specified, update.
        if ( $PSBoundParameters.ContainsKey('GroupName')) {
            $vraUpdate['GroupName'] = $groupName
        } else {
            $vraUpdate['GroupName'] = $vra.VraGroup
        }
        # If ParameterSetName StaticIp is used, update the parameters submitted
        if ( $PSCmdlet.ParameterSetName -eq 'StaticIp' ) {
            if ( $PSBoundParameters.ContainsKey('defaultGateway') ) {
                $vraNetwork['DefaultGateway'] = $defaultGateway
            } else {
                $vraNetwork['DefaultGateway'] = $vra.VraNetworkDataApi.DefaultGateway
            }
            if ( $PSBoundParameters.ContainsKey('subnetMask') ) {
                $vraNetwork['SubnetMask'] = $subnetMask
            } else {
                $vraNetwork['SubnetMask'] = $vra.VraNetworkDataApi.SubnetMask
            }
            if ( $PSBoundParameters.ContainsKey('vraIpAddress') ) {
                $vraNetwork['VraIpAddress'] = $vraIpAddress
            } else {
                $vraNetwork['VraIpAddress'] = $vra.VraNetworkDataApi.VraIpAddress
            }
            $vraNetwork['VraIPConfigurationTypeApi'] = "Static"
            # Add network information to update object.
            $vraUpdate['VraNetworkDataApi'] = $vraNetwork
        }
        # -WhatIf processing and submit!
        if ($PSCmdlet.ShouldProcess( "Updating " + $vra.vraName + " with these settings: $($vraUpdate | convertTo-Json)")) {
            Invoke-ZertoRestRequest -uri $baseUri -body $($vraUpdate | ConvertTo-Json) -method "PUT"
        }
    }

    end {
        # Nothing to Do
    }
}
