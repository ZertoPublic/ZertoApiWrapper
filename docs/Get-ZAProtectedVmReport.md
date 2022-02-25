---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAProtectedVmReport.md
schema: 2.0.0
---

# Get-ZAProtectedVmReport

## SYNOPSIS
Creates a report of the requested protected virtual machines' volumes.

## SYNTAX

```
Get-ZAProtectedVmReport -VMIdentifier <String[]> [<CommonParameters>]
```

## DESCRIPTION
Creates a report of the requested protected virtual machines' volumes.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAProtectedVmReport -VMIdentifier '09914-12345-12341235', '81238-12532-12355332'
```

Generates a protected vm report for the virtual machines with the specified VMIdentifiers.

## PARAMETERS

### -VMIdentifier
A list of VM identifiers to include in the report.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics Protected VMs Report API Endpoint - POST](https://docs.api.zerto.com/#/Monitoring/post_v2_monitoring_protected_vms)
[Zerto Analytics Protected VMs Report API Endpoint - GET](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_protected_vms_reportId__reportId_)
