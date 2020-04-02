---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerSite.md
schema: 2.0.0
---

# Get-ZAPlannerSite

## SYNOPSIS
Retrieve all active Planner sites for a specific account - includes ID, Name and Type or retrieves datacenter, host, and VMs for a specific site.

## SYNTAX

```
Get-ZAPlannerSite [[-siteIdentifier] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve all active Planner sites for a specific account - includes ID, Name and Type or retrieves datacenter, host, and VMs for a specific site.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAPlannerSite
```

Retrieve all active Planner sites for a specific account

### Example 2
```powershell
PS C:\> Get-ZAPlannerSite -siteIdentifier '0123-45676-09876'
```

Retrieves datacenter, host, and VMs for site with Identifier '0123-45676-09876'.

## PARAMETERS

### -siteIdentifier
The site identifier(s) for which to return detailed information.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics Sites Planner Endpoint](https://docs.api.zerto.com/#/Planner/get_v2_planner_sites)
[Zerto Analytics Single Site Planner Endpoint](https://docs.api.zerto.com/#/Planner/get_v2_planner_sites__siteIdentifier_)
