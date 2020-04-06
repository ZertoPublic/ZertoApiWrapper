<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Set-ZertoUserCredential {
    [cmdletbinding(
        SupportsShouldProcess,
        ConfirmImpact = 'High'
    )]
    param(
        [Parameter(
            HelpMessage = "PSCredential Object that conatins the username and password for the updated credentials.",
            Mandatory
        )]
        [pscredential]$UserCredential
    )

    begin {

    }

    process {
        $uri = '/localsite/virtualizationsettings'
        $body = @{
            UserName = $UserCredential.UserName
            Password = $UserCredential.GetNetworkCredential().Password
        }
        if ( $PSCmdlet.ShouldProcess( $script:zertoServer, "Updating hypervisor service account credentials" )) {
            Invoke-ZertoRestRequest -uri $uri -Method PUT -body ($body | ConvertTo-Json)
        }
    }

    end {

    }
}
