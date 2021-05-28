# Create a PS file in 3 location

try{

New-Item -ItemType File -Path C:\Temp\week1 -Name powershell_test_file.ps1 -ErrorAction Stop   # use -Force to create anyway
New-Item -ItemType File -Path C:\Temp\week2 -Name powershell_test_file.ps1 -ErrorAction Stop
New-Item -ItemType File -Path C:\Temp\fakefolder -Name powershell_test_file.ps1 -ErrorAction Stop
}
catch
{
Write-Host $Error[0].Exception.Message -BackgroundColor Red
}
Finally
{
Write-Host "Script execution completed" -ForegroundColor Green
}