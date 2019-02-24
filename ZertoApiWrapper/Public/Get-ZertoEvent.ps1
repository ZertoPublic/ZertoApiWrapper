function Get-ZertoEvent {
    [cmdletbinding( defaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The starting date for the list of events, supplied as a date with the format of the Zerto Virtual Manager where the API runs, for example, yyyy-MM-dd. You can also specify a local time with the following format: yyyy-MM-ddTHH:mm:ss.fffZ. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$startDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The end date for the list, supplied as a date with the format of the Zerto Virtual Manager where the API runs, for example, yyyy-MM-dd. You can also specify a local time with the following format: yyyy-MM-ddTHH:mm:ss.fffZ. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$endDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the VPG for which you want to return events."
        )]
        [string]$vpg,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the VPG for which you want to return events."
        )]
        [string]$vpgIdentifier,
        [Parameter( ParameterSetName = "filter",
            HelpMessage = "The type of event. For the description of events, refer to the Zerto Virtual Replication documentation about alerts and events. Please see Zerto API Documentation for possible values."
        )]
        [string]$eventType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the site for which you want to return events."
        )]
        [string]$siteName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The internal site identifier for which you want to return events."
        )]
        [string]$siteIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the ZORG, Zerto organization, defined in the Zerto Cloud Manager for which you want to return results."
        )]
        [string]$zorgIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The type of entity for which you wish to return results. Possible Values are: '0' or 'VPG', '1' or 'VRA', '2' or 'Unknown', or '3' or 'Site'"
        )]
        [string]$entityType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the user for which the event occurred. If the event occurred as a result of a task started by the Zerto Virtual Manager, for example, when moving a VPG before the commit stage, the user is System."
        )]
        [string]$userName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The type of event to return. This filter behaves in the same way as the eventCategory filter. Possible Values are: Possible Values are: '0' or 'All', '1' or 'Events', '2' or 'Alerts'"
        )]
        [string]$category,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = " This filter behaves in the same way as the category filter. If both category and eventCategory filters are specified, only the category filter value is used and the eventCategory filter value is ignored. The type of event to return. Possible Values are: '0' or 'All', '1' or 'Events', '2' or 'Alerts'"
        )]
        [string]$eventCategory,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The internal alert identifier for the Event"
        )]
        [string]$alertIdentifier,
        [Parameter(
            ParameterSetName = "eventId",
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The identifier or identifiers of the event for which information is returned.")]
        [string[]]$eventId,
        [Parameter(
            ParameterSetName = "categories",
            Mandatory = $true,
            HelpMessage = "Returns possible Event Categories."
        )]
        [switch]$categories,
        [Parameter(
            ParameterSetName = "entities",
            Mandatory = $true,
            HelpMessage = "Returns possible entity types."
        )]
        [switch]$entities,
        [Parameter(
            ParameterSetName = "types",
            Mandatory = $true,
            HelpMessage "Returns possible event types.")]
        [switch]$types
    )

    begin {
        $baseUri = "events"
        $returnObject = @()
    }

    process {
        # Process based on the ParameterSetName Used
        switch ( $PSCmdlet.ParameterSetName ) {
            # If no params are supplied, return all Events
            "main" {
                $uri = "{0}" -f $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # If one or more eventIds are supplied, run a foreach loop to get them all
            "eventId" {
                $returnObject = foreach ( $id in $eventId ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # If a filter is applied, create the filter and return the events that fall in that filter
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # If a different ParameterSet is called, use the ParameterSet name to determine the URI and call it.
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
