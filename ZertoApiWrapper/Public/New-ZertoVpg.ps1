<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function New-ZertoVpg {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(
            HelpMessage = "Name of the VPG",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "VPG Priority. High, Medium, or Low. Default value is Medium"
        )]
        [ValidateSet("High", "Medium", "Low")]
        [string]$vpgPriority = "Medium",
        [Parameter(
            HelpMessage = "Journal History in Hours. Min 1 hour, Max 720 Hours (30 days). Default value is 24 hours"
        )]
        [ValidateRange(1, 720)]
        [int]$journalHistoryInHours = 24,
        [Parameter(
            HelpMessage = "Name(s) of the VM(s) to be protected.",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$protectedVm,
        [Parameter(
            HelpMessage = "Name of the site where the VM(s) will be recovered",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoverySite,
        [Parameter(
            HelpMessage = "Name of the cluster where the VM(s) will be recovered.",
            ParameterSetName = "recoveryClusterDatastore",
            Mandatory = $true
        )]
        [Parameter(
            HelpMessage = "Name of the cluster where the VM(s) will be recovered.",
            ParameterSetName = "recoveryClusterDatastoreCluster",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryCluster,
        [Parameter(
            HelpMessage = "Name of the host where the VM(s) will be recovered.",
            ParameterSetName = "recoveryHostDatastore",
            Mandatory = $true
        )]
        [Parameter(
            HelpMessage = "Name of the host where the VM(s) will be recovered.",
            ParameterSetName = "recoveryHostDatastoreCluster",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryHost,
        [Parameter(
            HelpMessage = "Name of the resource pool where the VM(s) will be recovered.",
            ParameterSetName = "recoveryResourcePoolDatastore",
            Mandatory = $true
        )]
        [Parameter(
            HelpMessage = "Name of the resource pool where the VM(s) will be recovered.",
            ParameterSetName = "recoveryResourcePoolDatastoreCluster",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryResourcePool,
        [Parameter(
            HelpMessage = "Name of the datastore where the VM(s), Volume(s), and Journal(s) will reside.",
            ParameterSetName = "recoveryClusterDatastore",
            Mandatory = $true
        )]
        [Parameter(
            HelpMessage = "Name of the datastore where the VM(s), Volume(s), and Journal(s) will reside.",
            ParameterSetName = "recoveryHostDatastore",
            Mandatory = $true
        )]
        [Parameter(
            HelpMessage = "Name of the datastore where the VM(s), Volume(s), and Journal(s) will reside.",
            ParameterSetName = "recoveryResourcePoolDatastore",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$datastore,
        [Parameter(
            HelpMessage = "Name of the datastore cluster where the VM(s), Volume(s), and Journal(s) will reside.",
            ParameterSetName = "recoveryClusterDatastoreCluster",
            Mandatory = $true
        )]
        [Parameter(
            HelpMessage = "Name of the datastore cluster where the VM(s), Volume(s), and Journal(s) will reside.",
            ParameterSetName = "recoveryHostDatastoreCluster",
            Mandatory = $true
        )]
        [Parameter(
            HelpMessage = "Name of the datastore cluster where the VM(s), Volume(s), and Journal(s) will reside.",
            ParameterSetName = "recoveryResourcePoolDatastoreCluster",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$datastoreCluster,
        [Parameter(
            HelpMessage = "Name of folder at recovery location where the recovered virtual machine(s) will be created.",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryFolder,
        [Parameter(
            HelpMessage = "RPO alert"
        )]
        [ValidateRange(60, 864200)]
        [Int32]$rpoInSeconds = 300,
        [Parameter(
            HelpMessage = "Minimum test interval for this VPG. Valid values are 0: Off, 43200: 1 Month, 131040: 3 Months, 262080: 6 Months, 294560: 9 Months, 252600: 12 Months"
        )]
        [ValidateSet(0, 43200, 131040, 262080, 294560, 252600)]
        [int]$testIntervalInMinutes = 262080,
        [Parameter(
            HelpMessage = "Service profile name to use."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$serviceProfile,
        [Parameter(
            HelpMessage = "Turn on or off WAN and Journal Compression. Default is turned on."
        )]
        [bool]$useWanCompression = $true,
        [Parameter(
            HelpMessage = "Name of ZORG to use."
        )]
        [ValidateNotNullOrEmpty()]
        [String]$zorg,
        [Parameter(
            HelpMessage = "Name of the network to use during a Failover Live \ Move VPG operation.",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$recoveryNetwork,
        [Parameter(
            HelpMessage = "Name of the network to use during a Failover Test operation",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$testNetwork,
        [Parameter(
            HelpMessage = "Name of the datastore to utilize to store Journal data. If not specified, the default datastore will be used.",
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$journalDatastore,
        [Parameter(
            HelpMessage = "Default journal hard limit in megabytes. Default set to 153600 MB (150 GB). Set to 0 to set the journal to unlimited",
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [uint64]$journalHardLimitInMb = 153600,
        [Parameter(
            HelpMessage = "Default journal warning threshold in megabytes. If unset or greater than the hard limit, will be set to 75% of the journal hard limit.",
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [uint64]$journalWarningThresholdInMb = 0
    )

    begin {
        # Create an identifiers table, and start converting names to identifiers.
        $identifiersTable = @{}
        $identifiersTable['recoverySiteIdentifier'] = $(Get-ZertoPeerSite -peerName $recoverySite).siteIdentifier
        $peerSiteNetworks = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -networks)
        $identifiersTable['failoverNetworkIdentifier'] = $peerSiteNetworks | Where-Object {$_.VirtualizationNetworkName -like $recoveryNetwork} | Select-Object -ExpandProperty NetworkIdentifier
        $identifiersTable['testNetworkIdentifier'] = $peerSiteNetworks | Where-Object {$_.VirtualizationNetworkName -like $testNetwork} | Select-Object -ExpandProperty NetworkIdentifier
        $identifiersTable['folderIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -folders | Where-Object {$_.FolderName -like $recoveryFolder}).folderIdentifier
        if ($PSBoundParameters.ContainsKey("zorg")) {
            $identifiersTable['zorgIdentifier'] = $(Get-ZertoZorg | Where-Object {$_.ZorgName -like $zorg}).ZorgIdentifier
        }
        if ($PSBoundParameters.ContainsKey("serviceProfile")) {
            $identifiersTable['serviceProfileIdentifier'] = $(Get-ZertoServiceProfile -siteIdentifier $identifiersTable['recoverySiteIdentifier'] | Where-Object {$_.ServiceProfileName -like $serviceProfile}).serviceProfileIdentifier
        }
        if ($PSBoundParameters.ContainsKey('journalDatastore')) {
            $identifiersTable['journalDatastore'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -datastores | Where-Object {$_.DatastoreName -like $journalDatastore}).DatastoreIdentifier
        }
        # Get identifiers based on parameter set name
        switch ($PSCmdlet.ParameterSetName) {
            "recoveryClusterDatastoreCluster" {
                $identifiersTable['clusterIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -hostclusters | Where-Object {$_.VirtualizationClusterName -like $recoveryCluster}).ClusterIdentifier
                $identifiersTable['datastoreClusterIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -datastoreclusters | Where-Object {$_.DatastoreClusterName -like $datastoreCluster}).DatastoreClusterIdentifier
            }

            "recoveryClusterDatastore" {
                $identifiersTable['clusterIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -hostclusters | Where-Object {$_.VirtualizationClusterName -like $recoveryCluster}).ClusterIdentifier
                $identifiersTable['datastoreIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -datastores | Where-Object {$_.DatastoreName -like $datastore}).DatastoreIdentifier
            }

            "recoveryHostDatastoreCluster" {
                $identifiersTable['recoveryHostIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -hosts | Where-Object {$_.VirtualizationHostName -like $recoveryHost}).HostIdentifier
                $identifiersTable['datastoreClusterIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -datastoreclusters | Where-Object {$_.DatastoreClusterName -like $datastoreCluster}).DatastoreClusterIdentifier
            }

            "recoveryHostDatastore" {
                $identifiersTable['recoveryHostIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -hosts | Where-Object {$_.VirtualizationHostName -like $recoveryHost}).HostIdentifier
                $identifiersTable['datastoreIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -datastores | Where-Object {$_.DatastoreName -like $datastore}).DatastoreIdentifier
            }

            "recoveryResourcePoolDatastoreCluster" {
                $identifiersTable['recoveryResourcePoolIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -resourcepools | Where-Object {$_.ResourcePoolName -like $recoveryResourcePool}).ResourcePoolIdentifier
                $identifiersTable['datastoreClusterIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -datastoreclusters | Where-Object {$_.DatastoreClusterName -like $datastoreCluster}).DatastoreClusterIdentifier
            }

            "recoveryResourcePoolDatastore" {
                $identifiersTable['recoveryResourcePoolIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -resourcepools | Where-Object {$_.ResourcePoolName -like $recoveryResourcePool}).ResourcePoolIdentifier
                $identifiersTable['datastoreIdentifier'] = $(Get-ZertoVirtualizationSite -siteIdentifier $identifiersTable['recoverySiteIdentifier'] -datastores | Where-Object {$_.DatastoreName -like $datastore}).DatastoreIdentifier
            }
        }
        $unprotectedVms = Get-ZertoUnprotectedVm
        $protectedVms = Get-ZertoProtectedVm
        # Create array of VM identifiers
        $vmIdentifiers = @()
        $vmIdentifiers = foreach ($vm in $protectedVm) {
            # If the VM is unprotected, get the identifier
            $vmIdentifier = $unprotectedVms | Where-Object {$_.vmName -like $vm} | Select-Object -ExpandProperty vmIdentifier
            # If the VM is not unprotected, check the protected VMs
            if ( -not $vmIdentifier) {
                # Get all identifiers to test if the VM is eligible to be a member of an additional VPG
                $results = $protectedVms | Where-Object {$_.VmName -like $vm} | Select-Object -ExpandProperty vmIdentifier
                # If VM is currently a member of 3 VPGs, skip it. If it cannot be found, skip it. Otherwise, set the identifier
                if ($results.count -eq 3) {
                    Write-Warning "$vm is already a part of 3 VPGs and cannot be part of an additional VPG. Skipping $vm"
                    continue
                } elseif ($results.count -eq 0) {
                    Write-Warning "$vm not found. Skipping $vm"
                    continue
                } else {
                    $vmIdentifier = $results | Select-Object -First 1
                }
            }
            # Create a custom object to store the information to easily convert to JSON. Return to vmIdentifiers array.
            $returnObject = New-Object PSObject
            $returnObject | Add-Member -MemberType NoteProperty -Name "VmIdentifier" -Value $vmIdentifier
            $returnObject
        }
        if (($journalWarningThresholdInMb -eq 0) -or ($journalWarningThresholdInMb -gt $journalHardLimitInMb)) {
            $journalWarningThresholdInMb = $journalHardLimitInMb * .75
        }

        #Validate all items in the hashtable are populated with valid data.
        $validSettings = $true
        foreach ($item in $identifiersTable.GetEnumerator()) {
            if ([String]::IsNullOrEmpty($item.value)) {
                $validSettings = $false
                Write-Error "$($item.key) is not associated with a valid identifier. Please check the submitted values and try again."
            }
        }
        if ($vmIdentifiers.count -eq 0) {
            $validSettings = $false
            Write-Error "No valid VM names were passed or all passed VMs are already protected and cannot be further protected."
        }

        if ( -not $validSettings ) {
            Write-Error "One or more parameters passed do not have valid identifiers or 0 valid VMs were found. Please check your settings and try again." -ErrorAction Stop
        }
    }

    process {
        $baseUri = "vpgsettings"
        # Create a VPG Settings Identifier
        $vpgSettingsIdentifier = New-ZertoVpgSettingsIdentifier -newVpg
        # Put base settings into an object easy to manipulate
        $baseSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsIdentifier
        # Set settings equal to passed and default parameters
        $baseSettings.basic.name = $vpgName
        $baseSettings.basic.journalHistoryInHours = $journalHistoryInHours
        $baseSettings.basic.Priority = $vpgPriority
        $baseSettings.basic.recoverySiteIdentifier = $identifiersTable['recoverySiteIdentifier']
        $baseSettings.basic.RpoInSeconds = $rpoInSeconds
        if ($identifiersTable.ContainsKey('serviceProfileIdentifier')) {
            $baseSettings.basic.ServiceProfileIdentifier = $identifiersTable['serviceProfileIdentifier']
        }
        $baseSettings.basic.TestIntervalInMinutes = $testIntervalInMinutes
        $baseSettings.basic.useWanCompression = $useWanCompression
        if ($identifiersTable.ContainsKey('zorgIdentifier')) {
            $baseSettings.basic.ZorgIdentifier = $identifiersTable['zorgIdentifier']
        }
        $baseSettings.Networks.Failover.Hypervisor.DefaultNetworkIdentifier = $identifiersTable['failoverNetworkIdentifier']
        $baseSettings.Networks.FailoverTest.Hypervisor.DefaultNetworkIdentifier = $identifiersTable['testNetworkIdentifier']
        $baseSettings.Recovery.DefaultFolderIdentifier = $identifiersTable['folderIdentifier']
        switch ($PSCmdlet.ParameterSetName) {
            "recoveryClusterDatastoreCluster" {
                $baseSettings.Recovery.DefaultDatastoreClusterIdentifier = $identifiersTable['datastoreClusterIdentifier']
                $baseSettings.Recovery.DefaultHostClusterIdentifier = $identifiersTable['clusterIdentifier']
            }

            "recoveryClusterDatastore" {
                $baseSettings.Recovery.DefaultHostClusterIdentifier = $identifiersTable['clusterIdentifier']
                $baseSettings.Recovery.DefaultDatastoreIdentifier = $identifiersTable['datastoreIdentifier']
            }

            "recoveryHostDatastoreCluster" {
                $baseSettings.Recovery.DefaultDatastoreClusterIdentifier = $identifiersTable['datastoreClusterIdentifier']
                $baseSettings.Recovery.DefaultHostIdentifier = $identifiersTable['hostIdentifier']
            }

            "recoveryHostDatastore" {
                $baseSettings.Recovery.DefaultHostIdentifier = $identifiersTable['hostIdentifier']
                $baseSettings.Recovery.DefaultDatastoreIdentifier = $identifiersTable['datastoreIdentifier']
            }

            "recoveryResourcePoolDatastoreCluster" {
                $baseSettings.Recovery.ResourcePoolIdentifier = $identifiersTable['recoveryResourcePoolIdentifier']
                $baseSettings.Recovery.DefaultDatastoreClusterIdentifier = $identifiersTable['datastoreClusterIdentifier']
            }

            "recoveryResourcePoolDatastore" {
                $baseSettings.Recovery.ResourcePoolIdentifier = $identifiersTable['recoveryResourcePoolIdentifier']
                $baseSettings.Recovery.DefaultDatastoreIdentifier = $identifiersTable['datastoreIdentifier']
            }
        }
        # If only 1 VM is selected, force VMs settings to be an array.
        If ($vmIdentifiers.count -eq 1) {
            $basesettings.Vms = @()
            $baseSettings.Vms += $vmIdentifiers
        } else {
            $baseSettings.Vms = $vmIdentifiers
        }
        if ($identifiersTable.ContainsKey('journalDatastore')) {
            $baseSettings.Journal.DatastoreIdentifier = $identifiersTable['journalDatastore']
        }
        $baseSettings.Journal.Limitation.HardLimitInMB = $journalHardLimitInMb
        $baseSettings.Journal.Limitation.WarningThresholdInMB = $journalWarningThresholdInMb
        $settingsURI = "{0}/{1}" -f $baseUri, $vpgSettingsIdentifier
        if ($PSCmdlet.ShouldProcess($($baseSettings | ConvertTo-Json -Depth 10))) {
            $results = Invoke-ZertoRestRequest -uri $settingsURI -body $($baseSettings | ConvertTo-Json -Depth 10) -method "PUT"
        }
    }

    end {
        # Return vpgSettings Identifier as a string to pass into Save function.
        return $vpgSettingsIdentifier.toString()
    }
}
