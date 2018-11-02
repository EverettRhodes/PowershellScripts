#Originally taken from https://stackoverflow.com/a/36636135/4067411

$path = ".\"
$destination = ".\FileSizesByTypeResults.txt"

$results = Get-ChildItem .\* -Recurse | Where-Object {$_.extension -in ".cs",".cshtml",".ts",".sql",".config"}  | 
    Select-Object Name, Extension, @{Name="Kbytes";Expression={ "{0:N2}" -f ($_.Length / 1KB) }}
$results | Sort-Object -Property extension | Out-File $destination
$results|Group-Object extension|
    Select-Object Count,Name,@{l='Total KB';e={$_.Group | Measure-Object -Property Kbytes -Sum | Select-Object -expand sum }}| 
    Out-File $destination -Append
