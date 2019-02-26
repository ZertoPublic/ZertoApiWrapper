function Invoke-ZertoMoveRollback {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to roll back from failing over",
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
            $uri = "{0}/{1}/moveRollBack" -f $baseUri, $id
            Invoke-ZertoRestRequest -uri $uri -method "POST"
        }
    }

    end {
        #Nothing to do
    }
}
