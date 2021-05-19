# Start the windows update service ONLY if BITS is running, if BITS is not running then start BITS first and then start windows update service
$windows_update_service = 'wuauserv'
$bits_service = 'BITS'
$bits_service_status = (Get-Service $bits_service).Status

if ($bits_service_status -eq "Running")
    {
      Start-Service $windows_update_service
      Write-Host "Windows Update service started" -ForegroundColor Green
    }

elseif ($bits_service_status -ne "Running")
    {
    Start-Service BITS
    Write-Host "BITS service started, Now starting windows update service..." -ForegroundColor Yellow
    Start-Service $windows_update_service
    Write-Host "Windows Update service started" -ForegroundColor Green

    # Current status
    Write-Host " "
    Write-Host "Current status of both service"
    Get-Service $bits_service
    Get-Service $windows_update_service
   
    
    }

else
    {
     Write-Warning "++++   Something went wrong ++++"
    }