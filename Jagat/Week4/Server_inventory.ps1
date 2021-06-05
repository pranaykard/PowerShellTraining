#Author: Jagat Pradhan
#Description: Server Inventory

$Serverlist = Get-Content -Path C:\Temp\serverlist.txt
$credential = Get-Credential -UserName Administrator -Message "Enter the password"

$result = foreach ($server in $Serverlist)

{

            try{

             $proc = Get-WmiObject -ComputerName $server -Credential $credential Win32_Processor -Property Name,Manufacturer -ErrorAction Stop
             $bios = Get-WmiObject -ComputerName $server -Credential $credential Win32_BIOS -Property Manufacturer,SerialNumber -ErrorAction Stop
             $memory = Get-WmiObject -ComputerName $server -Credential $credential Win32_Physicalmemory -Property Capacity -ErrorAction Stop
             $ip = Get-WmiObject -ComputerName $server -Credential $credential Win32_NetworkAdapterConfiguration -Filter "Description = 'Intel(R) 82574L Gigabit Network Connection #2'" -Property Ipaddress -ErrorAction Stop
             
  
  
  
  
              $inventory = Get-WmiObject -ComputerName $server -Credential $credential Win32_Operatingsystem -Property CSName,Caption,Version -ErrorAction Stop |`
              select @{n="ServerName";e={$server}},@{n="OS";e={$_.Caption}},@{n="Version";e={$_.Version}}`
              ,@{n="proc_name";e={$proc.Name}},@{n="Proc_Manufacturer";e={$proc.Manufacturer}}`
              ,@{n="bios_manfacturer";e={$bios.Manufacturer}},@{n="SN";e={$bios.SerialNumber}}`
              ,@{n="memory";e={$memory.Capacity}}`
              ,@{n="IPAddress";e={$ip.Ipaddress[0]}}


              Write-Output $inventory

 
             }

            catch{

            $inventory = [PSCustomObject]@{

            'ServerName' = $server
            'OS' = "NA"
            'Version' = "NA"
            'proc_name' = "NA"
            'Proc_Manufacturer'="NA"
            'bios_manfacturer' = "NA"
            'SN' = "NA"
            'memory' = "NA"
            'IPAddress' = "NA"

               }

               Write-Output $inventory
}
$Error.Clear()


}
$result | Export-Csv -Path C:\Temp\inventory.csv -NoTypeInformation
Write-Host "Completed" -ForegroundColor Green



