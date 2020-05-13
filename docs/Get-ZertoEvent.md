---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZertoEvent.md
schema: 2.0.0
---

# Get-ZertoEvent

## SYNOPSIS
Returns events from the connected Zerto Virtual Manager

## SYNTAX

### main (Default)
```
Get-ZertoEvent [<CommonParameters>]
```

### filter
```
Get-ZertoEvent [-startDate <String>] [-endDate <String>] [-vpgName <String>] [-vpgIdentifier <String>]
 [-eventType <String>] [-siteName <String>] [-siteIdentifier <String>] [-zorgIdentifier <String>]
 [-entityType <String>] [-userName <String>] [-category <String>] [-eventCategory <String>]
 [-alertIdentifier <String>] [<CommonParameters>]
```

### eventId
```
Get-ZertoEvent -eventId <String[]> [<CommonParameters>]
```

### categories
```
Get-ZertoEvent [-categories] [<CommonParameters>]
```

### entities
```
Get-ZertoEvent [-entities] [<CommonParameters>]
```

### types
```
Get-ZertoEvent [-types] [<CommonParameters>]
```

## DESCRIPTION
Returns events from the connected Zerto Virtual Manager. If any of the switches are specified, it will return information about entities with that title. For example, if you select '-types' it will return all event types.

Should any of the parameters for the filter functionality be specified, only events that fulfill all of the submitted criteria will be returned.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoEvent
```

Returns all events

### Example 2
```powershell
PS C:\> Get-ZertoEvent -eventId "Need an eventID"
```

Returns information for each -eventID specified.

### Example 1
```powershell
PS C:\> Get-ZertoEvent -startDate "2019-01-01" -endDate "2019-01-07" -vpg "My Vpg"
```

Returns all events between Jan. 01, 2019 and Jan. 07, 2019 (inclusive) for the vpg "My Vpg"

## PARAMETERS

### -alertIdentifier
The internal alert identifier for the Event

```yaml
Type: String
Parameter Sets: filter
Aliases: alertId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -categories
Returns possible Event Categories.

```yaml
Type: SwitchParameter
Parameter Sets: categories
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -category
The type of event to return. This filter behaves in the same way as the eventCategory filter. Possible Values are: Possible Values are: 'All', 'Events', 'Alerts'

```yaml
Type: String
Parameter Sets: filter
Aliases:
Accepted values: All, Events, Alerts

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -endDate
The end date for the list, supplied as a date with the format of the Zerto Virtual Manager where the API runs, for example, yyyy-MM-dd.
You can also specify a local time with the following format: yyyy-MM-ddTHH:mm:ss.fffZ.
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

### -entities
Returns possible entity types.

```yaml
Type: SwitchParameter
Parameter Sets: entities
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entityType
The type of entity for which you wish to return results. Possible Values are: 'VPG', 'VRA', 'Unknown', or 'Site'

```yaml
Type: String
Parameter Sets: filter
Aliases:
Accepted values: VPG, VRA, Unknown, Site

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -eventCategory
This filter behaves in the same way as the category filter. If both category and eventCategory filters are specified, only the category filter value is used and the eventCategory filter value is ignored. The type of event to return. Possible Values are: 'All', 'Events', 'Alerts'

```yaml
Type: String
Parameter Sets: filter
Aliases:
Accepted values: All, Events, Alerts

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -eventId
The identifier or identifiers of the event for which information is returned.

```yaml
Type: String[]
Parameter Sets: eventId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -eventType
The type of event.
For the description of events, refer to the Zerto Virtual Replication documentation about alerts and events.
Please see Zerto API Documentation for possible values.

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

### -siteIdentifier
The internal site identifier for which you want to return events.

```yaml
Type: String
Parameter Sets: filter
Aliases: siteId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteName
The name of the site for which you want to return events.

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

### -startDate
The starting date for the list of events, supplied as a date with the format of the Zerto Virtual Manager where the API runs, for example, yyyy-MM-dd.
You can also specify a local time with the following format: yyyy-MM-ddTHH:mm:ss.fffZ.
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

### -types
Returns possible event types.

```yaml
Type: SwitchParameter
Parameter Sets: types
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userName
The name of the user for which the event occurred.
If the event occurred as a result of a task started by the Zerto Virtual Manager, for example, when moving a VPG before the commit stage, the user is System.

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

### -vpgIdentifier
The identifier of the VPG for which you want to return events.

```yaml
Type: String
Parameter Sets: filter
Aliases: vpgId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
The name of the VPG for which you want to return events.

```yaml
Type: String
Parameter Sets: filter
Aliases: vpg

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zorgIdentifier
The identifier of the ZORG, Zerto organization, defined in the Zerto Cloud Manager for which you want to return results.

```yaml
Type: String
Parameter Sets: filter
Aliases: zorgId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Events End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.022.html#)
