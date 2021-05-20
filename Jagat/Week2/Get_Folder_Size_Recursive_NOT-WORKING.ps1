$all_folder_name  = Get-ChildItem -Path C:\Temp

foreach($folder in $all_folder_name)
{
  $all_sub_folders = Get-ChildItem $folder.FullName -Recurse | Measure-Object -Sum Length

   foreach($sub_folder in $all_sub_folders)

       {
          $all_sub_folder_after_math = if($sub_folder.Sum -ge 1000000000) {"{0:N2}" -f ($sub_folder.Sum /  1GB) + 'GB'}
          elseif(($sub_folder.Sum -ge 10000000) -and ($sub_folder -le 1000000000 )) {"{0:N2}" -f ($sub_folder.Sum / 1MB) + 'MB'}
          elseif($sub_folder.Sum -le 10000000 ) {"{0:N2}" -f ($sub_folder.Sum / 1KB) + 'KB'}
       
       }

       $custom_property = New-Object -TypeName PSObject -Property @{
       
       "Folder_Name" = $sub_folder.Name
       "Full_Path" = $sub_folder.FullName   
       "Size" = $all_sub_folder_after_math
       
       } $custom_property | select Folder_Name,Full_Path,Size
        

}