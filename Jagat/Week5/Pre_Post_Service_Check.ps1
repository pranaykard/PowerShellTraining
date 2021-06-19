$pre = Import-Csv C:\Temp\pre.csv
$post = Import-Csv C:\Temp\post.csv


$diff = Compare-Object -ReferenceObject $pre -DifferenceObject $post -Property Name,Status | Where-Object {$_.Status -eq "Stopped"}
$diff | Export-Csv C:\Temp\diff.csv -NoTypeInformation

$import_svc = Import-Csv C:\Temp\diff.csv | select -ExpandProperty Name


foreach($service in $import_svc)

{
 
        Start-Service $service
        Write-Host "$($service) was stopped after reboot, now Started" -ForegroundColor Green

     

}

#clean up
Remove-Item C:\Temp\diff.csv
Write-Host "C:\Temp\diff.csv  Deleted" -ForegroundColor Yellow





