---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Get-ZertoResourcesReport.md
schema: 2.0.0
---

# Get-ZertoResourcesReport

## SYNOPSIS
The resources report API generates information about the resources that are used by the virtual machines that are recovered to the site where the report is run. If no virtual machines are recovered to the site where the report is run, the report is empty.


## SYNTAX

### main (Default)
```
Get-ZertoResourcesReport [<CommonParameters>]
```

### filter
```
Get-ZertoResourcesReport [-startTime <String>] [-endTime <String>] [-pageNumber <String>] [-pageSize <String>]
 [-zorgName <String>] [-vmName <String>] [-vpgName <String>] [-protectedSiteName <String>]
 [-protectedClusterName <String>] [-protectedHostName <String>] [-protectedOrgVdc <String>]
 [-protectedVdcOrg <String>] [-recoverySiteName <String>] [-recoveryClusterName <String>]
 [-recoveryHostName <String>] [-recoveryOrgVdc <String>] [-recoveryVdcOrg <String>] [<CommonParameters>]
```

## DESCRIPTION
The resources report API generates information about the resources that are used by the virtual machines that are recovered to the site where the report is run. If no virtual machines are recovered to the site where the report is run, the report is empty.

This information is collected at fixed times as defined in the Resources Report section of the Site Settings window. Information for the report is saved for 90 days when the sampling period is hourly, and for one year when the sampling period is daily.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoResourcesReport -vpgName "MyVpg"
```

Returns resources report for VPG "MyVpg"

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
The page number to retrieve.
Minimum value is 1

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

### -protectedClusterName
The name of the cluster containing the host where the virtual machine in the recovery site resides.

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

### -protectedHostName
The address or DNS name of the host where the virtual machine in the recovery site resides.

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

### -protectedOrgVdc
The name of the vDC organization in the protected site.

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

### -protectedSiteName
The name of the protected site.

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

### -protectedVdcOrg
The name of the vCD organization in the protected site.

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

### -recoveryClusterName
The name of the cluster containing the host where the virtual machine in the recovery site resides.

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

### -recoveryHostName
The address or DNS name of the host where the virtual machine in the recovery site resides.

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

### -recoveryOrgVdc
The name of the vDC organization in the recovery site.

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

### -recoverySiteName
The name of the recovery site.

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

### -recoveryVdcOrg
The name of the recovery vCD organization.

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

### -vmName
The name of the virtual machine.

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

### -zorgName
The name of the organization set up in the Zerto Cloud Manager.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Zerto REST API Resources Report End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.058.html#)
