<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Resume-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to resume replication",
            Mandatory = $true
        )]
        [string[]]$vpgName
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        foreach ($name in $vpgName) {
            $id = $(Get-ZertoVpg -name $name).vpgIdentifier
            $uri = "{0}/{1}/resume" -f $baseUri, $id
            Invoke-ZertoRestRequest -uri $uri -method "POST"
        }
    }

    end {
        #Nothing to do
    }
}
