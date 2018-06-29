#video2oggwas written by Copen-08.
#06/29/2018
#version 1.4
#This script requires a CSV named config.cfg to run.
#This script requires ffmpeg, and youtube-dl to tun.


#checks for the proper directories in the config file.
$config = import-csv config.cfg

#print out the config file so the user can make sure everything is as should be.
Write-Host $config

#Get playlist name dir.
$ipath = $config.resultDir +'VIDEO\SINGLES\'
$opath = $config.resultDir +'AUDIO\SINGLES\'
$litInputPath = $ipath -replace "\\", "/"

#create the directories for VIDEO\SINGLES and AUDIO\SINGLES
New-Item -ItemType Directory -Force -Path $ipath
New-Item -ItemType Directory -Force -Path $opath

#Get the playlist url and run youtube-dl with it. Tsos all the videos in the VIDEO folder.
$playlist = Read-Host -Prompt 'Please input the video url'
$filename = Read-Host -Prompt 'Please input the desired filename (without the extention)'

#Added -i to arguments passed to youtube-dl so a messed up video doesn't kill your entire playlist download.
$dlargs = '--no-playlist --format best -i -o "'+ $litInputPath + $filename  + '.%(ext)s" ' + $playlist
$path = $config.exeDir +'youtube-dl.exe'
Start-Process -FilePath $path -ArgumentList $dlargs -Wait -NoNewWindow

#Get playlist name from user.
$files = Get-ChildItem -Path $litInputPath

#Loop through downloaded videos, and convert them to .ogg files.
for ($i=0; $i -lt $files.Count; $i++) {
	Write-Host $files[$i]
	Write-Host $files[$i].FullName
	Write-Host $files[$i].Basename
	
	#only convert the one we just downloaded.
	if($files[$i].Basename -eq $filename){
		$fileName = $files[$i].FullName
		$audioName = $fileName -replace $files[$i].Extension, ".ogg"
		$audioName = $audioName -replace "VIDEO", "AUDIO"
		
		#If you forget the -vn argument here you'll just end up with another video file.
		$args = '-i "' + $fileName + '" -vn -acodec libvorbis "' + $audioName +'"'
		Write-Host $args
		$ffpath = '"' + $config.exeDir +'ffmpeg.exe"'
		Start-Process -FilePath $ffpath -ArgumentList $args -Wait -NoNewWindow
	}
}


