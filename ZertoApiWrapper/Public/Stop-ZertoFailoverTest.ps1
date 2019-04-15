<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Stop-ZertoFailoverTest {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter(
            HelpMessage = "Name(s) of VPG(s) to stop testing.",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName,
        [Parameter(
            HelpMessage = "Was the test successful? True or False. True is Default."
        )]
        [bool]$failoverTestSuccess = $true,
        [Parameter(
            HelpMessage = "Free text field for any notes to add to the test report."
        )]
        [string]$failoverTestSummary = "Stop Failover Test for $vpgName"
    )

    begin {
        $baseUri = "vpgs"
        $body = @{"FailoverTestSuccess" = $failoverTestSuccess; "FailoverTestSummary" = $failoverTestSummary}
    }

    process {
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $vpgId) {
                Write-Error "VPG: $vpgName Not Found. Please check the name and try again!" -ErrorAction Stop
            }
            $uri = "{0}/{1}/FailoverTestStop" -f $baseUri, $vpgId
            if ($PSCmdlet.ShouldProcess("Stopping Failover Test on VPG: $name")) {
                Invoke-ZertoRestRequest -uri $uri -method "POST" -body $($body | ConvertTo-Json)
            }
        }
    }

    end {
        #Nothing to do
    }
}
