function Try-Module { 
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
function Try-VC () {   
if (Try-Module -Name "vmware.vimautomation.core"){
    $currentLoop = 1
    while ($currentLoop -le 3) {
        try 
        {
            $connection = Get-VC  -Server (Read-Host -Prompt "Enter vCenter Server name") `
            -Credential (Get-Credential -Message "Enter username and password" -ErrorAction Stop) `
            -ErrorAction Stop
            break
        }
        catch [VMware.VimAutomation.ViCore.Types.V1.ErrorHandling.InvalidLogin]
        {
            Write-Host "
            Cannot complete login due to an incorrect user name or password
            " -ForegroundColor Red 
        }
        catch [VMware.VimAutomation.Sdk.Types.V1.ErrorHandling.VimException.ViServerConnectionException]
        {
            Write-Host "
            Could not resolve the requested VC server
            " -ForegroundColor Red
        }
    $currentLoop++
}
    if(([System.Uri]$global:defaultviserver.ServiceUri.AbsoluteUri).Host){
        Write-Host "
        Current vcenter server: " ([System.Uri]$global:defaultviserver.ServiceUri.AbsoluteUri).Host
}
    else{
        Write-Host "
        Failed to login to vcenter server" -ForegroundColor Red   
    }
}
else {"Powershell module vmware.vimautomation.core is not found on the system"; break}
}