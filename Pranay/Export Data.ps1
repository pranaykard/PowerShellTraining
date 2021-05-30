
$ServerList = Get-Content C:\Temp\Servers.txt

$result = foreach ($Server in $ServerList)

{
try {

$serviceObj = Get-Service -ComputerName $Server -ErrorAction Stop  | Select @{name='ServiceName';e={$_.Name}},@{name='ServerName';e={$server}},@{name='Status';e={'Online'}} 
Write-Output $serviceObj 
}

catch 


{

 $serviceObj = [PSCustomObject]@{    
    ServiceName = 'NA'
    ServerName = $Server
    Status = 'Offline'
  }
}

Write-Output $serviceObj 

}  

$result | Export-Csv C:\Temp\TestResult.csv -NoTypeInformation