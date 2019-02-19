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
    if ( Test-Path Env:zertoConnectionInformation ) {
        $zertoConnectionInformation = $(Get-Item -Path Env:zertoConnectionInformation).value | ConvertFrom-Json
    } else {
        Write-Error -Message "Zerto Connection does not Exist. Please run Connect-ZertoServer first to establish a connection"
        break
    }
    if ( Test-Path Env:zertoAuthorizationHeaders ) {
        $json = $(Get-Item Env:zertoAuthorizationHeaders).value | ConvertFrom-Json
        $headers = @{}
        $json.psobject.properties | ForEach-Object { $headers[$_.Name] = $_.Value }
    } else {
        $headers = $null
    }
    if ( (Test-Path Env:zertoAuthorizationHeaders) -and $([datetime]$zertoConnectionInformation.lastAction).addMinutes(30) -lt $(get-date) ) {
        Write-Error -Message "Authorization Token has Expired or Does not exist in Env variables. Please re-authorize to the Zerto Virtual Manager"
        break
    } else {
        $submittedURI = "https://{0}:{1}/{2}/{3}" -f $zertoConnectionInformation.zertoServer, $zertoConnectionInformation.zertoPort, $apiVersion, $uri
        try {
            $lastAction = (get-date).Ticks
            $apiRequestResults = Invoke-RestMethod -Uri $submittedURI -Headers $headers -Method $method -Body $body -ContentType $contentType -Credential $credential -SkipCertificateCheck -ResponseHeadersVariable responseHeaders -TimeoutSec 100
            $zertoConnectionInformation.lastAction = $lastAction
            Set-Item -Path Env:zertoConnectionInformation -Value $($zertoConnectionInformation | ConvertTo-Json -Compress)
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
