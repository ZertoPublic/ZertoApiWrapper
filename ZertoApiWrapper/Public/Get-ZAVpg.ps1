<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAVpg {
    [cmdletbinding(DefaultParameterSetName = 'zOrg')]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter the VPG list. If the ZORG identifier is omitted, a list of all VPGs is retrieved.",
            ParameterSetName = 'zOrg'
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier,
        [Parameter(
            HelpMessage = "The VPG Identifier",
            ParameterSetName = "vpg",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgIdentifier
    )
    $uri = "monitoring/vpgs"

    switch ($PSCmdlet.ParameterSetName) {
        zOrg {
            if ( -not [String]::IsNullorEmpty($zOrgIdentifier) ) {
                $filterTable = @{"zOrgIdentifier" = $zOrgIdentifier }
                $filterString = Get-ZertoApiFilter -filterTable $filterTable
                $uri = "{0}{1}" -f $uri, $filterString
            }
        }

        vpg {
            $uri = "{0}/$vpgIdentifier" -f $uri
        }
    }

    Invoke-ZARestRequest -uri $uri
}
