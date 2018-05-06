Function Try-Module 
{ 
Param([string]$ModuleName) 
if(-not(Get-Module -Name $ModuleName)) 
{ 
    if(Get-Module -ListAvailable | Where-Object { $_.name -eq $ModuleName }) 
    { 
        Import-Module -Name $ModuleName 
        $true 
    } 
    else { $false } 
    }  
else { $true } 
    } 
