<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAPlannerNetworkPerformanceReport {
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
            HelpMessage = "The desired sample interval in seconds. The default is 3600 seconds (1 Hour). Limited to a 60 second to 86,400 second (24 Hour) interval"
        )]
        [ValidateRange(60, 86400)]
        [Int]$interval = 3600,
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
    $uri = "planner/reports/network-performance"
    $body = @{
        siteIdentifier = $siteIdentifier
        recoveryType   = $recoveryType
        interval       = $interval
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
    $reportId = Invoke-ZARestRequest -uri $uri -method POST -body ($body | ConvertTo-Json)
    $uri = '{0}?reportId={1}' -f $uri, $reportId.reportId
    Invoke-ZARestRequest -uri $uri
}
