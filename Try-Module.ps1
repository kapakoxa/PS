Function Try-Module 
{ 
Param([string]$Name) 
if(-not(Get-Module -name $name)) 
{ 
    if(Get-Module -ListAvailable | Where-Object { $_.name -eq $name }) 
    { 
        Import-Module -Name $name 
        $true 
    } 
    else { $false } 
    }  
else { $true } 
    } 
