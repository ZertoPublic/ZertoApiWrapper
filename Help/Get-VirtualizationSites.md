---
external help file: ZertoFunctions-help.xml
Module Name: ZertoFunctions
online version:
schema: 2.0.0
---

# Get-VirtualizationSites

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-VirtualizationSites [<CommonParameters>]
```

### vms
```
Get-VirtualizationSites -siteIdentifiers <String[]> [-vms] [<CommonParameters>]
```

### resourcePools
```
Get-VirtualizationSites -siteIdentifiers <String[]> [-resourcePools] [<CommonParameters>]
```

### networks
```
Get-VirtualizationSites -siteIdentifiers <String[]> [-networks] [<CommonParameters>]
```

### hosts
```
Get-VirtualizationSites -siteIdentifiers <String[]> [-hostIdentifier <String>] [-hosts] [<CommonParameters>]
```

### hostClusters
```
Get-VirtualizationSites -siteIdentifiers <String[]> [-hostClusters] [<CommonParameters>]
```

### datastores
```
Get-VirtualizationSites -siteIdentifiers <String[]> [-datastores] [<CommonParameters>]
```

### datastoreClusters
```
Get-VirtualizationSites -siteIdentifiers <String[]> [-datastoreClusters] [<CommonParameters>]
```

### siteIdentifier
```
Get-VirtualizationSites -siteIdentifiers <String[]> [<CommonParameters>]
```

### folders
```
Get-VirtualizationSites -siteIdentifier <String> [-folders] [<CommonParameters>]
```

### devices
```
Get-VirtualizationSites -siteIdentifier <String> [-devices] [-hostIdentifier <String>] [<CommonParameters>]
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
{{Fill datastoreClusters Description}}

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
{{Fill datastores Description}}

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
{{Fill devices Description}}

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
{{Fill folders Description}}

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
{{Fill hostClusters Description}}

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
{{Fill hostIdentifier Description}}

```yaml
Type: String
Parameter Sets: hosts, devices
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hosts
{{Fill hosts Description}}

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
{{Fill networks Description}}

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
{{Fill resourcePools Description}}

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
{{Fill siteIdentifier Description}}

```yaml
Type: String
Parameter Sets: folders, devices
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIdentifiers
{{Fill siteIdentifiers Description}}

```yaml
Type: String[]
Parameter Sets: vms, resourcePools, networks, hosts, hostClusters, datastores, datastoreClusters, siteIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vms
{{Fill vms Description}}

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
