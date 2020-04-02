<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAProtectedVmReport {
    [cmdletbinding()]
    param(
        [Parameter(
            ParameterSetName = "GenerateReport",
            Mandatory,
            HelpMessage = "A list of VM identifiers to include in the report."
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$VMIdentifier
    )

    Begin {

    }

    Process {
        $BaseUri = "monitoring/protected-vms"
        $Body = @{
            vmsIdentifiers = $VMIdentifier
        }
        $reportId = Invoke-ZARestRequest -uri $BaseUri -method POST -body ($Body | ConvertTo-Json)
        Start-Sleep 1
        $Uri = "{0}?reportId={1}" -f $BaseUri, $reportId.reportId
        Invoke-ZARestRequest -uri $Uri
    }

    End {

    }
}
