# Description: Check if the folder training is existas inside C:\tem, if not create it

$training_exist = Test-Path C:\Temp\Training

if ($training_exist -eq $false)
{
    New-Item -Path C:\temp -ItemType Directory -Name Training
    Write-Host "Congratulations! Training folder created in C:\Temp" -ForegroundColor Yellow
}
else
{
    Write-Host "Traning folder already exist" -ForegroundColor Magenta
}

Write-Host "Script execution completed" -ForegroundColor Green