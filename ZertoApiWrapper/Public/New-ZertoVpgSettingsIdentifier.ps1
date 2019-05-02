<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function New-ZertoVpgSettingsIdentifier {
    [cmdletbinding( SupportsShouldProcess = $true, DefaultParameterSetName = "newVpg" )]
    param(
        [Parameter(
            HelpMessage = "Identifier of the VPG to create a VPG settings identifier. If a vpgIdentifier is not provided, a new VPG settings object is created without any configured settings. This would be used for creating a new VPG from scratch.",
            ParameterSetName = "existingVpg",
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgId")]
        [string[]]$vpgIdentifier,
        [Parameter(
            HelpMessage = "Use this switch when creating a vpgSettingsIdentifier for a new VPG",
            ParameterSetName = "newVpg",
            Mandatory = $true
        )]
        [switch]$newVpg
    )

    begin {
        $baseUri = "vpgSettings"
    }

    process {
        switch ($PSCmdlet.ParameterSetName) {
            "newVpg" {
                $body = "{}"
                if ($PSCmdlet.ShouldProcess("Creating VPG Settings Object")) {
                    Invoke-ZertoRestRequest -uri $baseUri -body $body -Method "POST"
                }
            }
            "existingVpg" {
                foreach ($id in $vpgIdentifier) {
                    $body = "{""VpgIdentifier"":""$id""}"
                    if ($PSCmdlet.ShouldProcess("Creating VPG Settings Object")) {
                        Invoke-ZertoRestRequest -uri $baseUri -body $body -Method "POST"
                    }
                }
            }
        }
    }

    end {
        #Nothing to do
    }
}
