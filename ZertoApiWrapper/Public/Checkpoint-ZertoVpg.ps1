<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Checkpoint-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the VPG to tag.",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName,
        [Parameter(
            Mandatory,
            HelpMessage = "Text to tag the checkpoint with."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$checkpointName
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        foreach ($name in $vpgName) {
            $vpgIdentifier = $(get-zertovpg -name $name).vpgIdentifier
            if ($vpgIdentifier) {
                $uri = "{0}/{1}/Checkpoints" -f $baseUri, $vpgIdentifier
                $body = @{"checkpointName" = $checkpointName }
                Invoke-ZertoRestRequest -uri $uri -body $($body | ConvertTo-Json) -method "POST"
            } else {
                Write-Output "Cannot find VPG named $name. Please check the name and try again."
            }
        }
    }

    end {

    }
}
