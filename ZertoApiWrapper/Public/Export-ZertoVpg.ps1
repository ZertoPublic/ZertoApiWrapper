<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Export-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Location where to dump the resulting JSON files containing the VPG Settings",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("outputFolder")]
        [string]$outputPath,
        [parameter(
            HelpMessage = "Name(s) of the VPG(s) to be exported",
            ParameterSetName = "namedVpgs",
            Mandatory = $true
        )]
        [string[]]$vpgName,
        [parameter(
            HelpMessage = "Export all VPGs at this site",
            ParameterSetName = "allVpgs",
            valuefrompipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [switch]$allVpgs
    )

    begin {
        if ($allVpgs) {
            $vpgName = $(Get-ZertoVpg).vpgName
        }
    }

    process {
        foreach ($name in $vpgName) {
            $vpgSettingsIdentifier = New-ZertoVpgSettingsIdentifier -vpgIdentifier $(Get-ZertoVpg -name $name).vpgIdentifier
            $vpgSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsIdentifier
            $filePath = "{0}\{1}.json" -f $outputPath, $name
            $vpgSettings | Convertto-Json -depth 10 | Out-File -FilePath $filePath
        }
    }

    end {

    }
}
