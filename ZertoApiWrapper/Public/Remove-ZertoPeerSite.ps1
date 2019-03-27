<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Remove-ZertoPeerSite {
    [cmdletbinding(
        SupportsShouldProcess = $true,
        DefaultParameterSetName = "siteIdentifier"
    )]
    param (
        [Parameter(
            HelpMessage = "Identifier of the site to be removed from the connected site",
            ParameterSetName = "siteIdentifier",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [Alias("siteId")]
        [string[]]$siteIdentifier,
        [Parameter(
            HelpMessage = "Name of the peer site to be removed from the connected site",
            ParameterSetName = "peerSiteName",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [string[]]$peerSiteName,
        [Parameter(
            HelpMessage = "IP address of the peer site to be removed from the connected site",
            ParameterSetName = "hostName",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string[]]$hostName,
        [Parameter(
            HelpMessage = "Specify this switch to Keep the target replica disks for any VPGs replicating between the sites as the VPGs will be deleted by unpairing the sites. If this switch is not used, the target replica disks will be deleted"
        )]
        [switch]$keepTargetDisks
    )

    begin {
        $baseUri = "peersites"
        $body = @{}
        if ( $keepTargetDisks ) {
            $body['IsKeepTargetDisks'] = $true
        } else {
            $body['IsKeepTargetDisks'] = $false
        }
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "peerSiteName" {
                $siteIdentifier = @()
                $siteIdentifier = foreach ($site in $peerSiteName) {
                    $(Get-ZertoPeerSite -peerName $site).siteIdentifier
                }
            }

            "hostName" {
                $siteIdentifier = @()
                $siteIdentifier = foreach ($name in $hostName) {
                    $(Get-ZertoPeerSite -hostName $name).siteIdentifier
                }
            }
        }

        foreach ($id in $siteIdentifier) {
            $uri = "{0}/{1}" -f $baseUri, $id
            if ($PSCmdlet.ShouldProcess("Removing siteIdentifier $id")) {
                Invoke-ZertoRestRequest -uri $uri -body $($body | ConvertTo-Json) -Method "DELETE"
            }
        }

    }

    end {
        # Nothing to do
    }
}