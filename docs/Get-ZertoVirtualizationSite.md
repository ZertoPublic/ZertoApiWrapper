---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Get-ZertoVirtualizationSite

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-ZertoVirtualizationSite [<CommonParameters>]
```

### folders
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-folders] [<CommonParameters>]
```

### devices
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-devices] [-hostIdentifier <String>] [<CommonParameters>]
```

### vms
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-vms] [<CommonParameters>]
```

### resourcePools
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-resourcePools] [<CommonParameters>]
```

### networks
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-networks] [<CommonParameters>]
```

### hosts
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-hostIdentifier <String>] [-hosts] [<CommonParameters>]
```

### hostClusters
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-hostClusters] [<CommonParameters>]
```

### datastores
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-datastores] [<CommonParameters>]
```

### datastoreClusters
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [-datastoreClusters] [<CommonParameters>]
```

### siteIdentifier
```
Get-ZertoVirtualizationSite -siteIdentifier <String> [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -datastoreClusters
When selected, will return all datastore clusters at the specified site.

```yaml
Type: SwitchParameter
Parameter Sets: datastoreClusters
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -datastores
When selected, will return all datastores at the specified site.

```yaml
Type: SwitchParameter
Parameter Sets: datastores
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -devices
When selected, will return all devices at the specified site.

```yaml
Type: SwitchParameter
Parameter Sets: devices
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -folders
Return all folders at the selected site.

```yaml
Type: SwitchParameter
Parameter Sets: folders
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hostClusters
Return all host clusters at the selected site.

```yaml
Type: SwitchParameter
Parameter Sets: hostClusters
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hostIdentifier
The identifier of the host at the selected site to return information for only one host.

```yaml
Type: String
Parameter Sets: devices, hosts
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hosts
Return all hosts at the selected site.
If a host identifier is provided, return only that host.

```yaml
Type: SwitchParameter
Parameter Sets: hosts
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networks
Return all networks at the selected site.

```yaml
Type: SwitchParameter
Parameter Sets: networks
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resourcePools
Return all resource pools at the selected site.

```yaml
Type: SwitchParameter
Parameter Sets: resourcePools
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIdentifier
The identifier of the Zerto Virtual Manager site.

```yaml
Type: String
Parameter Sets: folders, devices, vms, resourcePools, networks, hosts, hostClusters, datastores, datastoreClusters, siteIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vms
Return all VMs at the selected site.

```yaml
Type: SwitchParameter
Parameter Sets: vms
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Zerto REST API Virtualization Sites End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.082.html#)
