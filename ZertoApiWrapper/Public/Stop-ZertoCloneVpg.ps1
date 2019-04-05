<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Stop-ZertoCloneVpg {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter(
            HelpMessage = "Name of the VPG to stop cloning",
            Mandatory = $true
        )]
        [string]$vpgName
    )

    begin {
        $baseUri = "vpgs"
        $vpgIdentifier = $(Get-ZertoVpg -name $vpgName).vpgIdentifier
    }

    process {
        $uri = "{0}/{1}/CloneAbort" -f $baseUri, $vpgIdentifier
        if ($PSCmdlet.ShouldProcess("Stopping VPG Clone Operation")) {
            invoke-ZertoRestRequest -uri $uri -method "POST"
        }

    }

    end {
        # Nothing to do
    }
}

