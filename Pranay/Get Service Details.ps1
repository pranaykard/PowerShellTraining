$ServerList = Get-Content C:\Temp\Servers.txt 


$Result = foreach ($Server in $ServerList)
{
        try {
            $ComputerDetails = Get-WmiObject -ComputerName $Server -Class "Win32_OperatingSystem" -Namespace "root\cimv2"   -Property Caption
   
            $ServiceObj = Get-Service -ComputerName $Server -ErrorAction Stop `
            | Select @{Name='ServiceName';e={$_.Name}},@{Name='ServerName';e={$Server}}, `
            @{Name='Status';e={'Online'}},@{Name='Caption';e={$ComputerDetails.Caption}}

            Write-Output $ServiceObj

            }


        catch {

        $ServiceObj = [PSCustomObject]@{
            ServiceName = 'NA'
            ServerName = $Server
            Status = 'Offline'
            Caption = 'NA'

        }

           Write-Output $ServiceObj

        }

        $error.Clear()         

}

$Result | export-csv C:\Temp\ResultScript.csv -NoTypeInformation