$domainObj = [System.DirectoryServices.ActiveDirecory.Domain]::GetCurrentDomain()

$PDC = ($domainObj.PdcRoleOwner).Name

$SearchString = "LDAP://"

$SearchString = $PDC + "/"

$DistinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))"

$SearchString += $DistinguishedName

$SearchString

$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)

$objDomain = New-Object System.DirectoryServices.DirectoryEntry

$Searcher.SearchRoot = $objDomain

$Searcher.filter="samAccountType=805306368"  #here you can search with atribute name like "name=nested_group" etc 

Result = $Searcher.FindAll()

Foreach($obj in $Result)
{
	Foreach($prop in $obj.Properties)
	{
		$prop
	}

	Write-Host "----------------------"
}
