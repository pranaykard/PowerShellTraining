$allservice= Get-Service
$count = 1

foreach ($svc in $allservice)
{
    if ($count -eq 11)
    {
        break
    }
    else
    {
     Write-Host $svc.Name
    }
    $count++
}