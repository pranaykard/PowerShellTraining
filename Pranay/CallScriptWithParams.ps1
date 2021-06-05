
param(

[string]$Server,
[string]$ServiceName,
[string]$action

)




if ($action -eq "Services")

{Get-Service -Name $ServiceName -ComputerName $Server}

elseif  ($action -eq "wmi") {

Get-WmiObject -Class "Win32_service" -Namespace "root\cimv2" -ComputerName $Server

}

else 

{


Write-Host "No action selection selected"
}



