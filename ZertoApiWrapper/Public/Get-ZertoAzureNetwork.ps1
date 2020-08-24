<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoAzureNetwork {
    [CmdletBinding(DefaultParameterSetName = "SiteName")]
    param (
        [Parameter(
            Mandatory,
            HelpMessage = "Name the Azure Site you wish to get the Networks.",
            ParameterSetName = "SiteName"
        )]
        [ValidateNotNullOrEmpty()]
        [String]$SiteName,
        [Parameter(
            Mandatory,
            HelpMessage = "Site Identifier of the Azure Site you wish to get the Networks.",
            ParameterSetName = "SiteIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [String]$SiteIdentifier
    )

    begin {

    }

    process {
        if ($PSCmdlet.ParameterSetName -match "SiteName") {
            $SiteInfo = Get-ZertoPeerSite | Where-Object { $_.PeerSiteName -match $SiteName }
            if ($null -eq $SiteInfo) {
                Write-Error "Unable to find a peer site with the name $SiteName. Please check your parameters and try again." -ErrorAction Stop
            }
            $SiteIdentifier = $SiteInfo | Select-Object -ExpandProperty SiteIdentifier
        } else {
            $SiteInfo = Get-ZertoPeerSite -siteIdentifier $SiteIdentifier
        }
        if ($SiteInfo.SiteType -notmatch "Azure") {
            Write-Error "Specified site is not an Azure site. Please specify an Azure site and try again." -ErrorAction Stop
        }
        $uri = "virtualizationsites/{0}/publicCloud/virtualNetworks" -f $SiteIdentifier
        Invoke-ZertoRestRequest -uri $uri
    }

    end {

    }
}
