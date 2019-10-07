<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function New-ZertoPairingToken {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (

    )

    begin {

    }

    process {
        $uri = "peersites/generatetoken"
        $body = @{ }
        if ($PSCmdlet.ShouldProcess("Obtaining Pairing token from $script:zvmServer")) {
            Invoke-ZertoRestRequest -uri $uri -method "POST" -body $($body | ConvertTo-Json)
        }
    }

    end {

    }
}
