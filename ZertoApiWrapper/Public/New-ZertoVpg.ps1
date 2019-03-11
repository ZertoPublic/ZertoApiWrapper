function New-ZertoVpg {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name of the VPG",
            Mandatory = $true
        )]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "VPG Priority. High, Medium, or Low."
        )]
        [ValidateSet("High", "Medium", "Low")]
        [string]$vpgPriority = "Medium",
        [Parameter(
            HelpMessage = "Journal History in Hours. Min 1 hour, Max 720 Hours (30 days)"
        )]
        [ValidateRange(1, 720)]
        [int]$journalHistoryInHours = 24,
        [Parameter(
            HelpMessage = "Name(s) of the VM(s) to be protected.",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()][string[]]$protectedVm,
        [Parameter(
            HelpMessage = "Name of the site where the VM(s) will be recoveryed",
            Mandatory = $true
        )]
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
        [string]$datastoreCluster,
        [Parameter(
            HelpMessage = "Name of folder at recovery location where the recovered virtual machine(s) will be created.",
            Mandatory = $true
        )]
        [string]$recoveryFolder,
        [Parameter(
            HelpMessage = "RPO alert"
        )]
        [ValidateRange(60, 864200)][Int32]$rpoInSeconds = 300,
        [Parameter(
            HelpMessage = "Minimum test interval for this VPG. Valid values are 0: Off, 43200: 1 Month, 131040: 3 Months"
        )]
        [ValidateSet(0, 43200, 131040, 262080, 294560, 252600)][int]$testIntervalInMinutes = 262080,
        [Parameter(
            HelpMessage = "Service profile name to use."
        )]
        [string]$serviceProfile,
        [Parameter(
            HelpMessage = "Turn on or off WAN and Journal Compression. Default is turned on."
        )]
        [bool]$useWanCompression = $true,
        [Parameter(
            HelpMessage = "Name of ZORG to use."
        )]
        [String]$zorg,
        [Parameter(
            HelpMessage = "Name of the network to use during a Failover Live \ Move VPG operation.",
            Mandatory = $true
        )]
        [String]$recoveryNetwork,
        [Parameter(
            HelpMessage = "Name of the network to use during a Failover Test operation",
            Mandatory = $true
        )]
        [string]$testNetwork
    )

    begin {
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
        $vmIdentifiers = @()
        $vmIdentifiers = foreach ($vm in $protectedVm) {
            $vmIdentifier = $unprotectedVms | Where-Object {$_.vmName -like $vm} | Select-Object -ExpandProperty vmIdentifier
            if ( -not $vmIdentifier) {
                $results = $protectedVms | Where-Object {$_.VmName -like $vm} | Select-Object -ExpandProperty vmIdentifier
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
            $returnObject = New-Object PSObject
            $returnObject | Add-Member -MemberType NoteProperty -Name "VmIdentifier" -Value $vmIdentifier
            $returnObject
        }
    }

    process {
        $baseUri = "vpgsettings"
        $vpgSettingsIdentifier = Invoke-ZertoRestRequest -uri $baseUri -body "{}" -method "POST"
        $baseSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsIdentifier
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
        If ($vmIdentifiers.count -eq 1) {
            $basesettings.Vms = @()
            $baseSettings.Vms += $vmIdentifiers
        } else {
            $baseSettings.Vms = $vmIdentifiers
        }
        $settingsURI = "{0}/{1}" -f $baseUri, $vpgSettingsIdentifier
        Invoke-ZertoRestRequest -uri $settingsURI -body $($baseSettings | ConvertTo-Json -Depth 10) -method "PUT" | Out-Null
    }

    end {
        return $vpgSettingsIdentifier.toString()
    }
}