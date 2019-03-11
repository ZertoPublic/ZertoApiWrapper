function Save-ZertoVpgSettings {
    [cmdletbinding(
        SupportsShouldProcess = $true
    )]
    param(
        [Parameter(
            HelpMessage = "VpgSettings Identifier to save",
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$vpgSettingsIdentifier
    )

    $baseUri = "vpgsettings/{0}/commit" -f $vpgSettingsIdentifier
    if ($PSCmdlet.ShouldProcess("Commiting VPG Settings with Settigns identifier $vpgSettingsIdentifier")) {
        Invoke-ZertoRestRequest -uri $baseUri -method "POST"
    }
}