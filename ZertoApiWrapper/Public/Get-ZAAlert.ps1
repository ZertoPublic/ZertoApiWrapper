<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAAlert {
    [cmdletbinding( DefaultParameterSetName = "zOrg")]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter the alert list. If the ZORG identifier is omitted, a list of all the alerts is retrieved.",
            ParameterSetName = "zOrg"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier,
        [Parameter(
            HelpMessage = "The maximum number of alerts to return.",
            ParameterSetName = "zOrg"
        )]
        [ValidateRange(1, 1000000)]
        [int]$limitTo,
        [Parameter(
            HelpMessage = "The VPG Idnetifier",
            ParameterSetName = "alertId"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$alertIdentifier
    )
    $uri = "monitoring/alerts"
    switch ($PSCmdlet.ParameterSetName) {
        zOrg {
            if ( $PSBoundParameters.Keys.Count -gt 0 ) {
                $filterString = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $uri, $filterString
            }
        }

        alertId {
            $uri = "{0}/{1}" -f $uri, $alertIdentifier
        }
    }
    Invoke-ZARestRequest -uri $uri
}
