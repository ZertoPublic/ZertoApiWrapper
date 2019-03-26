<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoTask {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param (
        [Parameter(
            ParameterSetName = "taskIdentifier",
            HelpMessage = "The identifier(s) for which task information is to be returned."
        )]
        [Alias("taskId")]
        [string[]]$taskIdentifier,
        [Parameter(
            ParameterSetName = "types",
            HelpMessage = "Returns all task types."
        )]
        [switch]$types,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Tasks started before this time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$startedBeforeDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Tasks started after this time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$startedAfterDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Tasks completed after this time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$completedAfterDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Tasks completed before this time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$completedBeforeDate,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The type of task. For the description of the tasks, refer to the Zerto Virtual Replication documentation about monitoring tasks. Please see Zerto API Documentation for possible types and values."
        )]
        [string]$type,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The status of the task. Possible values are: '1' or 'InProgress', '3' or 'Paused', '4' or 'Failed', '6' or 'Completed', '7' or 'Cancelling'"
        )]
        [string]$status
    )

    begin {
        $baseUri = "tasks"
        $returnObject = @()
    }

    process {
        # Process based on ParameterSetName
        switch ( $PSCmdlet.ParameterSetName ) {

            # If function is called without parameters, return all events.
            "main" {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }

            # If function is called with Filter ParameterSetName, build filter and return results
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # If taskIdentifier(s) is supplied, return information for each id supplied.
            "taskIdentifier" {
                $returnObject = foreach ( $id in $taskIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # If a different ParameterSetName is supplied, use that to build the URI and submit.
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
