<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Suspend-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to pause replication",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        foreach ($name in $vpgName) {
            $id = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $id ) {
                Write-Error "VPG: $name not found. Skipping."
            } else {
                $uri = "{0}/{1}/pause" -f $baseUri, $id
                Invoke-ZertoRestRequest -uri $uri -method "POST"
            }
        }
    }

    end {
        #Nothing to do
    }
}
