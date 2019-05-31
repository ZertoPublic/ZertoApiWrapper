function Invoke-ZertoRestRequest {
    [cmdletbinding()]
    param(
        [string]$method = "GET",
        [string]$uri,
        [string]$apiVersion = "v1",
        [string]$body,
        [string]$contentType = "application/json",
        [System.Management.Automation.PSCredential]
        $credential,
        [switch]$returnHeaders
    )
    $callerErrorActionPreference = $ErrorActionPreference
    # If the ZVM server and Port not defined, Stop Call
    if ( -not ((Test-Path variable:script:zvmServer) -and (Test-Path variable:script:zvmPort)) ) {
        Write-Error -Message "Zerto Connection does not Exist. Please run Connect-ZertoServer first to establish a connection"
        break
    }

    # If the Headers exist and the Last action was more than 30 minutes ago, Session is Expired
    if ( (Test-Path variable:script:zvmHeaders) -and $([datetime]$script:zvmLastAction).addMinutes(30) -lt $(get-date) ) {
        Write-Error -Message "Authorization Token has Expired. Please re-authorize to the Zerto Virtual Manager"
        break
    } else {

        # Build the URI to be submitted
        $submittedURI = "https://{0}:{1}/{2}/{3}" -f $script:zvmServer, $script:zvmPort, $apiVersion, $uri
        try {
            # Set the zvmLastAction time and try to submit the REST Request
            $script:zvmLastAction = (get-date).Ticks
            # If running PwSh - Use this Invoke-RestMethod with passed Variables
            if ($PSVersionTable.PSVersion.Major -ge 6) {
                $apiRequestResults = Invoke-RestMethod -Uri $submittedURI -Headers $script:zvmHeaders -Method $method -Body $body -ContentType $contentType -Credential $credential -SkipCertificateCheck -ResponseHeadersVariable responseHeaders -TimeoutSec 100
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
                if ($uri -eq "session/add" -and $method -eq "POST") {
                    $apiRequestResults = Invoke-WebRequest -Uri $submittedURI -Headers $script:zvmHeaders -Method $method -Body $body -ContentType $contentType -Credential $credential -TimeoutSec 100
                    $responseHeaders = @{}
                    $responseHeaders['x-zerto-session'] = @($apiRequestResults.Headers['x-zerto-session'])
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
        }
    }
}
