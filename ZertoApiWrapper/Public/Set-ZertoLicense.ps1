<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Set-ZertoLicense {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param (
        [Parameter(
            Mandatory,
            HelpMessage = "License Key to apply to the Zerto Virtual Manager"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$licenseKey
    )

    begin {
        $baseUri = "license"
        $body = @{"LicenseKey" = $licenseKey }
    }

    process {
        if ($PSCmdlet.ShouldProcess("Applying License Key: $licenseKey to server: $($script:zvmServer)")) {
            Invoke-ZertoRestRequest -uri $baseUri -body $($body | ConvertTo-Json) -method "PUT"
        }
    }

    end {
        # Nothing to do
    }
}
