

### Zerto Virtual Manager

* Refactored `Copy-ZertoVpg` functionality to leverage identifier and name maps and eliminate `where-object` searches.
* Updated `Get-ZertoEvent` parameter to fall in line with the filter parameter name in the API documentation. Moved the old parameter name to an alias to ensure that existing functionality continues to work.
