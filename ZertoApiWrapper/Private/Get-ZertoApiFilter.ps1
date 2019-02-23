function Get-ZertoApiFilter {
    [cmdletbinding()]
    param(
        [Parameter( Mandatory = $true,
            HelpMessage = "Hashtable that contains filter keys and values"
        )]
        [hashtable]$filterTable
    )
    # Define the start of the return string
    [string]$returnString = "?"

    #Foreach item in the table, process each item
    foreach ( $key in $filterTable.Keys ) {
        #If this is not the first item added to the string, add the ampersand and filter
        if ($returnString.Length -gt 1) {
            $returnString = "{0}&{1}={2}" -f $returnString, $key, $filterTable[$key]
        } else {
            #If it is the first item, just add the first item
            $returnString = "{0}{1}={2}" -f $returnString, $key, $filterTable[$key]
        }
    }
    # Return the built query String
    return $returnString
}
