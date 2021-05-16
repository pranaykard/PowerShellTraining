$allservice= Get-Service
$x = 0

do
{
    $service = $allservice[$x]
    Write-Host $service.Name
    $x++
}
while ($x -lt 10)