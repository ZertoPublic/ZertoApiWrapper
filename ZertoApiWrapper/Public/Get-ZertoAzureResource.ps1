<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoAzureResource {
    [CmdletBinding(DefaultParameterSetName = "SiteNameVmInstanceType")]
    param (
        [Parameter(
            Mandatory,
            HelpMessage = "Name the Azure Site you wish to get the information.",
            ParameterSetName = "SiteNameSecurityGroup"
        )]
        [Parameter(
            Mandatory,
            HelpMessage = "Name the Azure Site you wish to get the information.",
            ParameterSetName = "SiteNameSubnet"
        )]
        [Parameter(
            Mandatory,
            HelpMessage = "Name the Azure Site you wish to get the information.",
            ParameterSetName = "SiteNameNetwork"
        )]
        [Parameter(
            Mandatory,
            HelpMessage = "Name the Azure Site you wish to get the information.",
            ParameterSetName = "SiteNameVmInstanceType"
        )]
        [ValidateNotNullOrEmpty()]
        [String]$SiteName,
        [Parameter(
            Mandatory,
            HelpMessage = "Site Identifier of the Azure Site you wish to get the information.",
            ParameterSetName = "SiteIdentifierSecurityGroup"
        )]
        [Parameter(
            Mandatory,
            HelpMessage = "Site Identifier of the Azure Site you wish to get the information.",
            ParameterSetName = "SiteIdentifierSubnet"
        )]
        [Parameter(
            Mandatory,
            HelpMessage = "Site Identifier of the Azure Site you wish to get the information.",
            ParameterSetName = "SiteIdentifierNetwork"
        )]
        [Parameter(
            Mandatory,
            HelpMessage = "Site Identifier of the Azure Site you wish to get the information.",
            ParameterSetName = "SiteIdentifierVmInstanceType"
        )]
        [ValidateNotNullOrEmpty()]
        [String]$SiteIdentifier,
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteIdentifierSecurityGroup",
            HelpMessage = "Use this switch to get information about the supported Security Groups"
        )]
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteNameSecurityGroup",
            HelpMessage = "Use this switch to get information about the supported Security Groups"
        )]
        [Switch]$SecurityGroup,
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteIdentifierSubnet",
            HelpMessage = "Use this switch to get information about the supported Subnets"
        )]
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteNameSubnet",
            HelpMessage = "Use this switch to get information about the supported Subnets"
        )]
        [Switch]$Subnet,
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteIdentifierNetwork",
            HelpMessage = "Use this switch to get information about the supported Networks (VNets)."
        )]
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteNameNetwork",
            HelpMessage = "Use this switch to get information about the supported Networks (VNets)."
        )]
        [Switch]$Network,
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteIdentifierVmInstanceType",
            HelpMessage = "Use this switch to get information about the supported Vm Instance Types."
        )]
        [Parameter(
            Mandatory,
            ParameterSetName = "SiteNameVmInstanceType",
            HelpMessage = "Use this switch to get information about the supported Vm Instance Types."
        )]
        [Switch]$VmInstanceType
    )

    begin {

    }

    process {
        if ($PSCmdlet.ParameterSetName -match "SiteName") {
            $SiteInfo = Get-ZertoPeerSite | Where-Object { $_.PeerSiteName -match $SiteName }
            if ($null -eq $SiteInfo) {
                Write-Error "Unable to find a peer site with the name $SiteName. Please check your parameters and try again." -ErrorAction Stop
            }
            $SiteIdentifier = $SiteInfo | Select-Object -ExpandProperty SiteIdentifier
        } else {
            $SiteInfo = Get-ZertoPeerSite -siteIdentifier $SiteIdentifier
        }
        if ($SiteInfo.SiteType -notmatch "Azure") {
            Write-Error "Specified site is not an Azure site. Please specify an Azure site and try again." -ErrorAction Stop
        }
        $baseUri = "virtualizationsites/{0}/publicCloud" -f $SiteIdentifier

        switch -wildcard ($PSCmdlet.ParameterSetName) {
            "*VmInstanceType" {
                $uri = "{0}/VmInstanceType" -f $baseUri
            }
            "*Subnet" {
                $uri = "{0}/subnets" -f $baseUri
            }
            "*Network" {
                $uri = "{0}/virtualNetworks" -f $baseUri
            }
            "*SecurityGroup" {
                $uri = "{0}/securityGroups" -f $baseUri
            }
        }
        Invoke-ZertoRestRequest -uri $uri
    }

    end {

    }
}
