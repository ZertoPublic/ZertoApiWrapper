function Suspend-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to pause replication",
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
            $uri = "{0}/{1}/pause" -f $baseUri, $id
            Invoke-ZertoRestRequest -uri $uri -method "POST"
        }
    }

    end {
        #Nothing to do
    }
}
