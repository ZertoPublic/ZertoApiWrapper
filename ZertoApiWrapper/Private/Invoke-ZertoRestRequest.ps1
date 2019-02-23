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
            $apiRequestResults = Invoke-RestMethod -Uri $submittedURI -Headers $script:zvmHeaders -Method $method -Body $body -ContentType $contentType -Credential $credential -SkipCertificateCheck -ResponseHeadersVariable responseHeaders -TimeoutSec 100
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
