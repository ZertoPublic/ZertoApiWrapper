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
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "backup",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "dayOfWeek",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "retentionPeriod",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "schedulerPeriod",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "basic",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "bootGroup",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "journal",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "networks",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "priority",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "recovery",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "scripting",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "vms",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "vmIdentifier",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "nics",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "nicIdentifier",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "volumes",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "volumeIdentifier",
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true,
            Mandatory = $true
        )]
        [string]$vpgSettingsIdentifier,
        [Parameter(
            ParameterSetName = "backup",
            Mandatory = $true
        )]
        [switch]$backup,
        [Parameter(
            ParameterSetName = "dayOfWeek",
            Mandatory = $true
        )]
        [switch]$dayOfWeek,
        [Parameter(
            ParameterSetName = "retentionPeriod",
            Mandatory = $true
        )]
        [switch]$retentionPeriod,
        [Parameter(
            ParameterSetName = "schedulerPeriod",
            Mandatory = $true
        )]
        [switch]$schedulerPeriod,
        [Parameter(
            ParameterSetName = "basic",
            Mandatory = $true
        )]
        [switch]$basic,
        [Parameter(
            ParameterSetName = "bootGroup",
            Mandatory = $true
        )]
        [switch]$bootgroup,
        [Parameter(
            ParameterSetName = "journal",
            Mandatory = $true
        )]
        [switch]$journal,
        [Parameter(
            ParameterSetName = "networks",
            Mandatory = $true
        )]
        [switch]$networks,
        [Parameter(
            ParameterSetName = "priority",
            Mandatory = $true
        )]
        [switch]$priority,
        [Parameter(
            ParameterSetName = "recovery",
            Mandatory = $true
        )]
        [switch]$rcovery,
        [Parameter(
            ParameterSetName = "scripting",
            Mandatory = $true
        )]
        [switch]$scripting,
        [Parameter(
            ParameterSetName = "vms",
            Mandatory = $true )]
        [switch]$vms,
        [Parameter(
            ParameterSetName = "vmIdentifier",
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "nics",
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "volumes",
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "nicIdentifier",
            Mandatory = $true
        )]
        [Parameter(
            ParameterSetName = "volumeIdentifier",
            Mandatory = $true
        )]
        [string]$vmIdentifier,
        [Parameter(
            ParameterSetName = "nics",
            Mandatory = $true
        )]
        [switch]$nics,
        [Parameter(
            ParameterSetName = "nicIdentifier",
            Mandatory = $true
        )]
        [string]$nicIdentifier,
        [Parameter(
            ParameterSetName = "volumes",
            Mandatory = $true
        )]
        [switch]$volumes,
        [Parameter(
            ParameterSetName = "volumeIdentifier",
            Mandatory = $true
        )]
        [string]$volumeIdentifier
    )

    begin {
        $baseUri = "vpgSettings"
        $returnObject = @()
    }

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
