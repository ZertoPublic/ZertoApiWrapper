<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoPeerSite {
    [cmdletbinding( defaultParameterSetName = "main" )]
    param (
        [Parameter(
            ParameterSetName = "pairingStatuses",
            HelpMessage = "Switch to return possible paiting statuses.",
            Mandatory = $true
        )]
        [switch]$pairingStatuses,
        [Parameter(
            ParameterSetName = "siteIdentifier",
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The identifier(s) of the peer site(s) for which information is to be returned."
        )]
        [Alias("siteId")]
        [string[]]$siteIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of a peer site for which information is to be returned. The name is case-sensitive."
        )]
        [string]$peerName,
        [Parameter (
            ParameterSetName = "filter",
            HelpMessage = "The pairing status for which information is to be returned."
        )]
        [string]$paringStatus,
        [Parameter (
            ParameterSetName = "filter",
            HelpMessage = "The site location, as specified in the site information, for which information is to be returned."
        )]
        [string]$location,
        [Parameter (
            ParameterSetName = "filter",
            HelpMessage = "The IP address of a Zerto Virtual Manager, paired with this site, for which information is to be returned."
        )]
        [string]$hostName,
        [Parameter (
            ParameterSetName = "filter",
            HelpMessage = "The port used to access peer sites for which information is to be returned. The default port is 9081."
        )]
        [string]$port
    )

    begin {
        $baseUri = "peersites"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $uri = "{0}" -f $baseUri
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }

            "siteIdentifier" {
                foreach ( $id in $siteIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results) | Out-Null
                }
            }

            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }

            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName.ToLower()
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }
        }
    }

    end {
        return $returnObject
    }
}
