<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Remove-ZertoVpgSettingsIdentifier {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        # Settings Identifier to Remove
        [Parameter(HelpMessage = "VpgSettingsIdentifier to Delete", Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $vpgSettingsIdentifier
    )

    begin {
    }

    process {
        foreach ($id in $vpgSettingsIdentifier) {
            if ($PSCmdlet.ShouldProcess($id)) {
                $uri = "vpgSettings/{0}" -f $id
                Invoke-ZertoRestRequest -uri $uri -method "DELETE"
            }
        }
    }

    end {
    }
}
