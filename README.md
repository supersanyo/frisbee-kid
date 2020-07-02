# frisbee-kid
> DVD Rip Script to MP4/MP3 for Windows

## Demo / Usage
### Windows
![Windows Demo](https://g.recordit.co/qcszdoyvMJ.gif)

### MacOS
Enter the following in Terminal to run the script
```
python frisbee.py
```

## Getting Started
### Prerequisites
The script relies on [VLC](https://www.videolan.org/) for both DVD to MP4 and MP4 to MP3 conversion

### Windows
#### Folder Structure
The working directory should have a structure as shown below.
[fly-frisbee.ps1](https://raw.githubusercontent.com/supersanyo/frisbee-kid/master/fly-frisbee.ps1) and json files under dvd directory can be downoaded here directly.
```
frisbee-kid
│   fly-frisbee.ps1   
│
└───dvd
│   │   xxxx.json
│   │   xxxxx.json
│
│   
└───vlc
    │   vlc.exe
    │   xxxx (other file from zipped vlc file)
```

#### Download VLC
Go to [VLC website](https://www.videolan.org/vlc/download-windows.html) and download the [zipped version](https://get.videolan.org/vlc/3.0.11/win32/vlc-3.0.11-win32.zip).
Extract the contents to `vlc` folder as shown in folder structure

#### Run the scripts
Since PowerShell does not natively display UTF-8, unlike the PowerShell IDE. It is recommended to run the script from PowerShell IDE.
To do so, right click on `fly-frisbee.ps1` and select **Edit**. After PowerShell IDE pops up, follow the demo to run the script.

### Mac
#### Folder Structure
The working directory should have a structure as shown below.
[fly-frisbee.ps1](https://raw.githubusercontent.com/supersanyo/frisbee-kid/master/fly-frisbee.ps1) and json files under dvd directory can be downoaded here directly.
```
frisbee-kid
│   frisbee.py 
│
└───dvd
    │   xxxx.json
    │   xxxxx.json
```
#### Download VLC
Go to [VLC website](https://www.videolan.org/vlc/download-macosx.html) and install VLC in the `Applications` folder

#### Run the scripts
Open **Terminal** and navigate to `frisbee-kid` directory. Type `python frisbee.py` to execute the script. The rest should be the same as the demo

## Contributing
## FAQ
