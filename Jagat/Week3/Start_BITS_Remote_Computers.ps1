# Start BITS Service on remote computers

$cred = Get-Credential
$server_list = Get-Content -Path C:\Temp\serverlist.txt
Invoke-Command -ComputerName $server_list -Credential $cred -ScriptBlock {Start-Service -Name BITS}
Invoke-Command -ComputerName $server_list -Credential $cred -ScriptBlock {Get-Service -Name BITS} | Select PSComputerName,Name,Status