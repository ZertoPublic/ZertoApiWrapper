function Invoke-ZertoRestRequest {
    [cmdletbinding()]
    param(
        [Parameter(HelpMessage = "API method to be used. GET, PUT, POST, or DELETE. If unspecified, defaults to GET.")]
        [ValidateSet("GET", "PUT", "POST", "DELETE")]
        [string]$method = "GET",

        [Parameter(Mandatory, HelpMessage = "URI endpoint to be utilized. Only the endpoint needs to be submitted.")]
        [ValidateNotNullOrEmpty()]
        [string]$uri,

        [Parameter(HelpMessage = "Body to be submitted to the REST API endpoint in JSON format.")]
        [string]$body = "",

        [Parameter(HelpMessage = "PSCredential object, used only when authenticating with the ZVM.")]
        [PSCredential]$credential,

        [Parameter(HelpMessage = "Use this switch to return request headers along with the response body.")]
        [switch]$returnHeaders
    )

    $apiVersion = "v1"
    $callerErrorActionPreference = $ErrorActionPreference

    # Ensure required script variables exist
    if (-not (Test-Path variable:script:zvmServer) -or -not (Test-Path variable:script:zvmPort)) {
        Throw "Zerto connection does not exist. Run Connect-ZertoServer first."
    }

    # Ensure $Script:Reconnect is defined
    if (-not (Test-Path variable:script:Reconnect)) { $Script:Reconnect = $false }

    # Check for expired session
    if ((Test-Path variable:script:AuthExpiresAt) -and $([datetime]$script:AuthExpiresAt) -lt (Get-Date)) {
        Remove-Variable -Name AuthExpiresAt -Scope Script
        if ($Script:Reconnect) {
            Write-Verbose "Authorization expired. Reauthorizing."
            Connect-ZertoServer -zertoServer $Script:zvmServer -zertoPort $script:zvmPort -credential $Script:CachedCredential
        } else {
            Throw "Authorization token expired. Please reauthorize."
        }
    }

    $submittedURI = "https://{0}:{1}/{2}/{3}" -f $script:zvmServer, $script:zvmPort, $apiVersion, $uri
    $script:zvmLastAction = (Get-Date).Ticks
    $responseHeaders = @{}
    $apiRequestResults = $null

    try {
        # Set default headers
        $headers = @{
            "Accept" = "application/json"
        }

        # If authorization headers exist, add them
        if (Test-Path variable:script:zvmHeaders) {
            $headers["Authorization"] = "Bearer $($script:zvmHeaders.Authorization)"
        }

        $params = @{
            Uri         = $submittedURI
            Method      = $method
            Headers     = $headers
            Body        = $body
            TimeoutSec  = 100
        }

        # Handle authentication requests
        if ($uri -match "auth/realms/.*/protocol/openid-connect/token" -and $method -eq "POST") {
            $data = @{
                'client_id'  = $script:zertoClientId
                'username'   = $credential.GetNetworkCredential().UserName
                'password'   = $credential.GetNetworkCredential().Password
                'grant_type' = 'password'
            }

            $params.Uri = "https://{0}:{1}/auth/realms/zerto/protocol/openid-connect/token" -f $script:zvmServer, $script:zvmPort
            $params.Body = $data
            $params.ContentType = "application/x-www-form-urlencoded"
        } else {
            $params.ContentType = "application/json"
        }

        # Handle certificate validation for PowerShell 5.1
        if ($PSVersionTable.PSVersion.Major -ge 6) {
            $params["SkipCertificateCheck"] = $true
        } elseif ([System.Net.ServicePointManager]::CertificatePolicy.GetType().Name -ne "TrustAllCertsPolicy") {
            [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
        }

        $apiRequestResults = Invoke-RestMethod @params -ResponseHeadersVariable responseHeaders

        # Debugging - Inspect Response Type
        Write-Verbose "Response Type: $($apiRequestResults.GetType().FullName)"
        Write-Verbose "Response Content: $($apiRequestResults | ConvertTo-Json -Depth 10)"

        # Ensure response is parsed properly
        if ($apiRequestResults -is [string]) {
            try {
                $apiRequestResults = $apiRequestResults | ConvertFrom-Json -ErrorAction Stop
            } catch {
                Write-Verbose "Response is not in JSON format, returning raw output."
            }
        }

        # Handle token expiration update
        if ($uri -match "auth/realms/.*/protocol/openid-connect/token" -and $method -eq "POST") {
            if ($apiRequestResults -is [System.Collections.IDictionary]) {
                Write-Verbose "API response is a dictionary. Extracting values..."
            }
            $script:AuthExpiresAt = (Get-Date).AddSeconds($apiRequestResults.expires_in)
            $script:refreshToken = $apiRequestResults.refresh_token
            $headers["Authorization"] = "Bearer " + $apiRequestResults.access_token
        }
    }
    catch {
        Write-Error -ErrorRecord $_ -ErrorAction $callerErrorActionPreference
        return
    }

    # Return response based on $returnHeaders flag
    if (-not $returnHeaders) {
        return $apiRequestResults
    } else {
        return [PSCustomObject]@{
            apiRequestResults = $apiRequestResults
            Headers = $responseHeaders
        }
    }
}
