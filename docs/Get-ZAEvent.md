---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAEvent.md
schema: 2.0.0
---

# Get-ZAEvent

## SYNOPSIS

Retrieve details of all existing events.

## SYNTAX

```
Get-ZAEvent [[-zOrgIdentifier] <String>] [[-category] <String>] [[-limitTo] <Int32>] [[-startDate] <String>]
 [[-endDate] <String>] [<CommonParameters>]
```

## DESCRIPTION

Retrieve details of all existing events.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAEvent
```

Retrieve details of all existing events.

### Example 2
```powershell
PS C:\> Get-ZAEvent -zOrgIdentifier "1234-5678-9012"
```

Retrieve details of all existing events for zOrg with Identifier "1234-5678-9012"

### Example 3
```powershell
PS C:\> Get-ZAEvent -category events -startDate "2019-03-01" -endDate "2019-04-01" -limitTo 400
```

Retrieve details of all events between March 1st and April 1st and limit results to 400.

## PARAMETERS

### -category
The event category (events/alertsHistory).
Default displays the list of all.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -endDate
The latest timestamp of an event to return, in RFC 3339 standard ('1970-01-01T00:00:00Z').
Default is the present time.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limitTo
The maximum number of events to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -startDate
The earliest timestamp of an event to return, in RFC 3339 standard ('1970-01-01T00:00:00Z').
Default is one year ago.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zOrgIdentifier
The ZORG identifier by which to filter the user's events.
If the ZORG identifier is omitted, events is retrieved.

```yaml
Type: String
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

[Zerto Analytics REST API Endpoint for Events](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_events)
