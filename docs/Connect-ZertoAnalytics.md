---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Connect-ZertoAnalytics.md
schema: 2.0.0
---

# Connect-ZertoAnalytics

## SYNOPSIS
All requests to the server, apart from the request to authenticate, must contain a security token which is provided on successful authentication.
In order to authenticate, the user sends myZerto credentials (user/password).

## SYNTAX

```
Connect-ZertoAnalytics [-credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
All requests to the server, apart from the request to authenticate, must contain a security token which is provided on successful authentication.
In order to authenticate, the user sends myZerto credentials (user/password). Once this call has been completed successfully, the header authentication token will be stored as a variable and automatically passed during future calls to the Zerto Analytics platform. This token will automatically expire after 60 minutes of inactivity and need to be reauthorized by calling this function again.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-ZertoAnalytics -credential $myCredential
```

Connects to the Zerto Analytics site and gets a Bearer Authorization token that is automatically stored as a variable for future calls to the Zerto Analytics REST API. This token will automatically expire after 60 minutes of inactivity and need to be reauthorized by calling this function again.

## PARAMETERS

### -credential
PSCredential Object containing username and password authorized for the Zerto Analytics site

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

[Zerto Analytics REST API Endpoint for Authentication](https://docs.api.zerto.com/#/Authentication/post_v2_auth_token)
