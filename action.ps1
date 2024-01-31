try {
    $searchValue = $datasource.searchValue
    $searchQuery = "*$searchValue*"
    $searchOUs = $ADgroupsSearchOU
    
    if(-not [String]::IsNullOrEmpty($searchValue)) {
        Write-information "SearchQuery: $searchQuery"
        Write-information "SearchBase: $searchOUs"
        
        $ous = $searchOUs | ConvertFrom-Json    
        $groups = foreach($item in $ous) {
            $params = @{
                Filter      = { Name -like $searchQuery };
                SearchBase  = $item.ou;
                Properties  = 'name', 'description';
            }

             Get-ADGroup @params
        }
        
        $groups = $groups | Sort-Object -Property Name
        $resultCount = @($groups).Count
        Write-information "Result count: $resultCount"
    	
        if(@($groups).Count -gt 0) {
            foreach($group in $groups)
            {
                $returnObject = @{
                    name            = $group.name;
                    description     = $group.description;
                }

                Write-output $returnObject
            }
        } else {
            return
        }
    }
} catch {
    Write-error "Error searching AD user [$searchValue]. Error: $($_.Exception.Message)"
    return
}