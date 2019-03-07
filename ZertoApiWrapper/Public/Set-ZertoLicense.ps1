<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Set-ZertoLicense {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = "License Key to apply to the Zerto Virtual Manager"
        )]
        [string]$licenseKey
    )

    begin {
        $baseUri = "license"
        $body = @{"LicenseKey" = $licenseKey}
    }

    process {
        if ($PSCmdlet.ShouldProcess()) {
            Invoke-ZertoRestRequest -uri $baseUri -body $($body | ConvertTo-Json) -method "PUT"
        }
    }

    end {
        # Nothing to do
    }
}