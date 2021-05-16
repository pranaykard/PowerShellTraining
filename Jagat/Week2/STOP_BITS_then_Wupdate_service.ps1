# Description:  - Stop BITS service and then automatic updates service
$bits = Get-Service -Name BITS | select -ExpandProperty Name
$bits_current_status = Get-Service -Name BITS | select -ExpandProperty Status
$wupdate = Get-Service wuauserv | select -ExpandProperty Name
$wupdate_current_status = Get-Service wuauserv | select -ExpandProperty Status

# Stopping BITS service

if ($bits_current_status -eq 'Running')
{
    Stop-Service $bits -Force
    Write-Host "BITS service successfully stopped"
}
else
{
   if ($bits_current_status -eq 'Stopped')
   {
       Write-Host "BITS service is already in stopped state"
   }
    
}

# Stopping windows update service

if ($wupdate_current_status -eq 'Running')
{
    Stop-Service $wupdate -Force
    Write-Host "windows update service successfully stopped"
}
else
{
   if ($wupdate_current_status -eq 'Stopped')
   {
       Write-Host "windows update service is already in stopped state"
   }
    
}
Write-Host "Script execution completed" -ForegroundColor Green


