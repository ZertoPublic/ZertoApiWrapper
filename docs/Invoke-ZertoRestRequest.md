---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Invoke-ZertoRestRequest.md
schema: 2.0.0
---

# Invoke-ZertoRestRequest

## SYNOPSIS
Function used to submit a REST request to the Zerto Virtual Manager. Should be used when attempting to submit a request inside a ZertoApiWrapper function or if attempting to perform an operation not currently covered in a ZertoApiWrapper function.

## SYNTAX

```
Invoke-ZertoRestRequest [[-method] <String>] [-uri] <String> [[-body] <String>] [[-credential] <PSCredential>]
 [-returnHeaders] [<CommonParameters>]
```

## DESCRIPTION
Function used to submit a REST request to the Zerto Virtual Manager. Should be used when attempting to submit a request inside a ZertoApiWrapper function or if attempting to perform an operation not currently covered in a ZertoApiWrapper function. To function properly, you will have to have completed a connection to a Zerto Virtual Manager with the `Connect-ZertoServer` function.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-ZertoRestRequest -uri 'apiEndpoint/subApiEndpoint' -Method POST -Body $Body
```

Submits a POST request to the connected Zerto Virtual Manager api endpoint 'apiEndpoint/subApiEndpoint' with a Body parameter. Check the API documentation for the endpoint to ensure the URI is formatted correctly and the format of the Body variable. The command above assumes that the $Body variable is a string properly formatted for JSON

### Example 2
```powershell
PS C:\> Invoke-ZertoRestRequest -uri 'apiEndpoint/subApiEndpoint' -Method POST -Body ($Body | ConvertTo-Json)
```

Submits a POST request to the connected Zerto Virtual Manager api endpoint 'apiEndpoint/subApiEndpoint' with a Body parameter. Check the API documentation for the endpoint to ensure the URI is formatted correctly and the format of the Body variable. The command above assumes that the $Body variable is an object that can be formatted into JSON.

### Example 3
```powershell
PS C:\> Invoke-ZertoRestRequest -uri 'apiEndpoint/subApiEndpoint' -Method PUT -Body $Body
```

Submits a PUT request to the connected Zerto Virtual Manager api endpoint 'apiEndpoint/subApiEndpoint' with a Body parameter. Check the API documentation for the endpoint to ensure the URI is formatted correctly and the format of the Body variable. The command above assumes that the $Body variable is a string properly formatted for JSON

### Example 4
```powershell
PS C:\> Invoke-ZertoRestRequest -uri 'apiEndpoint/subApiEndpoint' -Method DELETE
```

Submits a DELETE request to the connected Zerto Virtual Manager api endpoint 'apiEndpoint/subApiEndpoint'. Check the API documentation for the endpoint to ensure the URI is formatted correctly. Typically a DELETE request does not require a BODY parameter.

### Example 5
```powershell
PS C:\> Invoke-ZertoRestRequest -uri 'apiEndpoint/subApiEndpoint' -Method GET
```

Submits a GET request to the connected Zerto Virtual Manager api endpoint 'apiEndpoint/subApiEndpoint'. Check the API documentation for the endpoint to ensure the URI is formatted correctly. Typically a GET request does not require a BODY parameter.

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

### -credential
PSCredential object.
This is ONLY used when authenticating with the ZVM.
No other endpoints require this and generally is not used.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -method
Parameter help description

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: GET
Accept pipeline input: False
Accept wildcard characters: False
```

### -returnHeaders
Use this switch if you would like the request headers returned along with the body.
Useful for troubleshooting to get HTTP error codes.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -uri
URI endpoint to be utilized.
When submitting the URI, only the endpoint needs to be submitted.
Please review the help documentation for examples.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[Zerto Virtual Replication API Endpoint Documentation](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20(ZVM)%20-%20vSphere%20Online%20Help/content/intro/book_in_portal_-_zvr_restful_apis.htm)
