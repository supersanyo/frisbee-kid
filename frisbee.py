#!/usr/bin/python
import subprocess
import os
import urllib
import json

#
#  Select DVD Drive
#
batcmd="mount | grep udf | cut -d ' ' -f3"
result = subprocess.check_output(batcmd, shell=True)
mounts = result.split('\n')[:-1]
if len(mounts) <= 0:
  print("No DVD drive found")
  exit(1)
elif len(mounts) == 1:
  mount = mounts[0]
else:
  for i in range(len(mounts)):
    print("[%s] - %s" % (i, mounts[i]))
  try:
    i = input("Select DVD drive number: ")
    mount = mounts[i]
  except:
    print("Invalid input")
    exit()
print("%s is selected" % mount)

#
#  Read JSON file
#
print("[0] - Online Database")
print("[1] - Local Database")
sel = raw_input("Select DVD json source: ")
if sel == '0':
  JSON_URL="https://raw.githubusercontent.com/supersanyo/frisbee-kid/master/dvd/"
  title = raw_input("Input name from online database: ")
  url = JSON_URL+title+".json"
  
  json_url = urllib.urlopen(url)
  data = json.loads(json_url.read().decode(encoding='utf-8-sig'))
elif sel == '1':
  title = raw_input("Input json file name in dvd folder: ")
  try:
    data = json.load(open("./dvd/%s.json" % title))
  except:
    print("dvd file patth does not exist?")
    exit()
else:
  print("Invalid input")
  exit()


#
#  Run VLC
#
vlc_proc = '/Applications/VLC.app/Contents/MacOS/VLC'
vlc_common = '-I dummy --no-loop --no-repeat --play-and-exit'

for t in data.keys():
  folder = data[t]['name']
  chapters = data[t]['chapters']
  if not os.path.exists(folder):
    os.makedirs(folder)
  print("Parsing %s" % folder)
  for i in range(len(chapters)):
    c = i+1
    fname = "%s/%s.%s" % (folder, c, chapters[i])

    video_param = 'dvdsimple://%s#%s:%s-%s:%s --sout "#transcode{vcodec=h264,acodec=mp4a,vb=800,scale=1,ab=128,channels=2}:std{access=file,mux=mp4,dst=%s.mp4}"' % (mount, t, c, t, c, fname)
    audio_param = '--sout "#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100}:std{access=file,dst=%s.mp3}" "%s.mp4"' % (fname, fname)

    print ("  Generating MP4: %s" % fname)
    cmd = "%s %s %s" % (vlc_proc, vlc_common, video_param)
    subprocess.call(cmd, shell=True)

    print ("  Generating MP3: %s" % fname)
    cmd = "%s %s %s" % (vlc_proc, vlc_common, audio_param)
    subprocess.call(cmd, shell=True)
