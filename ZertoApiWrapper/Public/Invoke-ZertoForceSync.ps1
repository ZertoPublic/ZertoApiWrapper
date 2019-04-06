<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoForceSync {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to force sync",
            Mandatory = $true
        )]
        [string[]]$vpgName
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        foreach ($name in $vpgName) {
            $id = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $id ) {
                Write-Error "VPG: $name not found. Please check the name and try again. Skipping"
            } else {
                $uri = "{0}/{1}/forcesync" -f $baseUri, $id
                Invoke-ZertoRestRequest -uri $uri -method "POST"
            }
        }
    }

    end {
        #Nothing to do
    }
}
