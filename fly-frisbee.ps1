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
$vlc = '.\vlc\vlc.exe'
$vlc_common = '-I dummy --no-loop --no-repeat --play-and-exit '
foreach ($t in $content.psobject.Properties.name) {
    $chapters = $content.$t.chapters
    $folder = $content.$t.name

    New-Item -Path . -Force -Name $folder -ItemType "directory" -ErrorAction Ignore
    For($i = 0; $i -lt $chapters.Length; $i += 1) {
        Write-Host ('Title {0}, Chapter {1}' -f $folder, $chapters[$i])

        $n = $i+1
        $name = "{0}\{1}.{2}" -f $folder, $n, $chapters[$i]


        # VLC - dvd to mp4
        Write-Host '  Generating Video File'
        $video_params = 'dvdsimple:///{0}/#{1}:{2}-{1}:{2} --sout "#transcode{{vcodec=h264,acodec=mp4a,vb=800,scale=1,ab=128,channels=2}}:std{{access=file,mux=mp4,dst={3}.mp4}}"' -f ($drive, $t, $n, $name)
        Start-Process -Wait $vlc ($vlc_common + $video_params)

        # VLC - mp4 to mp3
        Write-Host '  Generating Audio File'
        $audio_params = '--sout "#transcode{{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100}}:std{{access=file,dst={0}.mp3}}" "{0}.mp4"' -f $name
        Start-Process -Wait $vlc ($vlc_common + $audio_params)
    }
}
Read-Host -Prompt 'Press Enter to exit'