<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Save-ZertoVpgSetting {
    [cmdletbinding(
        SupportsShouldProcess = $true
    )]
    param(
        [Parameter(
            HelpMessage = "VpgSettings Identifier to save",
            Mandatory,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgSettingsId")]
        [string]$vpgSettingsIdentifier
    )

    Begin {
    }

    Process {
        $baseUri = "vpgsettings/{0}/commit" -f $vpgSettingsIdentifier
        if ($PSCmdlet.ShouldProcess("Commiting VPG Settings with Settigns identifier $vpgSettingsIdentifier")) {
            Invoke-ZertoRestRequest -uri $baseUri -method "POST"
        }
    }

    End {
    }
}
