#Description: This script will check a service status and if stopped, it will start the service. for example BITS

#Gather all the service names
$service_name= (Get-Service).Name

# Code to check status and start if it's in stopped state
if ($service_name -eq 'BITS')
{
    $BITS_Status = Get-Service -Name BITS | select -ExpandProperty Status
    Write-Host "Current status of BITS service is : " $BITS_Status -ForegroundColor Yellow
    
    
    if ($BITS_Status -eq "Running")
    {
        break
    }
    else
    {
        Write-Host "Starting the BITS Service......"
        Start-Service BITS
        $BITS_Status = Get-Service -Name BITS | select -ExpandProperty Status
        if ($BITS_Status -eq "Running")
        {
            Write-Host "BITS service successfully started.." -ForegroundColor Green
        }
        else
        {
            Write-Host "Soemthing webt wrong while starting the service. please check in GUI"
        }
        
        
    }
    
}
else
{
    Write-Host 'Check service name!'
    
}