function Install-Vra {
    [cmdletbinding()]
    param(
        [Parameter( Mandatory = $true )]
        [string]$hostName,
        [Parameter( Mandatory = $true )]
        [string]$datastoreName,
        [Parameter( Mandatory = $true )]
        [string]$networkName,
        [Parameter()]
        [int]$memoryInGB = 3,
        [Parameter()]
        [string]$groupName,
        [Parameter( ParameterSetName = "Dhcp", Mandatory = $true )]
        [switch]$Dhcp,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$vraIpAddress,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$defaultGateway,
        [Parameter( ParameterSetName = "StaticIp", Mandatory = $true )]
        [ValidateScript( {$_ -match [IPAddress]$_ })]
        [string]$subnetMask

    )

    $hostInformation = Get-
}