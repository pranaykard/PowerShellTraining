$head = @"

<Title> This is the sample page </title>

<style> 


th {Background-color: Blue;
    color:white
}

td {border: 1px solid black;
    color:white}

.success  {background-color:green}
.critical {background-color:red}

</style>

"@

$ServiceList = Get-Service | Select-Object Name, Status,StartType


[xml]$htmlData =  $ServiceList | ConvertTo-Html -Fragment
$htmlData.InnerXml


for ($i = 1; $i -lt $htmlData.table.tr.count  ; $i++)
{ 
    
    $Class = $htmlData.CreateAttribute("class")

    if ($htmlData.table.tr[$i].td[1] -eq "Stopped")
    {
    $Class.Value = "critical"

    $htmlData.table.tr[$i].Attributes.Append($Class) | out-null
    
    }

    elseif ($htmlData.table.tr[$i].td[1] -eq "Running")
    {
    $Class.Value = "success"

    $htmlData.table.tr[$i].Attributes.Append($Class) | out-null
    
    }
}


$body = @"
<h1> This is a monitoring page for services</h1>
$($htmlData.InnerXml)

<h1> This is the second table<   

$($htmlData.InnerXml)




"@

ConvertTo-Html  -Head $head -Body $body | out-file C:\Temp\PowerShellHtmlResult2.html