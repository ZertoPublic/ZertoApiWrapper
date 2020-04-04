---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Invoke-ZARestRequest.md
schema: 2.0.0
---

# Invoke-ZARestRequest

## SYNOPSIS
Function used to submit a REST request to the Zerto Analytics Portal. Should be used when attempting to submit a request inside a ZertoApiWrapper function or if attempting to perform an operation not currently covered in a ZertoApiWrapper function.

## SYNTAX

```
Invoke-ZARestRequest [-uri] <String> [[-method] <String>] [[-body] <String>] [<CommonParameters>]
```

## DESCRIPTION
Function used to submit a REST request to the Zerto Analytics Portal. Should be used when attempting to submit a request inside a ZertoApiWrapper function or if attempting to perform an operation not currently covered in a ZertoApiWrapper function. To function properly, you will have to have completed a connection to a Zerto Virtual Manager with the `Connect-ZertoAnalytics` function.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-ZertoRestRequest -uri 'apiEndpoint/subApiEndpoint' -Method GET
```

Submits a GET request to the connected Zerto Virtual Manager api endpoint 'apiEndpoint/subApiEndpoint'. Check the API documentation for the endpoint to ensure the URI is formatted correctly. Typically a GET request does not require a BODY parameter.

### Example 1
```powershell
PS C:\> Invoke-ZertoRestRequest -uri 'apiEndpoint/subApiEndpoint' -Method POST -Body $Body
```

Submits a PUT request to the connected Zerto Virtual Manager api endpoint 'apiEndpoint/subApiEndpoint' with a Body parameter. Check the API documentation for the endpoint to ensure the URI is formatted correctly and the format of the Body variable. The command above assumes that the $Body variable is an object that can be formatted into JSON.

## PARAMETERS

### -body
Body to be submitted to the REST API endpoint.
This needs to be submitted in JSON format

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -method
API method to be used.
GET, PUT, POST, or DELETE.
Refer to documentation for the API endpoint to ensure the correct method is being used.
If unspecified, defaults to GET

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: GET
Accept pipeline input: False
Accept wildcard characters: False
```

### -uri
Parameter help description

```yaml
Type: String
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

[Zerto Analytics API Endpoint Documentation](https://docs.api.zerto.com/)
