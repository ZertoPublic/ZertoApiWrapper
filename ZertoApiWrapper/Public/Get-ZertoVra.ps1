function Get-ZertoVra {
    [cmdletbinding(
        DefaultParameterSetName = "main"
    )]
    param(
        [Parameter(
            ParameterSetName = "ipConfigurationTypes",
            HelpMessage = "Returns Valid VRA IP configuration types"
        )]
        [switch]$ipconfigurationtypes,
        [Parameter(
            ParameterSetName = "statuses",
            HelpMessage = "Returns Valid VRA statuses"
        )]
        [switch]$statuses,
        [Parameter(
            ParameterSetName = "vraIdentifier",
            HelpMessage = "Returns information for provided VRA identifier(s)"
        )]
        [string[]]$vraIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "VRA Name to return information for."
        )]
        [string]$vraName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for VRAs in a specific status"
        )]
        [string]$status,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for VRAs of a specific version"
        )]
        [string]$vraVersion,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for VRAs paired to a specific host version"
        )]
        [string]$hostVersion,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for a VRA with the specified IP address"
        )]
        [string]$ipAddress,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for VRAs belonging to a specific group"
        )]
        [string]$vraGroup,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for VRAs on a specific datastore"
        )]
        [string]$datastoreName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for VRAs on a specific datastore cluster"
        )]
        [string]$datastoreClusterName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Search for VRAs on a specific network"
        )]
        [string]$networkName
    )

    begin {
        $baseUri = "vras"
        $returnObject = @()
    }

    process {

        # Process based on ParameterSetName
        switch ( $PSCmdlet.ParameterSetName ) {

            # When called without params, return all VRAs
            "main" {
                $uri = $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # When vra ids are provided, return for each id provided
            "vraIdentifierifier" {
                $returnObject = foreach ( $vraId in $vraIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $vraId
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # When filter is requested, search based on provided data.
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # When a different ParameterSetName is requested, query against that name
            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName.ToLower()
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
