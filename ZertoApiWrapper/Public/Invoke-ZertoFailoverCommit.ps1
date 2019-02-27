function Invoke-ZertoFailoverCommit {
    [cmdletbiding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) to commit.",
            Mandatory = $true
        )]
        [string[]]$vpgName,
        [Parameter(
            HelpMessage = "Use this switch to reverse protect the VPG(s) to the source site."
        )]
        [switch]$reverseProtect
    )

    begin {
        $baseUri = "vpgs"
        if ( $reverseProtect ) {
            $body = @{"IsReverseProtect" = $true}
        } else {
            $body = @{"IsReverseProtect" = $false}
        }
    }

    process {
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            $uri = "{0}/{1}/FailoverCommit" -f $baseUri, $vpgId
            Invoke-ZertoRestRequest -uri $uri -body $($body | convertto-json) -method "POST"
        }
    }

    end {
        # Nothing to do
    }
}