function Export-ZertoVpg {
    [cmdletbinding()]
    param(
        [string]$outputPath,
        [string[]]$vpgName
    )

    begin {

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