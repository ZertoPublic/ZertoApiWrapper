<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Add-ZertoPeerSite {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [parameter(
            Mandatory = $true,
            HelpMessage = "Target Hostname or IP address to pair the localsite to."
        )]
        [string]$targetHost,
        [Parameter(
            HelpMessage = "Target communication port. Default is 9081"
        )]
        [int]$targetPort = 9081
    )

    begin {
        $baseUri = "peersites"
        $body = @{"HostName" = $targetHost; "Port" = $targetPort}
    }

    process {
        if ($PSCmdlet.ShouldProcess("Pairing with Site $targetHost")) {
            Invoke-ZertoRestRequest -uri $baseUri -body $($body | ConvertTo-Json) -method "POST"
        }
    }

    end {
        # Nothing to do
    }
}