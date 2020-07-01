Remove-Item -Path log.txt -ErrorAction Ignore

<#
    Select DVD Drive Location
#>
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

<#
    Select DVD data file
#>
Write-Host "[0] - Online Database"
Write-Host "[1] - Local Database"
$sel = Read-Host -Prompt 'Select DVD json source'

If ($sel -eq 0) {
    $fin = Read-Host -Prompt 'Input name from online database'
    $request = "https://raw.githubusercontent.com/supersanyo/frisbee-kid/master/dvd/{0}.json" -f $fin
    try {
        $content = [System.Net.WebClient]::new().DownloadString($request) | ConvertFrom-Json
    } catch {
        Write-Host ("Error: Could not find {0}" -f $request)
        exit
    }
} elseif ($sel -eq 1) { 
    $fin = Read-Host -Prompt 'Input json file name in dvd folder'
    try {
        $content = Get-Content ".\dvd\$fin.json" -ErrorAction Stop | ConvertFrom-Json
    } catch {
        Write-Host "dvd file path does not exist?"
        exit
    }
} else {
    Write-Host "Invalid input"
    exit
}

<#
    Start DVD to MP4/MP3 Conversion
    
    Key Parameter:
        $content (PSObject)
#>
foreach ($t in $content.psobject.Properties.name) {
    $chapters = $content.$t.chapters
    $folder = $content.$t.name
    New-Item -Path . -Force -Name $folder -ItemType "directory" -ErrorAction Ignore
    For($i = 0; $i -lt $chapters.Length; $i += 1) {
        Write-Host ('Title {0}, Chapter {1}' -f $folder, $chapters[$i])

        $n = $i+1
        # Handbrake - dvd to mp4
        $video_file = "{0}\{1}.{2}.mp4" -f $folder, $n, $chapters[$i]
        Write-Host ('  Generating Video File - {0}' -f $video_file)
        #.\handbrake\HandBrakeCLI.exe -i $drive -t $t -c $n --preset "Fast 480p30" -o "$video_file" 2>&1 | Out-File -FilePath log.txt -Append

        # VLC - mp4 to mp3
        $mp3_file = "{0}\{1}.{2}.mp3" -f $folder, $n, $chapters[$i]
        Write-Host ('  Generating Audio File - {0}' -f $mp3_file)
        #.\vlc\vlc.exe -I dummy --no-loop --no-repeat --sout "#transcode{vcodec=none,acodec=mp3,ab=192,channels=2,samplerate=44100}:std{access=file,dst=$mp3_file}" $video_file vlc://quit
    }
}
Read-Host -Prompt 'Press Enter to exit'