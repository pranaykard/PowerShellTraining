

function GetServicesData ($ServiceName,$StartType) {

$ServiceList = Get-Service -Name $ServiceName | where {$_.StartType -like "Manual"}


    foreach ($Service in $ServiceList)

    {

        if ($StartType -eq "Automatic")

        {Write-Host "Start type is $($Service.StartType)"}

        elseif ($StartType -eq "Manual")

        {Write-Host "Start type is $($Service.StartType)"}

    }

    return $ServiceList

}

$Service = GetServicesData -ServiceName "BITS" -StartType "Automatic" # Calling the function
