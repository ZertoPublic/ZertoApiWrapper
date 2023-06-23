function Connect-ZertoServer {
    [cmdletbinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "IP address or FQDN of your Zerto Management Server",
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("server", "zvm")]
        [string]$zertoServer,
        [Parameter(
            Mandatory,
            HelpMessage = "Valid credentials to connect to the Zerto Management Server",
            Position = 1
        )]
        [System.Management.Automation.PSCredential]$credential,
        [Parameter(
            HelpMessage = "Zerto Virtual Manager management port. Default value is 443."
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1024, 65535)]
        [Alias("port")]
        [string]$zertoPort = "443",
        [Parameter(
            HelpMessage = "Zerto Keycloak client id. Default value is zerto-client."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("clientid")]
        [string]$zertoClientId = "zerto-client",
        [Parameter(
            HelpMessage = "Use this switch to indicate that you would like the module to take care of auto re-authorization and reconnection to the ZVM should the token expire. This option will cache your PSCredential object to be reused"
        )]
        [switch]$AutoReconnect,
        [Parameter(
            HelpMessage = "Use this switch to return the Bearer Token to a specified variable or to the default output."
        )]
        [switch]$returnToken

    )

    begin {
        $uri = "auth/realms/zerto/protocol/openid-connect/token"
        # Set Script Scope Variables for Use in all functions in the module; Server and Port Information
        Set-Variable -Name zvmServer -Scope Script -Value $zertoServer
        Set-Variable -Name zvmPort -Scope Script -Value $zertoPort
        # Set zvmLastAction Variable to keep track when the API token expires
        Set-Variable -Name zvmLastAction -Scope Script -Value $(Get-Date).Ticks
        # Set / Clear the zvmHeaders to clear any existing token
        Set-Variable -Name zvmHeaders -Scope Script -Value @{
            #"Accept"             = "application/json"
            "zerto-triggered-by" = "PowershellWes"
        }
        Set-Variable -Name Reconnect -Scope Script -Value $AutoReconnect.IsPresent
        if ($Script:Reconnect) {
            Set-Variable -Name CachedCredential -Scope Script -Value $credential
        }
        Set-Variable -Name zertoClientId -Scope Script -Value $zertoClientId

        $body = @{
            'client_id'     = $script:zertoClientId
            'username'      = $credential.GetNetworkCredential().Username
            'password'      = $credential.GetNetworkCredential().Password
            'grant_type'    = 'password'
        }
    }

    process {
        # Send authorization request to the function and send back the results including headers -returnHeaders
        $results = Invoke-ZertoRestRequest -uri $uri -credential $credential  -body $body -method POST -ErrorAction Stop
    }

    end {
        # Build Headers Hashtable with Authorization Token
        $script:zvmHeaders['Authorization'] = "Bearer " + $results.access_token.ToString()

        # Have the option to return the headers to a variable
        if ($returnToken) {
            return $Script:zvmHeaders
        }
    }
}
