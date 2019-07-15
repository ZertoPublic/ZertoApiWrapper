function Get-ZertoApiFilter {
    [cmdletbinding()]
    [Outputtype([String])]
    param(
        [Parameter( Mandatory = $true,
            HelpMessage = "Hashtable that contains filter keys and values"
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$filterTable
    )
    # Define the start of the return string
    [string]$returnString = "?"
    $commonParameters = @(
        "Debug"
        "ErrorAction"
        "ErrorVariable"
        "InformationAction"
        "InformationVariable"
        "OutVariable"
        "OutBuffer"
        "PipelineVariable"
        "Verbose"
        "WarningAction"
        "WarningVariable"
        "WhatIf"
        "Confirm"
    )
    #Foreach item in the table, process each item
    foreach ( $key in $filterTable.Keys ) {
        # If the key is not a common parameter, process it.
        if ($key -notin $commonParameters) {
            #If this is not the first item added to the string, add the ampersand and filter
            if ($returnString.Length -gt 1) {
                $returnString = "{0}&{1}={2}" -f $returnString, $key, $filterTable[$key]
            } else {
                #If it is the first item, just add the first item
                $returnString = "{0}{1}={2}" -f $returnString, $key, $filterTable[$key]
            }
        }
    }
    # Return the built query String
    return $returnString
}
