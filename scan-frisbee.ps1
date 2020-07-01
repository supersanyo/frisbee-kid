# Select Disk Drive
$drives = Get-CimInstance Win32_LogicalDisk | ?{ $_.DriveType -eq 5} | select DeviceID
If ([string]::IsNullOrEmpty($drives)) {
    Write-Host "Cannot find DVD drive"
    exit
}
If ($drives.GetType().IsArray) {
    For ($i = 0; $i -lt $drives.Length; $i += 1) {
        Write-Host ('[{0}] - {1}' -f ($i, $drives[$i].DeviceId))
    }
    $i = Read-host -Prompt 'Multiple drives found. Select DVD Drive'
    if ( ($i -lt 0) -or ($i -ge $drives.Length) ) {
        Write-Host 'Invalid input'
        exit
    }
    $drive = $drives[$i].DeviceID
} else {
    $drive = $drives.DeviceID
}
Write-Host ('Drive {0} is selected' -f $drive)

.\handbrake\HandBrakeCLI.exe -i $drive -t 0 --scan  
Read-Host -Prompt 'Press Enter to exit'