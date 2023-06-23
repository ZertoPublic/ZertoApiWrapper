$Body = @{
    'client_id'     = 'zerto-client'
    'username'      = 'admin'
    'password'      = 'Zertodata987!'
    'grant_type'    = 'password'
}
$Params = @{
    'Uri'         = 'https://192.168.50.60/auth/realms/zerto/protocol/openid-connect/token'
    'Method'      = 'Post'
    'Body'        = $Body
    'ContentType' = 'application/x-www-form-urlencoded'
}
$Result = Invoke-RestMethod @Params -SkipCertificateCheck

Write-Host $Result

$ExpiresIn = $Result.expires_in
$ExpiresAt = (Get-Date).AddSeconds($ExpiresIn)

Write-Host $ExpiresAt

Write-Host $Result
