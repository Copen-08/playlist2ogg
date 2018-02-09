#Playlist2ogg was written by Copen-08.
#02/02/2018
#version 1.3
#This script requires a CSV named config.cfg to run.
#This script requires ffmpeg, and youtube-dl to tun.

#checks for the proper directories in the config file.
$config = import-csv config.cfg
#print out the config file so the user can make sure everything is as should be.
Write-Host $config

#Get the playlist url and run youtube-dl with it. Tsos all the videos in the VIDEO folder.
$playlist = Read-Host -Prompt 'Please input the playlist url'
#Added -i to arguments passed to youtube-dl so a messed up video doesn't kill your entire playlist download.
$dlargs = '--yes-playlist --format best -i -o "'+ $config.downloadDir +'VIDEO/%(playlist)s/%(title)s.%(ext)s" ' + $playlist
$path = $config.exeDir +'youtube-dl.exe'
Start-Process -FilePath $path -ArgumentList $dlargs -Wait -NoNewWindow

#Get playlist name from user.
$files = Get-ChildItem -LiteralPath $(Read-Host -Prompt 'Please input the download directory')

#Loop through downloaded videos, and convert them to .ogg files.
for ($i=0; $i -lt $files.Count; $i++) {
	Write-Host $files[$i]
	Write-Host $files[$i].FullName

	#I'm quite surprised their was not a easier way to do this.
	#TODO: test this line - $fuckPowershellPath = (get-item $files[$i].FullName).parent)
	$fuckPowershellPath = $files[$i].FullName.Substring(0,$files[$i].FullName.LastIndexOf("\") + 1)
	Write-Host $fuckPowershellPath
	$audiodir = $fuckPowershellPath -replace "VIDEO", "AUDIO"
	New-Item -ItemType Directory -Force -Path $audiodir

	$fileName = $files[$i].FullName
	$mp3Name = $fileName -replace $files[$i].Extension, ".ogg"
	$mp3Name = $mp3Name -replace "VIDEO", "AUDIO"
	#If you forget the -vn argument here you'll just end up with another video file.
	$args = '-i "' + $fileName + '" -vn -acodec libvorbis "' + $mp3Name +'"'
	Write-Host $args
	$ffpath = $config.exeDir +'ffmpeg.exe'
	Start-Process -FilePath $ffpath -ArgumentList $args -Wait -NoNewWindow
}