---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZertoRecoveryReport.md
schema: 2.0.0
---

# Get-ZertoRecoveryReport

## SYNOPSIS
Generate a recovery report and view information about recovery operations, such as failover, failover tests and moves.

## SYNTAX

### main (Default)
```
Get-ZertoRecoveryReport [<CommonParameters>]
```

### filter
```
Get-ZertoRecoveryReport [-startTime <String>] [-endTime <String>] [-pageNumber <String>] [-pageSize <String>]
 [-vpgIdentifier <String>] [-vpgName <String>] [-recoveryType <String>] [-state <String>] [<CommonParameters>]
```

## DESCRIPTION
Generate a recovery report and view information about recovery operations, such as failover, failover tests and moves.
The report displays information by VPG, and then by virtual machine within the VPG.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoRecoveryReport
```

Returns all recovery reports

### Example 1
```powershell
PS C:\> Get-ZertoRecoveryReport -vpgName "My VPG"
```

Returns all recovery reports for VPG "My VPG"

## PARAMETERS

### -endTime
Operations performed between the specified start Time and end Time (inclusive) are displayed.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageNumber
The page number the user wants to retrieve.
Minimum value is 1.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
The number of reports to display in a single page.
The maximum number of reports per page is 1000.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoveryType
The type of recovery operations.
Possible values are: 'Failover', 'Failover Test', or 'Move'

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -startTime
Operations performed between the specified start Time and end Time (inclusive) are displayed.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -state
Whether the recovery operation has completed.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
The name of the VPG.
You can specify more than one VPG, separated by commas.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Recovery Report End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.055.html#)
