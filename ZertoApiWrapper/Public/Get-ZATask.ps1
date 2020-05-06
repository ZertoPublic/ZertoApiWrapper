<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZATask {
    [cmdletbinding( DefaultParameterSetName = "zOrg")]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter the task list. If the ZORG identifier is omitted, a list of all the tasks is retrieved.",
            ParameterSetName = "zOrg"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier,
        [Parameter(
            HelpMessage = "The maximum number of tasks to return.",
            ParameterSetName = "zOrg"
        )]
        [ValidateRange(1, 1000000)]
        [int]$limitTo,
        [Parameter(
            HelpMessage = "The task Idnetifier",
            ParameterSetName = "taskId",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]$taskIdentifier
    )
    $uri = "monitoring/tasks"
    switch ($PSCmdlet.ParameterSetName) {
        zOrg {
            if ( $PSBoundParameters.Keys.Count -gt 0 ) {
                $filterString = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $uri, $filterString
            }
        }

        taskId {
            $uri = "{0}/{1}" -f $uri, $taskIdentifier
        }
    }
    Invoke-ZARestRequest -uri $uri
}
