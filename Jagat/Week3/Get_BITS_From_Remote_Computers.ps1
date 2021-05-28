# Get the BITS status from remote computers
$Cred = Get-Credential
$server_list = Get-Content -Path C:\Temp\serverlist.txt
Invoke-Command -ComputerName $server_list -Credential $Cred -ScriptBlock {Get-Service | Where-Object {$_.Name -eq "BITS"}} | Select-Object Name,Status,PSComputerName