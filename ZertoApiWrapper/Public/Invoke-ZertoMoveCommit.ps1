<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoMoveCommit {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) to commit.",
            Mandatory = $true
        )]
        [string[]]$vpgName,
        [Parameter(
            HelpMessage = "Set this to True to reverse protect the VPG(s) to the source site. If not set, will use selection made during move initiation. True or False"
        )]
        [switch]$reverseProtection,
        [Parameter(
            HelpMessage = "Use this switch to keep the source VMs. If not set, they will be destroyed."
        )]
        [switch]$keepSourceVms
    )

    begin {
        $baseUri = "vpgs"
        $body = @{}
        if ($reverseProtection) {
            $body["ReverseProtection"] = $true
        } elseif ($keepSourceVms) {
            $body["KeepSourceVms"] = $true
        }
    }

    process {
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $vpgId ) {
                Write-Error "VPG: $name not found. Please check the name and try again. Skipping."
            } else {
                $uri = "{0}/{1}/MoveCommit" -f $baseUri, $vpgId
                if ($PSCmdlet.ShouldProcess("Commiting VPG: $name with settings $($body | convertto-json)")) {
                    Invoke-ZertoRestRequest -uri $uri -body $($body | convertto-json) -method "POST"
                }
            }
        }
    }

    end {
        # Nothing to do
    }
}