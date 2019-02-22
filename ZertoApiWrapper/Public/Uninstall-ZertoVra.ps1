function Uninstall-ZertoVra {
    [cmdletbinding()]
    param(
        [Parameter( Mandatory = $true )]
        [string[]]$hostName
    )

    begin {
        $baseUri = "vras"
    }

    process {
        foreach ($name in $hostName) {
            $vraName = "Z-VRA-{0}" -f $name
            $vraIdentifier = get-zertovra -vraName $vraName | Select-Object vraIdentifier -ExpandProperty vraIdentifier
            $uri = "{0}/{1}" -f $baseUri, $vraIdentifier.toString()
            Invoke-ZertoRestRequest -uri $uri -method "DELETE"
        }
    }

    end {

    }
}
