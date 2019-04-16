<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoFailoverRollback {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to roll back from failing over",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $vpgId ) {
                Write-Error "VPG: $name not found. Please check the name and try again. Skipping"
            } else {
                $uri = "{0}/{1}/FailoverRollback" -f $baseUri, $vpgId
                Invoke-ZertoRestRequest -uri $uri -method "POST"
            }
        }
    }

    end {
        #Nothing to do
    }
}
