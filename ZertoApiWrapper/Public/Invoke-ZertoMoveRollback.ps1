<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoMoveRollback {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to roll back from failing over",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        foreach ($name in $vpgName) {
            $id = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $id ) {
                Write-Error "VPG: $name not found. Please check the name and try again."
            } else {
                $uri = "{0}/{1}/moveRollBack" -f $baseUri, $id
                if ($PSCmdlet.ShouldProcess("Rolling back VPG: $name")) {
                    Invoke-ZertoRestRequest -uri $uri -method "POST"
                }
            }
        }
    }

    end {
        #Nothing to do
    }
}
