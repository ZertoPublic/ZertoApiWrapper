<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZADatastore {
    [CmdletBinding(DefaultParameterSetName = "AllInfo")]
    param (
        [Parameter(
            HelpMessage = "The site identifier. The site identifier is mandatory. Omit the datastore and datastore cluster identifiers to view site level storage information.",
            Mandatory,
            ParameterSetName = "AllInfo"
        )]
        [Parameter(
            Mandatory,
            ParameterSetName = "cluster"
        )]
        [Parameter(
            Mandatory,
            ParameterSetName = "datastore"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$siteIdentifier,
        [Parameter(
            HelpMessage = "The datastore cluster identifier. Gets a list of datastores in the cluster.",
            ParameterSetName = "cluster",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]$clusterIdentifier,
        [Parameter(
            HelpMessage = "The datastore identifer. Gets the datastore info.",
            ParameterSetName = "datastore",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]$datastoreIdentifier

    )
    $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
    $uri = "monitoring/datastores{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
