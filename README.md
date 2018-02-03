# playlist2ogg
A powershell script I made to turn playlists into .ogg files easily.

This script has two dependancies:
1) You'll need FFMPEG - https://www.ffmpeg.org/download.html
2) You'll need youtube-dl - https://rg3.github.io/youtube-dl/

So the first thing you'll want to do after you download this is go into config.cfg, and change the path for exeDir, and downloadDir.

exeDir needs to be a folder that has both ffmpeg.exe in it, and youtube-dl.exe as well.
downloadDir can probably be anywhere, but inside the directory you point downloadDir to needs to be two folders. AUDIO, and VIDEO.

Finally, just right click yt-snatcher.ps1 and give it a playlist url. Once it's down downloading them you'll need to point it to the folder it created in VIDEO manually so it can populate AUDIO. Once it's done you can go to AUDIO for your new .ogg files.
