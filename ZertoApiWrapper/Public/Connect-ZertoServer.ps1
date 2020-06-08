<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Connect-ZertoServer {
    [cmdletbinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "IP address or FQDN of your Zerto Management Server"
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("server", "zvm")]
        [string]$zertoServer,
        [Parameter(
            HelpMessage = "Zerto Virtual Manager management port. Default value is 9669."
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1024, 65535)]
        [Alias("port")]
        [string]$zertoPort = "9669",
        [Parameter(
            Mandatory,
            HelpMessage = "Valid credentials to connect to the Zerto Management Server"
        )]
        [System.Management.Automation.PSCredential]$credential,
        [switch]$returnHeaders,
        [Parameter(
            HelpMessage = "Use this switch to indicate that you would like the module to take care of auto re-authorization and reconnection to the ZVM should the token expire. This option will cache your PSCredential object to be reused"
        )]
        [switch]$AutoReconnect
    )

    begin {
        $body = '{"AuthenticationMethod": "1"}'
        $uri = "session/add"
        # Set Script Scope Variables for Use in all functions in the module; Server and Port Information
        Set-Variable -Name zvmServer -Scope Script -Value $zertoServer
        Set-Variable -Name zvmPort -Scope Script -Value $zertoPort
        # Set zvmLastAction Variable to keep track when the API token expires
        Set-Variable -Name zvmLastAction -Scope Script -Value $(Get-Date).Ticks
        # Set / Clear the zvmHeaders to clear any existing token
        Set-Variable -Name zvmHeaders -Scope Script -Value @{
            "Accept"             = "application/json"
            "zerto-triggered-by" = "PowershellWes"
        }
        Set-Variable -Name Reconnect -Scope Script -Value $AutoReconnect.IsPresent
        if ($Script:Reconnect) {
            Set-Variable -Name CachedCredential -Scope Script -Value $credential
        }
    }

    process {
        # Send authorization request to the function and send back the results including headers
        $results = Invoke-ZertoRestRequest -uri $uri -credential $credential -returnHeaders -body $body -method POST -ErrorAction Stop
    }

    end {
        # Build Headers Hashtable with Authorization Token
        $Script:zvmHeaders['x-zerto-session'] = $results.Headers['x-zerto-session'][0].ToString()
        # Set common Script Scope Variables to be used other functions (Headers and Local Site Info)
        # Set-Variable -Name zvmHeaders -Scope Script -Value $zertoAuthorizationHeaders
        Set-Variable -Name zvmLocalInfo -Scope Script -Value (Get-ZertoLocalSite)

        # Have the option to return the headers to a variable
        if ($returnHeaders) {
            return $Script:zvmHeaders
        }
    }
}
