<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Remove-ZertoVpg {
    [cmdletbinding( SupportsShouldProcess = $true, DefaultParameterSetName = "vpgIdentifier" )]
    param(
        [Parameter(
            Mandatory,
            ParameterSetName = "vpgName",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Name(s) of the VPG(s) to delete."
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName,
        [Parameter(
            Mandatory,
            ParameterSetName = "vpgIdentifier",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "vpgIdentifier(s) of the VPG(s) to delete."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgId")]
        [string[]]$vpgidentifier,
        [Parameter(
            HelpMessage = "Use this parameter to keep the recovery volumes at the target site, by setting it to True.  If the virtual machines in the deleted VPG are reprotected, these volumes can be used as preseeded volumes to speed up the initial synchronization of the new VPG. Default is to remove Recovery Volumes"
        )]
        [switch]$keepRecoveryVolumes,
        [Parameter(
            HelpMessage = "Use this parameter to force delete the VPG, by setting this parameter equal to true."
        )]
        [switch]$force
    )

    begin {
        $baseUri = "vpgs"
        $body = @{ }
        if ($keepRecoveryVolumes) {
            $body['KeepRecoveryVolumes'] = $True
        } else {
            $body['KeepRecoveryVolumes'] = $False
        }
        if ($force) {
            $body['force'] = $True
        } else {
            $body['force'] = $False
        }
    }

    process {
        switch ($PSCmdlet.ParameterSetName) {
            "vpgName" {
                foreach ($name in $vpgName) {
                    $id = $(get-zertovpg -name $name).vpgIdentifier
                    if ($id) {
                        $uri = "{0}/{1}" -f $baseUri, $id
                        if ($PSCmdlet.ShouldProcess( $name + " and these settings: " + $($body | ConvertTo-Json) ) ) {
                            Invoke-ZertoRestRequest -uri $uri -body $($body | ConvertTo-Json) -Method "DELETE"
                        }
                    } else {
                        Write-Error "VPG with name $vpgName not found. Please check the name and try again"
                    }
                }
            }

            "vpgIdentifier" {
                foreach ($id in $vpgIdentifier) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    if ($PSCmdlet.ShouldProcess( $id + " and these settings: " + $($body | ConvertTo-Json) ) ) {
                        Invoke-ZertoRestRequest -uri $uri -body $($body | ConvertTo-Json) -Method "DELETE"
                    }
                }
            }
        }
    }

    end {
        # Nothing to do
    }
}
