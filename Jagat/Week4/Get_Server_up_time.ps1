$Serverlist = Get-Content -Path C:\Temp\serverlist.txt
$credential = Get-Credential -UserName Administrator -Message "Enter the password"

foreach ($server in $Serverlist)

{

    Try {
                $OS_class = Get-WmiObject Win32_OperatingSystem -ComputerName $server -Credential $credential -ErrorAction Stop
                $Uptime = (Get-Date) - $OS_class.ConvertToDateTime($OS_class.LastBootUpTime)
                $server_uptime_result = [PSCustomObject]@{
                    ComputerName  = $server
                    LastBoot      = $OS_class.ConvertToDateTime($OS_class.LastBootUpTime)
                    Uptime        = ([String]$Uptime.Days + " Days " + $Uptime.Hours + " Hours " + $Uptime.Minutes + " Minutes") -join " "
                }

                Write-Output $server_uptime_result
 
            } catch {
               $server_uptime_result = [PSCustomObject]@{
                    ComputerName  = $server
                    LastBoot      = "Server not reachable"
                    Uptime        = $_.Exception.Message.Split('.')[0]
                }

               Write-Output $server_uptime_result

        }

        $Error.Clear()
        $server_uptime_result | Export-Csv -Path C:\Temp\uptimereport.csv -Append -NoTypeInformation

}



