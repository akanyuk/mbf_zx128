#! /bin/sh

rm -f 7.gif
rm -rf img

# -ss 0:00:00.0 -t 0:00:00.7 
# shuffleframes='0 -1 -1 -1 -1 -1 -1 -1', 
# echo `seq -f "\"#%g\" " 0 4 100`

ffmpeg -i sh02.mp4 -ss 0:00:00.0 -t 0:00:02.6 -vf "transpose=2, scale=256:256, crop=256:192" _0.mp4
ffmpeg -i _0.mp4 -i interlace2.png -filter_complex "overlay" _0.gif

gifsicle -k 2 -U _0.gif "#0" "#4" "#8" "#12" "#16" "#20" "#24" "#28" "#32" "#36" "#40" "#44" "#48" "#52" "#56" "#60" "#64" "#68" "#72" "#76" "#80" "#84" "#88" "#92" "#96" "#100" -o 7.gif

rm -f _0.gif
rm -f _0.mp4
