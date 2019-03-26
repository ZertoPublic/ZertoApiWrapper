function New-ZertoVpgSettingsIdentifier {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Identifier of the VPG to create a VPG settings identifier. If a vpgIdentifier is not provided, a new VPG settings object is created without any configured settings. This would be used for creating a new VPG from scratch.",
            ParameterSetName = "existingVpg",
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("vpgId")]
        [string]$vpgIdentifier,
        [Parameter(
            HelpMessage = "Use this switch when creating a vpgSettingsIdentifier for a new VPG",
            ParameterSetName = "newVpg",
            Mandatory = $true
        )]
        [switch]$newVpg
    )

    begin {
        $baseUri = "vpgSettings"
        switch ($PSCmdlet.ParameterSetName) {
            "newVpg" {
                $body = "{}"
            }

            "existingVpg" {
                $body = "{""VpgIdentifier"":""$vpgIdentifier""}"
            }
        }
    }

    process {
        Invoke-ZertoRestRequest -uri $baseUri -body $body -Method "POST"
    }

    end {

    }
}
