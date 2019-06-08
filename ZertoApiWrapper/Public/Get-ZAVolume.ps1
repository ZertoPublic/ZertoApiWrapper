<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAVolume {
    [CmdletBinding(DefaultParameterSetName = "VpgIdentifier")]
    param (
        [Parameter(
            HelpMessage = "The site identifier. The site identifier is mandatory if vpgIdentifier is not entered.",
            Mandatory,
            ParameterSetName = "SiteAndClusterIdentifier"
        )]
        [Parameter(
            HelpMessage = "The site identifier. The site identifier is mandatory if vpgIdentifier is not entered.",
            Mandatory,
            ParameterSetName = "SiteAndDatastoreIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$siteIdentifier,
        [Parameter(
            HelpMessage = "The cluster identifier. If a cluster identifier is not entered, you must enter a datastore identifier.",
            Mandatory,
            ParameterSetName = "SiteAndClusterIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$clusterIdentifier,
        [Parameter(
            HelpMessage = "The datastore identifer. If a datastore identifier is not entered, you must enter a cluster identifier.",
            Mandatory,
            ParameterSetName = "SiteAndDatastoreIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$datastoreIdentifier,
        [Parameter(
            HelpMessage = "The vpg identifer.",
            Mandatory,
            ParameterSetName = "VpgIdentifier"
        )]
        [string]$vpgIdentifier

    )

    $filter = Get-ZertoApiFilter -FilterTable $PSBoundParameters
    $uri = "monitoring/volumes{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
