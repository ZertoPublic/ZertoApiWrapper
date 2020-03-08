<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAPlannerZcasReport {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "The site identifier(s) for which to return detailed information."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$siteIdentifier,
        [Parameter(
            Mandatory,
            HelpMessage = "Type of target recovery site."
        )]
        [ValidateSet('azure', 'vcenter', 'vcd', 'scvmm', 'aws')]
        [string]$recoveryType,
        [Parameter(
            Mandatory,
            HelpMessage = "Identifiers of the VMs you want to recover at the target recovery site."
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vmIdentifier,
        [Parameter(
            HelpMessage = "The earliest timestamp of an event to return, in RFC 3339 standard. ('1970-01-01T00:00:00Z'). The default is one year ago."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            HelpMessage = "The latest timestamp of an event to return, in RFC 3339 standard. ('1970-01-01T00:00:00Z'). The default is the current time."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate
    )
    $uri = "planner/reports/stats/zcas"
    $body = @{
        siteIdentifier = $siteIdentifier
        recoveryType   = $recoveryType
        vmIdentifiers  = New-Object System.Collections.Generic.List[psobject]
    }
    if ( -not [String]::IsNullOrEmpty($startDate) ) {
        $body['startDate'] = $startDate
    }
    if ( -not [String]::IsNullOrEmpty($endDate) ) {
        $body['endDate'] = $endDate
    }
    foreach ($vmId in $vmIdentifier) {
        $body['vmIdentifiers'].Add($vmId)
    }
    #$body | ConvertTo-Json
    $reportId = Invoke-ZARestRequest -uri $uri -method POST -body ($body | ConvertTo-Json)
    #Start-Sleep 10
    $uri = '{0}?reportId={1}' -f $uri, $reportId.reportId
    Invoke-ZARestRequest -uri $uri
}
