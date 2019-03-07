<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Set-ZertoAlert {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param (
        [Alias("identifier")]
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            HelpMessage = "Alert identifier(s) to be dismissed or undismissed."
        )]
        [string[]]$alertId,
        [Parameter(
            ParameterSetName = "dismiss",
            Mandatory = $true,
            HelpMessage = "Will dismiss the selected alert."
        )]
        [switch]$dismiss,
        [Parameter(
            ParameterSetName = "undismiss",
            Mandatory = $true,
            HelpMessage = "Will undismiss the selected alert."
        )]
        [switch]$undismiss
    )

    begin {
        $baseUri = "alerts"
    }

    process {
        foreach ($id in $alertId) {
            $uri = "{0}/{1}/{2}" -f $baseUri, $id, $PSCmdlet.ParameterSetName
            if ($PSCmdlet.ShouldProcess($PSCmdlet.ParameterSetName + " alertId $id")) {
                Invoke-ZertoRestRequest -uri $uri -method "POST" | Out-Null
            }
        }
    }

    end {
        # Nothing to do.
    }
}