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
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "backup",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved. Please note, this parameter is ONLY available in Zerto version 7.5 and earlier. Attempting to run this switch against a Zerto Virtual Manager version 8.0 or higher result in an error."
        )]
        [Parameter(
            ParameterSetName = "dayOfWeek",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "retentionPeriod",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "schedulerPeriod",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "basic",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "bootGroup",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "journal",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "networks",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "priority",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "recovery",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "scripting",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "vms",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "vmIdentifier",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "nics",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "nicIdentifier",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "volumes",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "volumeIdentifier",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [Parameter(
            ParameterSetName = "ltr",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true,
            HelpMessage = "The identifier of the VPG settings object for which information is retrieved."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgSettingsId", "settingsId")]
        [string[]]$vpgSettingsIdentifier,
        [Parameter(
            ParameterSetName = "backup",
            Mandatory = $true,
            HelpMessage = "Return backup information for VPG identifier specified. Please note, this parameter is ONLY available in Zerto version 7.5 and earlier. Attempting to run this switch against a Zerto Virtual Manager version 8.0 or higher result in an error."
        )]
        [switch]$backup,
        [Parameter(
            ParameterSetName = "dayOfWeek",
            Mandatory = $true,
            HelpMessage = "Get the day of week a backup is scheduled. Please note, this parameter is ONLY available in Zerto version 7.5 and earlier. Attempting to run this switch against a Zerto Virtual Manager version 8.0 or higher result in an error."
        )]
        [switch]$dayOfWeek,
        [Parameter(
            ParameterSetName = "retentionPeriod",
            Mandatory = $true,
            HelpMessage = "Get the retention period for a backup. Please note, this parameter is ONLY available in Zerto version 7.5 and earlier. Attempting to run this switch against a Zerto Virtual Manager version 8.0 or higher result in an error."
        )]
        [switch]$retentionPeriod,
        [Parameter(
            ParameterSetName = "schedulerPeriod",
            Mandatory = $true,
            HelpMessage = "Get the backup schedule. Please note, this parameter is ONLY available in Zerto version 7.5 and earlier. Attempting to run this switch against a Zerto Virtual Manager version 8.0 or higher result in an error."
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
        [Alias("rcovery")]
        [switch]$recovery,
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
        [ValidateNotNullOrEmpty()]
        [Alias("vmId")]
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
        [ValidateNotNullOrEmpty()]
        [Alias("nicId")]
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
        [ValidateNotNullOrEmpty()]
        [Alias("volumeId")]
        [string]$volumeIdentifier,
        [Parameter(
            ParameterSetName = "ltr",
            Mandatory = $true,
            HelpMessage = "Return LTR information for the specified VPG. Please note, this parameter is ONLY available in Zerto version 8.0 and later. Attempting to run this switch against a Zerto Virtual Manager version 7.5 or lower will result in an error."
        )]
        [switch]$ltr

    )

    begin {
        $baseUri = "vpgSettings"
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                Invoke-ZertoRestRequest -uri $baseUri
                break
            }

            "vpgSettingsIdentifier" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "dayOfWeek" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/backup/{2}" -f $baseUri, $id, $PSCmdlet.ParameterSetName.ToLower()
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "retentionPeriod" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/backup/{2}" -f $baseUri, $id, $PSCmdlet.ParameterSetName.ToLower()
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "schedulerPeriod" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/backup/{2}" -f $baseUri, $id, $PSCmdlet.ParameterSetName.ToLower()
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "nics" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/vms/{2}/{3}" -f $baseUri, $id, $vmIdentifier, $PSCmdlet.ParameterSetName.ToLower()
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "volumes" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/vms/{2}/{3}" -f $baseUri, $id, $vmIdentifier, $PSCmdlet.ParameterSetName.ToLower()
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "vmIdentifier" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/vms/{2}" -f $baseUri, $id, $vmIdentifier
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "nicIdentifier" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/vms/{2}/nics/{3}" -f $baseUri, $id, $vmIdentifier, $nicIdentifier
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            "volumeIdentifier" {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/vms/{2}/volumes/{3}" -f $baseUri, $id, $vmIdentifier, $volumeIdentifier
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }

            default {
                foreach ($id in $vpgSettingsIdentifier) {
                    $uri = "{0}/{1}/{2}" -f $baseUri, $id, $PSCmdlet.ParameterSetName.ToLower()
                    Invoke-ZertoRestRequest -uri $uri
                }
                break
            }
        }
    }

    end {
        #Nothing to do!
    }
}
