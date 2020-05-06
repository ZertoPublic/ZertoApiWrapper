<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoAlert {
    [cmdletbinding( defaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "alertId",
            Mandatory,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true ,
            HelpMessage = "AlertId or array of AlertIds to be queried"
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$alertId,
        [Parameter(
            ParameterSetName = "entities",
            Mandatory,
            HelpMessage = "Switch to return the entities information from the API"
        )]
        [switch]$entities,
        [Parameter(
            ParameterSetName = "helpIdentifiers",
            Mandatory,
            HelpMessage = "Switch to get the Help Identifiers information from the API"
        )]
        [switch]$helpIdentifiers,
        [Parameter(
            ParameterSetName = "levels",
            Mandatory,
            HelpMessage = "Switch to return Alert Levels information from the API"
        )]
        [switch]$levels,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns Alerts after the Start Date. Provide the string in the format of 'yyyy-MM-ddTHH:mm:ss.fff'"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns Alerts before the End Date. Provide the string in the format of 'yyyy-MM-ddTHH:mm:ss.fff'"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns alerts for the specified vpgIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgId")]
        [string]$vpgIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns alerts for the specified siteIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("siteId")]
        [string]$siteIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns alerts for the specified zorgIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("zorgId")]
        [string]$zorgIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns alerts for the specified level"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$level,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns alerts for the specified helpIdentifier"
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("helpId")]
        [string]$helpIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Returns alerts for the specified entity"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$entity,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = 'Returns alerts that are dismissed when set to $true an undismissed alerts when set to $false'
        )]
        [bool]$isDismissed
    )

    begin {
        $baseUri = "alerts"
        $returnObject = @()
    }

    process {
        # Select the operation based on the ParameterSetName
        switch ( $PSCmdlet.ParameterSetName ) {
            # If called without any parameters, return all alerts
            "main" {
                $uri = "{0}" -f $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # If called with the alertId ParameterSetName, build an object that contains all alerts for alertIds specified
            "alertId" {
                $returnObject = foreach ( $id in $alertId ) {
                    $uri = "{0}/{1}" -f $baseUri, $alertId
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # If called with the filter ParameterSetName, get a filter string and get results from API.
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # If any other ParameterSetName is called, build URI based on ParameterSetName and submit
            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName.ToLower()
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
