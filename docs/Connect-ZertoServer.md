---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Connect-ZertoServer.md
schema: 2.0.0
---

# Connect-ZertoServer

## SYNOPSIS
Establishes a connection to a ZVM.

## SYNTAX

```
Connect-ZertoServer [-zertoServer] <String> [[-zertoPort] <String>] [-credential] <PSCredential>
 [-returnHeaders] [-AutoReconnect] [<CommonParameters>]
```

## DESCRIPTION
Establishes a connection to a ZVM using credentials provided via a PSCredential Object leveraging the Zerto Session API end point.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort "9669" -credential $credential
```

Establishes a connection to ZVM 192.168.1.100 on port 9669 with supplied PSCredential object.

### Example 2
```powershell
PS C:\> Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort "9669" -credential $credential -AutoReconnect
```

Establishes a connection to ZVM 192.168.1.100 on port 9669 with supplied PSCredential object. Adding the `-AutoReconnect` switch
will cache the PSCredential object should the session need to be reauthorized due to an expired token.

## PARAMETERS

### -AutoReconnect
Use this switch to indicate that you would like the module to take care of auto re-authorization and reconnection to the ZVM should the token expire. This option will cache your PSCredential object to be reused

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
Aliases: port

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
Aliases: server, zvm

Required: True
Position: 0
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

[Zerto REST API Session End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.068.html%23)

[PSCredential Documentation](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential?view=pscore-6.0.0)

[Get-Credential Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-credential?view=powershell-6)
