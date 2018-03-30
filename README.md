# playlist2ogg
A powershell script I made to turn playlists into .ogg files easily.

This script has two dependancies:
1) You'll need FFMPEG - https://www.ffmpeg.org/download.html
2) You'll need youtube-dl - https://rg3.github.io/youtube-dl/

So the first thing you'll want to do after you download this is go into config.cfg, and change the path for exeDir, and resultDir.

exeDir needs to be a folder that has both ffmpeg.exe in it, and youtube-dl.exe as well.
resultDir can probably be anywhere, but inside the directory you point downloadDir to needs to be two folders. AUDIO, and VIDEO.

Finally, just right click playlist2ogg.ps1 and give it a playlist url, and the name of the folder you want the files in. Once it's down downloading you'll find the video files in the VIDEO folder, and the audio files in the AUDIO.
