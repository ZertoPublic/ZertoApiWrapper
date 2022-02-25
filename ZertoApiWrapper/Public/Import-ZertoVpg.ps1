<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Import-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "VPG settings JSON file(s) to import.",
            Mandatory,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
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
            $vpgSettingsIdentifier | Save-ZertoVpgSetting
            if ($settingsFile.Count -gt 1) {
                Start-Sleep 5
            }
        }
    }

    end {

    }
}
