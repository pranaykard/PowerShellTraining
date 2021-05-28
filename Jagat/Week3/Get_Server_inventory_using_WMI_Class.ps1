# Get Server OS and Service Pack
$server_list = Get-Content -Path C:\Temp\serverlist.txt
$cred = Get-Credential

try{
Invoke-Command -ComputerName $server_list -Credential $cred -ScriptBlock {Get-CimInstance -Class Win32_OperatingSystem -Property Caption,Name, CSName | fl Caption,Name, CSName} -ErrorAction Stop

}
catch{
Write-Host $error[0].Exception.Message -BackgroundColor Red
}

finally{
Write-Host "Script execution completed" -ForegroundColor Green
}