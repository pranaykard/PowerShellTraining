$allservice= Get-Service

for ($i = 1; $i -lt 10; $i++)
{ 
    $service = $allservice[$i]
    write-host $service.Name    $service.Status -Separator "   -   "
    
    }

