function Import-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "VPG settings JSON file(s) to import.",
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("FullName")]
        [string[]]$settingsFile
    )

    begin {
        $baseUri = "vpgSettings"
    }

    process {
        foreach ($file in $settingsFile) {
            $importedSettings = Get-Content -Path $file -Raw | ConvertFrom-Json
            $vpgSettingsIdentifier = New-ZertoVpgSettingsIdentifier -newVpg
            $importedSettings.VpgIdentifier = $null
            $importedSettings.VpgSettingsIdentifier = $vpgSettingsIdentifier
            $uri = "{0}/{1}" -f $baseUri, $vpgSettingsIdentifier
            Invoke-ZertoRestRequest -uri $uri -method "PUT" -body $($importedSettings | convertto-json -Depth 10)
            $vpgSettingsIdentifier | Save-ZertoVpgSettings
            if ($settingsFile.Count -gt 1) {
                Start-Sleep 5
            }
        }
    }

    end {

    }
}
