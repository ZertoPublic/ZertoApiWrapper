<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoFailoverCommit {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) to commit.",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName,
        [Parameter(
            HelpMessage = "Use this switch to reverse protect the VPG(s) to the source site."
        )]
        [switch]$reverseProtection
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        if ( $reverseProtection.IsPresent ) {
            $body = @{"IsReverseProtection" = $true }
        } else {
            $body = @{"IsReverseProtection" = $false }
        }
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $vpgId ) {
                Write-Error "VPG: $name could not be found. Please check the name and try again. Skipping."
            } else {
                $uri = "{0}/{1}/FailoverCommit" -f $baseUri, $vpgId
                if ($PSCmdlet.ShouldProcess($body, $uri)) {
                    Invoke-ZertoRestRequest -uri $uri -body $($body | convertto-json) -method "POST"
                }
            }
        }
    }

    end {
        # Nothing to do
    }
}
