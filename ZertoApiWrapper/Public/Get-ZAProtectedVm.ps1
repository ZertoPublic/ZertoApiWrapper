<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAProtectedVm {
    [cmdletbinding(DefaultParameterSetName = "AllVMs")]
    param(
        [Parameter(
            ParameterSetName = "AllVMs",
            HelpMessage = "Use this switch when you want a list of all protected VMs. Please be warned this list can be quite large."
        )]
        [switch]$AllVms,
        [Parameter(
            ParameterSetName = "IndividualVMs",
            Mandatory,
            HelpMessage = "A list of VM identifiers to query"
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$VMIdentifier,
        [Parameter(
            ParameterSetName = "IndividualVMs",
            HelpMessage = "Specify this switch when you would like protected vms' volume information returned"
        )]
        [switch]$Volumes
    )

    Begin {

    }

    Process {
        $BaseUri = "monitoring/protected-vms"
        switch ($PSCmdlet.ParameterSetName) {
            "AllVMs" {
                Invoke-ZARestRequest -uri $BaseUri
            }

            "IndividualVMs" {
                foreach ($identifier in $VMIdentifier) {
                    if ($Volumes.IsPresent) {
                        $Uri = "{0}/{1}/volumes" -f $BaseUri, $identifier
                    } else {
                        $uri = $Uri = "{0}/{1}" -f $BaseUri, $identifier
                    }
                    Invoke-ZARestRequest -uri $Uri
                }
            }
        }
    }

    End {

    }
}
