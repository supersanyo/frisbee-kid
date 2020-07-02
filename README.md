# frisbee-kid
> DVD Rip Script to MP4/MP3 for Windows and MacOS

## Demo / Usage
### Windows
![Windows Demo](http://g.recordit.co/qcszdoyvMJ.gif)

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

#### Online vs Local Database
If the JSON for the DVD is already available [here](https://github.com/supersanyo/frisbee-kid/tree/master/dvd), use the online database. If not, use local database and refer to [JSON File Format](#json-file-format) section to create your own JSON file.

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

#### Online vs Local Database
If the JSON for the DVD is already available [here](https://github.com/supersanyo/frisbee-kid/tree/master/dvd), use the online database. If not, use local database and refer to [JSON File Format](#json-file-format) section to create your own JSON file.

## JSON File Format
The intent of the JSON file is to assist the DVD ripper so that the script knows that `title`, `chapter` to parse and the name to save it to. Once the JSON for the dvd file is prepared, put it in `dvd` folder.

### Example JSON File
```
{
	"2": {                                          // "2" indicates the title number in the DVD
		"name": "巧虎快樂版-2020-01",            // "name" is the folder where the MP4/3s will be dumped to
		"chapters": [                           // List of chapters in the the title "2" in order
			"唱唱跳跳 恭喜恭喜",              // Chapter 1
			"歡樂故事屋 雨天同樂會",          // Chapter2
			"自然大驚奇 青蛙大觀察",
			"特別企劃 一起來玩跳跳青蛙",
			"團體生活好好玩 專心聽老師說話",
			"動手玩一玩(1) 邏輯創意巧拼組",
			"我會保護自己 小心燙傷",
			"動手玩一玩(2) 邏輯創意巧拼組",
			"生活加油特輯 保護眼睛加油",
			"智育動動腦 數字與數量對應",
			"教材預告"                          // Chapter 11
		]
	}
}
```

### Title/Chapter Information from DVD
TODO: Add demo gif in VLC

### JSON File Synta Checker
Here are 2 online tools that can help you check if your JSON file has any syntax issue.
1. https://jsoneditoronline.org/
2. https://jsonformatter.org/json-editor

## Contributing
## FAQ
