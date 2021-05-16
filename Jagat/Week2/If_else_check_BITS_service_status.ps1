$service_name= (Get-Service).Name


if ($service_name -eq 'BITS')
{
   $BITS_Status = Get-Service -Name BITS | select -ExpandProperty Status
   Write-Host "BITS service is: " $BITS_Status -ForegroundColor Yellow
}
else
{
    Write-Host 'Check service name!'
}