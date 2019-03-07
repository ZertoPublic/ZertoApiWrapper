<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoMoveCommit {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) to commit.",
            Mandatory = $true
        )]
        [string[]]$vpgName,
        [Parameter(
            HelpMessage = "Set this to True to reverse protect the VPG(s) to the source site. If not set, will use selection made during move initiation. True or False"
        )]
        [bool]$reverseProtect,
        [Parameter(
            HelpMessage = "Use this switch to keep the source VMs. If not set, they will be destroyed."
        )]
        [switch]$keepSourceVms
    )

    begin {
        $baseUri = "vpgs"
        if ($reverseProtect) {
            $body = @{"ReverseProtection" = $reverseProtect; "KeepSourceVms" = $keepSourceVms}
        } else {
            $body = @{"KeepSourceVms" = $keepSourceVms}
        }
    }

    process {
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            $uri = "{0}/{1}/MoveCommit" -f $baseUri, $vpgId
            Invoke-ZertoRestRequest -uri $uri -body $($body | convertto-json) -method "POST"
        }
    }

    end {
        # Nothing to do
    }
}