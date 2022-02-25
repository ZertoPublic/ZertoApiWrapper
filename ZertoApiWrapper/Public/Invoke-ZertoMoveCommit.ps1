<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoMoveCommit {
    [cmdletbinding(SupportsShouldProcess = $true, DefaultParameterSetName = "Main")]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) to commit.",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName,
        [Parameter(
            HelpMessage = "Use this switch to reverse protect the VPG(s) to the source site. If neither 'ReverseProtction' nor 'KeepSourceVms' switch is specified, the commit process will use selection made during move initiation.",
            ParameterSetName = 'ReverseProtect',
            Mandatory

        )]
        [switch]$reverseProtection,
        [Parameter(
            HelpMessage = "Use this switch to keep the source VMs at the source site. If neither 'ReverseProtction' nor 'KeepSourceVms' switch is specified, the commit process will use selection made during move initiation.",
            ParameterSetName = 'KeepSource',
            Mandatory
        )]
        [switch]$keepSourceVms
    )

    begin {
        $baseUri = "vpgs"
        $body = @{ }
        Switch ($PSCmdlet.ParameterSetName){
            'KeepSource' {
                $body["KeepSourceVms"] = $true
                $body["ReverseProtection"] = $false
            }

            'ReverseProtect' {
                $body["ReverseProtection"] = $true
                $body["KeepSourceVms"] = $false
            }
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
