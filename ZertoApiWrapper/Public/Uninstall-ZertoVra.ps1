<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Uninstall-ZertoVra {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Host Name attached to the VRA to be removed."
        )]
        [string[]]$hostName
    )

    begin {
        $baseUri = "vras"
    }

    process {
        foreach ($name in $hostName) {
            $vraName = "Z-VRA-{0}" -f $name
            $vraIdentifier = get-zertovra -vraName $vraName | Select-Object vraIdentifier -ExpandProperty vraIdentifier
            if ( -not $vraIdentifier ) {
                Write-Error "Host: $hostName either does not have a VRA or was not found. Please check the name and try again. Skipping."
            } else {
                $uri = "{0}/{1}" -f $baseUri, $vraIdentifier.toString()
                Invoke-ZertoRestRequest -uri $uri -method "DELETE"
            }
            if ($hostName.Count -gt 1) {
                Start-Sleep 1
            }
        }
    }

    end {

    }
}
