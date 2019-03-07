<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoVpgSetting {
    [cmdletbinding(
        DefaultParameterSetName = "main",
        SupportsShouldProcess = $false
    )]
    param(
        [Parameter(
            ParameterSetName = "vpgSettingsIdentifier",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "backup",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "dayOfWeek",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "retentionPeriod",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "schedulerPeriod",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "basic",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "bootGroup",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "journal",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "networks",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "priority",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "recovery",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "scripting",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "vms",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "vmIdentifier",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "nics",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "nicIdentifier",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "volumes",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "volumeIdentifier",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [string]$vpgSettingsIdentifier,
        [Parameter(
            ParameterSetName = "backup",
            Mandatory = $true,
            HelpMessage = "Return backup information for VPG identifier specified"
        )]
        [switch]$backup,
        [Parameter(
            ParameterSetName = "dayOfWeek",
            Mandatory = $true,
            HelpMessage = "Get the day of week a backup is scheduled"
        )]
        [switch]$dayOfWeek,
        [Parameter(
            ParameterSetName = "retentionPeriod",
            Mandatory = $true,
            HelpMessage = "Get the retention period for a backup"
        )]
        [switch]$retentionPeriod,
        [Parameter(
            ParameterSetName = "schedulerPeriod",
            Mandatory = $true,
            HelpMessage = "Get the backup schedule"
        )]
        [switch]$schedulerPeriod,
        [Parameter(
            ParameterSetName = "basic",
            Mandatory = $true,
            HelpMessage = "Get VPG Basic Settings"
        )]
        [switch]$basic,
        [Parameter(
            ParameterSetName = "bootGroup",
            Mandatory = $true,
            HelpMessage = "Get VPG Boot Settings"
        )]
        [switch]$bootgroup,
        [Parameter(
            ParameterSetName = "journal",
            Mandatory = $true,
            HelpMessage = "Get VPG Journal Settings"
        )]
        [switch]$journal,
        [Parameter(
            ParameterSetName = "networks",
            Mandatory = $true,
            HelpMessage = "Get VPG Network Settings"
        )]
        [switch]$networks,
        [Parameter(
            ParameterSetName = "priority",
            Mandatory = $true,
            HelpMessage = "Get VPG Priority Settings"
        )]
        [switch]$priority,
        [Parameter(
            ParameterSetName = "recovery",
            Mandatory = $true,
            HelpMessage = "Get VPG Recovery Settings"
        )]
        [switch]$rcovery,
        [Parameter(
            ParameterSetName = "scripting",
            Mandatory = $true,
            HelpMessage = "Get VPG Recovery Settings"
        )]
        [switch]$scripting,
        [Parameter(
            ParameterSetName = "vms",
            Mandatory = $true,
            HelpMessage = "Get all settings for all VMs in a VPG."
        )]
        [switch]$vms,
        [Parameter(
            ParameterSetName = "vmIdentifier",
            Mandatory = $true,
            HelpMessage = "Get all settings for selected VM"
        )]
        [Parameter(
            ParameterSetName = "nics",
            Mandatory = $true,
            HelpMessage = "VM Identifier"
        )]
        [Parameter(
            ParameterSetName = "volumes",
            Mandatory = $true,
            HelpMessage = "VM Identifier"
        )]
        [Parameter(
            ParameterSetName = "nicIdentifier",
            Mandatory = $true,
            HelpMessage = "VM Identifier"
        )]
        [Parameter(
            ParameterSetName = "volumeIdentifier",
            Mandatory = $true,
            HelpMessage = "VM Identifier"
        )]
        [string]$vmIdentifier,
        [Parameter(
            ParameterSetName = "nics",
            Mandatory = $true,
            HelpMessage = "Return NIC information for all NICs of the specified VM"
        )]
        [switch]$nics,
        [Parameter(
            ParameterSetName = "nicIdentifier",
            Mandatory = $true,
            HelpMessage = "Return NIC information for specified NIC of the specified VM"
        )]
        [string]$nicIdentifier,
        [Parameter(
            ParameterSetName = "volumes",
            Mandatory = $true,
            HelpMessage = "Return Volume information for all volumes of the specified VM"
        )]
        [switch]$volumes,
        [Parameter(
            ParameterSetName = "volumeIdentifier",
            Mandatory = $true,
            HelpMessage = "Return volume information for the specified volume of the specified VM"
        )]
        [string]$volumeIdentifier
    )

    begin {
        $baseUri = "vpgSettings"
        $returnObject = @()
    }

    #TODO - Update to Switch Logic
    process {
        if ( $PSCmdlet.ParameterSetName -eq "main" ) {
            $returnObject = Invoke-ZertoRestRequest -uri $baseUri
        } elseif ($PSCmdlet.ParameterSetName -eq "vpgSettingsIdentifier") {
            $uri = "{0}/{1}" -f $baseUri, $vpgSettingsIdentifier
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } elseif ( $PSCmdlet.ParameterSetName -eq "dayOfWeek" -or $PSCmdlet.ParameterSetName -eq "retentionPeriod" -or $PSCmdlet.ParameterSetName -eq "schedulerPeriod"  ) {
            $uri = "{0}/{1}/backup/{2}" -f $baseUri, $vpgSettingsIdentifier, $PSCmdlet.ParameterSetName.ToLower()
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } elseif ( $PSCmdlet.ParameterSetName -eq "nics" -or $PSCmdlet.ParameterSetName -eq "volumes" ) {
            $uri = "{0}/{1}/vms/{2}/{3}" -f $baseUri, $vpgSettingsIdentifier, $vmIdentifier, $PSCmdlet.ParameterSetName.ToLower()
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } elseif ( $PSCmdlet.ParameterSetName -eq "vmIdentifier" ) {
            $uri = "{0}/{1}/vms/{2}" -f $baseUri, $vpgSettingsIdentifier, $vmIdentifier
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } elseif ( $PSCmdlet.ParameterSetName -eq "nicIdentifier" ) {
            $uri = "{0}/{1}/vms/{2}/nics/{3}" -f $baseUri, $vpgSettingsIdentifier, $vmIdentifier, $nicIdentifier
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } elseif ( $PSCmdlet.ParameterSetName -eq "volumeIdentifier" ) {
            $uri = "{0}/{1}/vms/{2}/volumes/{3}" -f $baseUri, $vpgSettingsIdentifier, $vmIdentifier, $volumeIdentifier
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } else {
            $uri = "{0}/{1}/{2}" -f $baseUri, $vpgSettingsIdentifier, $PSCmdlet.ParameterSetName.ToLower()
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        }
    }

    end {
        return $returnObject
    }
}
