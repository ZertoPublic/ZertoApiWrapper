function New-ZertoVpgSettingsIdentifier {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Identifier of the VPG to create a VPG settings identifier. If a vpgIdentifier is not provided, a new VPG settings object is created without any configured settings. This would be used for creating a new VPG from scratch."
        )]
        [string]$vpgIdentifier = $null
    )

    begin {
        $baseUri = "vpgSettings"
        if ($null -eq $vpgIdentifier) {
            $body = "{}"
        } else {
            $body = "{""VpgIdentifier"":""$vpgIdentifier""}"
        }
    }

    process {
        Invoke-ZertoRestRequest -uri $baseUri -body $body -Method "POST"
    }

    end {

    }
}