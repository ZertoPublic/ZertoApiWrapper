function New-Map {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $inputObject,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$key,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$value
    )

    $returnMap = @{ }
    foreach ($item in $inputObject) {
        $returnMap[$item.$key] = $item.$value
    }
    $returnMap
}
