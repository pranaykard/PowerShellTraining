$ServerList = Get-Content C:\Temp\Servers.txt 
$Result = foreach ($Server in $ServerList)
{
        try {
            $Win32ComputerSystemDetails = Get-WmiObject -ComputerName $Server -Class "Win32_ComputerSystem" -Namespace "root\cimv2" `
             -ErrorAction Stop  -Property Model,NumberOfProcessors `
            $Win32ComputerNetworkDetails = Get-WmiObject -ComputerName $Server -query "Select IPAddress from Win32_NetworkAdapterConfiguration where Description like '%wire%'" `
              -Namespace "root\cimv2" -ErrorAction Stop | Select Ipaddress -ExpandProperty IPAddress
   
            $InventoryObj = Get-WmiObject -ComputerName $Server -Class "Win32_OperatingSystem" -Namespace "root\cimv2" -ErrorAction Stop `
            | Select @{name='Server Name';e={$Server}},@{name='version';e={$_.Version}},@{name='Caption';e={$_.Caption}},@{name='Status';`
            e={'Online'}},@{name='OSArchitecture';e={$_.OSArchitecture}}`
            , @{name='Model';e={$Win32ComputerSystemDetails.Model}},@{name='NumberOfProcessors';e={$Win32ComputerSystemDetails.NumberOfProcessors}}`
            ,@{name='IPAddress';e={$Win32ComputerNetworkDetails[0]}}

            Write-Output $InventoryObj

            }

        catch {

        $InventoryObj = [PSCustomObject]@{
            'Server Name' = $Server
            'Version' = 'NA'
            'Caption' = 'NA'
            'Status' = 'Offline'
            'OSArchitecture' = 'NA'
            'Model' = 'NA'
            'NumberOfProcessors' = 'NA'
            'IPADDRess' = 'NA'

        }
           Write-Output  $InventoryObj
        }

        $error.Clear()         

}

$Result | export-csv C:\Temp\ResultScript.csv -NoTypeInformation