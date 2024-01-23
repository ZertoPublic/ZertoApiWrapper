function Invoke-ZertoRestRequest {
    [cmdletbinding()]
    param(
        # Parameter help description
        [Parameter(
            Helpmessage = "API method to be used. GET, PUT, POST, or DELETE. Refer to documentation for the API endpoint to ensure the correct method is being used. If unspecified, defaults to GET"
        )]
        [ValidateSet("GET", "PUT", "POST", "DELETE")]
        [string]$method = "GET",
        [Parameter(
            Mandatory,
            Helpmessage = "URI endpoint to be utilized. When submitting the URI, only the endpoint needs to be submitted. Please review the help documentation for examples."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$uri,
        [Parameter(
            Helpmessage = "Body to be submitted to the REST API endpoint. This needs to be submitted in JSON format"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$body,
        [Parameter(
            Helpmessage = "PSCredential object. This is ONLY used when authenticating with the ZVM. No other endpoints require this and generally is not used."
        )]
        [PSCredential]$credential,
        [Parameter(
            Helpmessage = "Use this switch if you would like the request headers returned along with the body. Useful for troubleshooting to get HTTP error codes."
        )]
        [switch]$returnHeaders
    )
    # API version. Currently this is locked at v1 in all versions of Zerto. Should this change, will look
    # at making this as parameter to be selected during function call.
    $apiVersion = "v1"
    # While the API can use XML or JSON, this module is built on JSON functionality. Currently forcing all
    # content types and language to JSON.
    $contentType = "application/json"
    $callerErrorActionPreference = $ErrorActionPreference
    # If the ZVM server and Port not defined, Stop Call
    if ( -not ((Test-Path variable:script:zvmServer) -and (Test-Path variable:script:zvmPort)) ) {
        Throw "Zerto Connection does not Exist. Please run Connect-ZertoServer first to establish a connection"
    }

    # If the Headers exist and the Last action was more than 30 minutes ago, Session is Expired
    if ( (Test-Path variable:script:zvmHeaders) -and (Test-Path variable:script:AuthExpiresAt) -and $([datetime]$script:AuthExpiresAt) -lt $(Get-Date) -and $Script:Reconnect -eq $False ) {
        Remove-Variable -Name AuthExpiresAt -Scope Script
        Throw "Authorization Token has Expired. Please re-authorize to the Zerto Virtual Manager"
    } elseif (( (Test-Path variable:script:zvmHeaders)  -and (Test-Path variable:script:AuthExpiresAt) -and $([datetime]$script:AuthExpiresAt) -lt $(Get-Date) -and $Script:Reconnect -eq $True )) {
        Write-Verbose "Authorization had expired. Attempting Reauthorization."
        Remove-Variable -Name AuthExpiresAt -Scope Script
        Connect-ZertoServer -zertoServer $Script:zvmServer -zertoPort $script:zvmPort -credential $Script:CachedCredential
    }# else {

    # Build the URI to be submitted
    $submittedURI = "https://{0}:{1}/{2}/{3}" -f $script:zvmServer, $script:zvmPort, $apiVersion, $uri
    try {
        # Set the zvmLastAction time and try to submit the REST Request
        $script:zvmLastAction = (Get-Date).Ticks
        # If running PwSh - Use this Invoke-RestMethod with passed Variables
        if ($PSVersionTable.PSVersion.Major -ge 6) {
            # If we are authenticating to the ZVM, Use this block to use Invoke-WebRequest and format the Headers and Body as expected.
            if ($uri -eq "auth/realms/zerto/protocol/openid-connect/token" -and $method -eq "POST") {
                $data = @{
                    'client_id'     = $script:zertoClientId
                    'username'      = $credential.GetNetworkCredential().UserName
                    'password'      = $credential.GetNetworkCredential().Password
                    'grant_type'    = 'password'
                }

                $params = @{
                    'Uri'         = 'https://' + $script:zvmServer + ':' + $script:zvmPort + '/auth/realms/zerto/protocol/openid-connect/token'
                    'Method'      = 'Post'
                    'Body'        = $data
                    'ContentType' = 'application/x-www-form-urlencoded'
                }
                $apiRequestResults = Invoke-RestMethod @params -SkipCertificateCheck

                $ExpiresIn = $apiRequestResults.expires_in
                $script:AuthExpiresAt = (Get-Date).AddSeconds($ExpiresIn)
                $script:refreshToken = $apiRequestResults.refresh_token
                $responseHeaders = @{ }
                $responseHeaders['Authorization'] = "Bearer " + @($apiRequestResults.access_token)

            # If we are logging out from the ZVM, use this block to use Invoke-WebRequest and format the Headers and Body as expected.
            } elseif ($uri -eq "auth/realms/zerto/protocol/openid-connect/logout" -and $method -eq "POST") {
                $data = @{
                    'client_id' = $script:zertoClientId
                    'logout'    = 'true'
                }

                $params = @{
                    'Uri'         = 'https://' + $script:zvmServer + ':' + $script:zvmPort + '/auth/realms/zerto/protocol/openid-connect/logout'
                    'Method'      = 'Post'
                    'Body'        = $data
                    'ContentType' = 'application/x-www-form-urlencoded'
                }

                $apiRequestResults = Invoke-RestMethod @params -SkipCertificateCheck

            } else {
                $apiRequestResults = Invoke-RestMethod -Uri $submittedURI -Headers $script:zvmHeaders -Method $method -Body $body -ContentType $contentType -Credential $credential -SkipCertificateCheck -ResponseHeadersVariable responseHeaders -TimeoutSec 100
            }
        } else {
            # If running PowerShell 5.1 --> Do the Following
            # Check to see if All Certs are Trusted. If not, Create the Policy to Trust All Certificates
            if ([System.Net.ServicePointManager]::CertificatePolicy.GetType().Name -ne "TrustAllCertsPolicy") {
                Try {
                    $type = @'
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult( ServicePoint srvPoint, X509Certificate certificate, WebRequest request, int certificateProblem) {
        return true;
    }
}
'@
                    Add-Type -TypeDefinition $type -ErrorAction SilentlyContinue
                } Catch {
                    if ($error[0].Exception -ne "Cannot add type. The type name 'TrustAllCertsPolicy already exists.") {
                        Write-Debug $error[0]
                    }
                }
                [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

            }
            # If we are authenticating to the ZVM, Use this block to use Invoke-WebRequest and format the Headers as expected.
            if ($uri -eq "auth/realms/zerto/protocol/openid-connect/token" -and $method -eq "POST") {
                $submittedURI = "https://{0}:{1}/{2}" -f $script:zvmServer, $script:zvmPort, $uri
                $body = @{
                    'client_id'     = $script:zertoClientId
                    'username'      = $credential.GetNetworkCredential().Username
                    'password'      = $credential.GetNetworkCredential().Password
                    'grant_type'    = 'password'
                }
                $contentType = 'application/x-www-form-urlencoded'

                $apiRequestResults = Invoke-WebRequest -Uri $submittedURI -Headers $script:zvmHeaders -Method $method -Body $body -ContentType $contentType -Credential $credential -TimeoutSec 100
                #$responseHeaders = @{ }
                #$responseHeaders['x-zerto-session'] = @($apiRequestResults.Headers['x-zerto-session'])
            } elseif ($method -ne "GET") {
                # If the Method is something other than 'GET' use this call with a body parameter
                $apiRequestResults = Invoke-RestMethod -Uri $submittedURI -Headers $script:zvmHeaders -Method $method -Body $body -ContentType $contentType -Credential $credential -TimeoutSec 100
            } else {
                # If the Method we are calling is 'GET' use this call without a body parameter
                $apiRequestResults = Invoke-RestMethod -Uri $submittedURI -Headers $script:zvmHeaders -Method $method -ContentType $contentType -Credential $credential -TimeoutSec 100
            }
        }
    } catch {
        # If an error is encountered, Catch
        Write-Error -ErrorRecord $_ -ErrorAction $callerErrorActionPreference
    }

    # If the calling function does not need the headers (Default Action) return the results of the API Call
    if (-not $returnHeaders) {
        return $apiRequestResults
    } else {
        #If Headers are required, build a PS Custom Object with the Results and the Headers
        $apiRequestAndHeaderResults = New-Object -TypeName psobject
        $apiRequestAndHeaderResults | Add-Member -MemberType NoteProperty -Name "apiRequestResults" -Value $apiRequestResults
        $apiRequestAndHeaderResults | Add-Member -MemberType NoteProperty -Name "Headers" -Value $responseHeaders
        return $apiRequestAndHeaderResults
        #}
    }
}
