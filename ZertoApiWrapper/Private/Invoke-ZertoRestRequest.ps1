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
    if ( -not (Test-Path variable:script:zvmServer -and Test-Path variable:script:zvmPort) ) {
        Write-Error -Message "Zerto Connection does not Exist. Please run Connect-ZertoServer first to establish a connection"
        break
    }
    if ( Test-Path variable:script:zvmHeaders ) {
        $headers = $script:zvmHeaders
    } else {
        $headers = $null
    }
    if ( (Test-Path variable:script:zvmHeaders) -and $([datetime]$script:zvmLastAction).addMinutes(30) -lt $(get-date) ) {
        Write-Error -Message "Authorization Token has Expired or Does not exist in Env variables. Please re-authorize to the Zerto Virtual Manager"
        break
    } else {
        $submittedURI = "https://{0}:{1}/{2}/{3}" -f $script:zvmServer, $script:zvmPort, $apiVersion, $uri
        try {
            $script:zvmLastAction = (get-date).Ticks
            $apiRequestResults = Invoke-RestMethod -Uri $submittedURI -Headers $headers -Method $method -Body $body -ContentType $contentType -Credential $credential -SkipCertificateCheck -ResponseHeadersVariable responseHeaders -TimeoutSec 100
        } catch {
            Write-Error -ErrorRecord $_ -ErrorAction $callerErrorActionPreference
        }
        if (-not $returnHeaders) {
            return $apiRequestResults
        } else {
            $apiRequestAndHeaderResults = New-Object -TypeName psobject
            $apiRequestAndHeaderResults | Add-Member -MemberType NoteProperty -Name "apiRequestResults" -Value $apiRequestResults
            $apiRequestAndHeaderResults | Add-Member -MemberType NoteProperty -Name "Headers" -Value $responseHeaders
            return $apiRequestAndHeaderResults
        }
    }
}
