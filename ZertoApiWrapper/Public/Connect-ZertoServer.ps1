<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Connect-ZertoServer {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "IP address or FQDN of your Zerto Management Server"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zertoServer,
        [Parameter(
            HelpMessage = "Zerto Virtual Manager management port. Default value is 9669."
        )]
        [string]$zertoPort = "9669",
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Valid credentials to connect to the Zerto Management Server"
        )]
        [System.Management.Automation.PSCredential]
        $credential,
        [switch]$returnHeaders
    )

    begin {
        $body = '{"AuthenticationMethod": "1"}'
        $uri = "session/add"
        # Set Script Scope Variables for Use in all functions in the module; Server and Port Information
        Set-Variable -Name zvmServer -Scope Script -Value $zertoServer
        Set-Variable -Name zvmPort -Scope Script -Value $zertoPort
        # Set zvmLastAction Variable to keep track when the API token expires
        Set-Variable -Name zvmLastAction -Scope Script -Value $(get-date).Ticks
        # Set / Clear the zvmHeaders to clear any existing token
        Set-Variable -Name zvmHeaders -Scope Script -Value $null
    }

    process {
        # Send authorization request to the function and send back the results including headers
        $results = Invoke-ZertoRestRequest -uri $uri -credential $credential -returnHeaders -body $body -method POST
    }

    end {
        # Build Headers Hashtable with Authorization Token
        $zertoAuthorizationHeaders = @{"x-zerto-session" = $results.Headers['x-zerto-session'][0].ToString(); "Accept" = "application/json"}
        # Set common Script Scope Variables to be used other functions (Headers and Local Site Info)
        Set-Variable -Name zvmHeaders -Scope Script -Value $zertoAuthorizationHeaders
        Set-Variable -Name zvmLocalInfo -Scope Script -Value (Get-ZertoLocalSite)

        # Have the option to return the headers to a variable
        if ($returnHeaders) {
            return $zertoAuthorizationHeaders
        }
    }
}
