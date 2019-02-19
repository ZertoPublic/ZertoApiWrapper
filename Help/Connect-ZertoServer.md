---
external help file: ZertoFunctions-help.xml
Module Name: ZertoFunctions
online version:
schema: 2.0.0
---

# Connect-ZertoServer

## SYNOPSIS
Connects and authorizes against a Zerto Virtual Manager server.

## SYNTAX

```
Connect-ZertoServer [-zertoServer] <String> [[-zertoPort] <String>] [-credential] <PSCredential>
 [<CommonParameters>]
```

## DESCRIPTION
Connects and authorizes against a Zerto Virtual Manager server. This command will set two environmental variables to contain the authorization token along with the Zerto Server IP address, Port information, and last time the token was used. The token will expire after 30 minutes have passed since the last call.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort "9669" -credential $credential
```

Connects and authorizes against Zerto Virtual Manager server at 192.168.1.100 on port 9669 using a PSCredential object.

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

### -zertoPort
Port on which the Zerto API is listening. Default port is 9669

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
