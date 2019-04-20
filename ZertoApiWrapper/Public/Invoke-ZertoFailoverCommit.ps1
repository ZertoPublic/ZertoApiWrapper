<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoFailoverCommit {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) to commit.",
            Mandatory = $true
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
        if ( $reverseProtection ) {
            $body = @{"IsReverseProtection" = $true}
        } else {
            $body = @{"IsReverseProtection" = $false}
        }
    }

    process {
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $vpgId ) {
                Write-Error "VPG: $name could not be found. Please check the name and try again. Skipping."
            } else {
                $uri = "{0}/{1}/FailoverCommit" -f $baseUri, $vpgId
                Invoke-ZertoRestRequest -uri $uri -body $($body | convertto-json) -method "POST"
            }
        }
    }

    end {
        # Nothing to do
    }
}
