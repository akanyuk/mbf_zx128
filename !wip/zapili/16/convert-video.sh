#! /bin/sh

rm -f out.gif

ffmpeg -i video7.mp4 -vf "scale=256:192,eq=brightness=0.5:contrast=1.5" _0.mp4
ffmpeg -i _0.mp4 -vf "fade=out:76:20" _1.mp4
ffmpeg -i _1.mp4 -i interlace.png -filter_complex "overlay" _0.gif

gifsicle -U -k 2 _0.gif "#0" "#4" "#8" "#12" "#16" "#20" "#24" "#28" "#32" "#36" "#40" "#44" "#48" "#52" "#56" "#60" "#64" "#68" "#72" "#76" "#80" "#84" "#88" "#92" "#96" "#100" -o out.gif

rm -f _0.mp4
rm -f _1.mp4
rm -f _0.gif
