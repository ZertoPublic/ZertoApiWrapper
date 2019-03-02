<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Checkpoint-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Name of the VPG to tag."
        )]
        [string]$vpgName,
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Text to tag the checkpoint with."
        )]
        [string]$checkpointName
    )

    begin {
        $baseUri = "vpgs"
        $vpgIdentifier = $(get-zertovpg -name $vpgName).vpgIdentifier
        $body = @{"checkpointName" = $checkpointName}
    }

    process {
        if ($vpgIdentifier) {
            $uri = "{0}/{1}/Checkpoints" -f $baseUri, $vpgIdentifier
            Invoke-ZertoRestRequest -uri $uri -body $($body | ConvertTo-Json) -method "POST"
        } else {
            Write-Output "Cannot find VPG named $vpgName. Please check the name and try again."
        }
    }

    end {

    }
}
