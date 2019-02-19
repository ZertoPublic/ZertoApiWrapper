function New-ZertoApiFilter {
    [cmdletbinding()]
    param(
        [Parameter( Mandatory = $true )]
        [hashtable]$filterTable
    )
    [string]$returnString = "?"

    foreach ( $key in $filterTable.Keys ) {
        if ($returnString.Length -gt 1) {
            $returnString = "{0}&{1}={2}" -f $returnString, $key, $filterTable[$key]
        } else {
            $returnString = "{0}{1}={2}" -f $returnString, $key, $filterTable[$key]
        }
    }

    return $returnString
}
