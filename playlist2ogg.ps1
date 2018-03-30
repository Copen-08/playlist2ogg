#Playlist2ogg was written by Copen-08.
#02/02/2018
#version 1.5
#This script requires a CSV named config.cfg to run.
#This script requires ffmpeg, and youtube-dl to tun.

#checks for the proper directories in the config file.
$config = import-csv config.cfg
#print out the config file so the user can make sure everything is as should be.
Write-Host $config

#Get the playlist url and run youtube-dl with it. Toss all the videos in the VIDEO folder.
$playlist = Read-Host -Prompt 'Please input the playlist url'
$playlistName = Read-Host -Prompt 'Please input the playlist name desired'

#Get playlist name dir.
$ipath = $config.resultDir +'VIDEO\' + $playlistName + '\'
$opath = $config.resultDir +'AUDIO\' + $playlistName + '\'
$litInputPath = $ipath -replace "\\", "/"

#create the directories for VIDEO and AUDIO
New-Item -ItemType Directory -Force -Path $ipath
New-Item -ItemType Directory -Force -Path $opath

#Added -i to arguments passed to youtube-dl so a messed up video doesn't kill your entire playlist download.
$dlargs = '--yes-playlist --format best -i -o "'+ $litInputPath + '%(title)s.%(ext)s" ' + $playlist
$path = $config.exeDir +'youtube-dl.exe'
Start-Process -FilePath $path -ArgumentList $dlargs -Wait -NoNewWindow

#Get playlist name from user.
$files = Get-ChildItem -Path $litInputPath

#Loop through downloaded videos, and convert them to .ogg files.
for ($i=0; $i -lt $files.Count; $i++) {
	Write-Host $files[$i]
	Write-Host $files[$i].FullName
	
	
	$fileName = $files[$i].FullName
	$audioName = $fileName -replace $files[$i].Extension, ".ogg"
	$audioName = $audioName -replace "VIDEO", "AUDIO"
	
	#If you forget the -vn argument here you'll just end up with another video file.
	$args = '-i "' + $fileName + '" -vn -acodec libvorbis "' + $audioName +'"'
	Write-Host $args
	$ffpath = '"' + $config.exeDir +'ffmpeg.exe"'
	Start-Process -FilePath $ffpath -ArgumentList $args -Wait -NoNewWindow
}
