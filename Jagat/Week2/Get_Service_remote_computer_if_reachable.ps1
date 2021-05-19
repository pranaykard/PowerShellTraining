# Get service details from remote computer if ping is successful

$server_name = 'ip-172-31-18-154.ec2.internal'

if (Test-Connection $server_name)
{
    Write-Host "Can ping the server" $server_name ",Getting the service status" -ForegroundColor Green
    Enter-PSSession $server_name
    hostname
    Get-Service
    exit

}
else
{
    Write-Warning "unable to ping teh server, please check!!"
}