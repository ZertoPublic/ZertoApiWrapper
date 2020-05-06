<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Add-ZertoPeerSite {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [parameter(
            Mandatory,
            HelpMessage = "Target Hostname or IP address to pair the localsite to."
        )]
        [ValidateScript( { $_ -match [IPAddress]$_ } )]
        [string]$targetHost,
        [Parameter(
            HelpMessage = "Target communication port. Default is 9081"
        )]
        [ValidateRange(1024, 65535)]
        [int]$targetPort = 9081,
        [Parameter(
            HelpMessage = "The generated token from the destination site. Note: This is only supported when both sites support pairing authentication. This was implemented to support ZVR 7.5 and later."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$token
    )

    begin {
    }

    process {
        $baseUri = "peersites"
        if ($PSBoundParameters.Keys.Contains("token")) {
            $body = @{ "HostName" = $targetHost; "Port" = $targetPort; "Token" = $token }
        } else {
            $body = @{ "HostName" = $targetHost; "Port" = $targetPort }
        }
        if ($PSCmdlet.ShouldProcess("Pairing with Site $targetHost")) {
            Invoke-ZertoRestRequest -uri $baseUri -body $($body | ConvertTo-Json) -method "POST"
        }
    }

    end {
        # Nothing to do
    }
}
