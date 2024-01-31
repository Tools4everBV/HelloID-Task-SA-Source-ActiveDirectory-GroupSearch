# HelloID-Task-SA-Source-ActiveDirectory-AccountSearch

## Prerequisites

- [ ] The HelloID SA on-premises agent installed
- [ ] The ActiveDirectory module is installed on the server where the HelloID SA on-premises agent is running.
- [ ] User-defined variable `ADgroupsSearchOU` created in your HelloID portal. Containing a Json string array of Active Directory OU's to search in.

Example value 
```json
[{ "OU": "OU=Groups,DC=helloid,DC=local"}]
```

## Description

This code snippet executes the following tasks:

1. Imports the ActiveDirectory module.
2. Define a wildcard search query `$searchQuery` based on the search parameter `$datasource.searchValue`
3. Loop through the list of AD search OU's defined in the User-defined variable `ADgroupsSearchOU` and retrieve the AD groups using the `Get-ADGroup` cmdlet.

> The filter property **-filter** accepts different values [See the Microsoft Docs page](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adgroup?view=windowsserver2022-ps)

4. Return a hash table for each group using the `Write-Output` cmdlet.

> To view an example of the data source output, please refer to the JSON code pasted below.

```json
{
    "searchValue": "Application"
}
```