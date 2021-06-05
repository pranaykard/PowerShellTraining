$Serverlist = Get-Content -Path C:\Temp\serverlist.txt
$credential = Get-Credential -UserName Administrator -Message "Enter the password"

foreach ($server in $Serverlist)

{
   Try{
        
        $result = Get-WmiObject -Credential $credential -ComputerName $server win32_logicaldisk -Filter "DeviceID='C:'" -Property DeviceID,Size,FreeSpace  -ErrorAction Stop| Select @{n='ServerName';e={$server}},@{n='Drive Name';e={$_.DeviceID}},@{n='Total Size(GB)';e={[math]::Round($_.Size /1GB, 2)}},@{n='FreeSpace(GB)';e={[math]::Round($_.FreeSpace/1GB, 2)}}
        Write-Output $result
      
      
      }

     catch{
     
     $result = [PSCustomObject]@{
          'ServerName' = $server
          'Drive Name' = $_.Exception.Message.split('.')[0]
          'Total Size(GB)' = $_.Exception.Message.split('.')[0]
          'FreeSpace(GB)' = $_.Exception.Message.split('.')[0]
     
                      }
        
        Write-Output $result
        

            }
                    
     $result | Export-Csv -Path C:\Temp\C_Drive_Details.csv -Append -NoTypeInformation
}



