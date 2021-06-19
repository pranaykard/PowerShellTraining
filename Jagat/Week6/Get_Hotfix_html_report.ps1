Clear-Host
$css = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    }

    
    h2 {

        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;

    }

    
    
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }
    


    #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }



</style>
"@

#The command below will get the name of the computer
$ComputerName = "<h1>Computer name: $env:computername</h1>"

$hotfix = Get-HotFix | Sort-Object -Descending | Select-Object csname, hotfixid, Caption, InstalledOn, InstalledBy | ConvertTo-Html -PreContent "<h1>Hotfix Report</h1>"

ConvertTo-Html -Title "Hotfix" -Body "$ComputerName,$hotfix"  -Head $css -PostContent "<p id='CreationDate'>Creation Date: $(Get-Date)</p>" | Out-File C:\Temp\hotfix.html