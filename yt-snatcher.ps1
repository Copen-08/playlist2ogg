#This script was written by Copen-08.
#02/02/2018
#This script requires a CSV named config.cfg to run.
#This script requires ffmpeg, and youtube-dl to tun.

#checks for the proper directories in the config file.
$config = import-csv config.cfg
#print out the config file so the user can make sure everything is as should be.
Write-Host $config

#Get the playlist url and run youtube-dl with it. Tos all the videos in the VIDEO folder.
$playlist = Read-Host -Prompt 'Please input the playlist url'
$dlargs = '--yes-playlist --format best -o "'+ $config.downloadDir +'VIDEO/%(playlist)s/%(title)s.%(ext)s" ' + $playlist
$path = $config.exeDir +'youtube-dl.exe'
Start-Process -FilePath $path -ArgumentList $dlargs -Wait -NoNewWindow

#Get playlist name from user.
$files = Get-ChildItem -Path $(Read-Host -Prompt 'Please input the download directory')

#Loop through downloaded videos, and convert them to .ogg files.
for ($i=0; $i -lt $files.Count; $i++) {
	Write-Host $files[$i]
	Write-Host $files[$i].FullName

	#I'm quite surprised their was not a easier way to do this.
	$fuckPowershellPath = $files[$i].FullName.Substring(0,$files[$i].FullName.LastIndexOf("\") + 1)
	Write-Host $fuckPowershellPath
	$audiodir = $fuckPowershellPath -replace "VIDEO", "AUDIO"
	New-Item -ItemType Directory -Force -Path $audiodir

	$fileName = $files[$i].FullName
	$mp3Name = $fileName -replace $files[$i].Extension, ".ogg"
	$mp3Name = $mp3Name -replace "VIDEO", "AUDIO"
	$args = '-i "' + $fileName + '" -acodec libvorbis "' + $mp3Name +'"'
	Write-Host $args
	$ffpath = $config.exeDir +'ffmpeg.exe'
	Start-Process -FilePath $ffpath -ArgumentList $args -Wait -NoNewWindow
}