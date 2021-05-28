# Start a service using WNi query

$server_list = Get-Content -Path C:\Temp\serverlist.txt
$cred = Get-Credential

# Check the current status
Invoke-Command -ComputerName $server_list -Credential $cred -ScriptBlock {Get-WmiObject -Query "select * from win32_service where name='BITS'" |ft -Property PSComputerName, Name, State, Status}

# Start the service
Invoke-Command -ComputerName $server_list -Credential $cred -ScriptBlock {Get-WmiObject -Query "select * from win32_service where name='BITS'" | Start-Service}

# Again check the current status

Invoke-Command -ComputerName $server_list -Credential $cred -ScriptBlock {Get-WmiObject -Query "select * from win32_service where name='BITS'" |ft -Property PSComputerName, Name, State, Status}