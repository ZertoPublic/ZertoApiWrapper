function Invoke-ZertoFailover {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = ""
        )]
        [string]$vpgName,
        [Parameter(
            HelpMessage = ""
        )]
        [string]$checkpointIdentifier,
        [Parameter(
            HelpMessage = ""
        )]
        [string]$commitPolicy = "1",
        [Parameter(
            HelpMessage = ""
        )]
        [string]$shutdownPolicy = "0",
        [Parameter(
            HelpMessage = ""
        )]
        [long]$timeToWaitBeforeShutdownInSec = 2147483647,
        [Parameter(
            HelpMessage = ""
        )]
        [switch]$reverseProtection,
        [Parameter(
            HelpMessage = ""
        )]
        [string[]]$vmName
    )
}
