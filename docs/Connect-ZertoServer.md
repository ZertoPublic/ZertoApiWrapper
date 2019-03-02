---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Connect-ZertoServer

## SYNOPSIS
Establishes a connection to a ZVM.

## SYNTAX

```
Connect-ZertoServer [-zertoServer] <String> [[-zertoPort] <String>] [-credential] <PSCredential>
 [-returnHeaders] [<CommonParameters>]
```

## DESCRIPTION
Establishes a connection to a ZVM using credentials provided via a PSCredential Object.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort "9669" -credential $credential
```

Establishes a connection to ZVM 192.168.1.100 on port 9669 with supplied PSCredential object.

## PARAMETERS

### -credential
Valid credentials to connect to the Zerto Management Server

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -returnHeaders
Use this switch to return the headers to a specified variable or to the default output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zertoPort
Zerto Virtual Manager management port.
Default value is 9669.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: "9669"
Accept pipeline input: False
Accept wildcard characters: False
```

### -zertoServer
IP address or FQDN of your Zerto Management Server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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
[Zerto Session API Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.068.html%23)
