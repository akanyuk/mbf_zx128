#! /bin/sh

rm -f out-64x48.gif

ffmpeg -i video5.mp4 -vf "scale=64:48, eq=brightness=0.1:contrast=1.0" _0.gif

gifsicle -U -k 8 _0.gif "#0" "#4" "#8" "#12" "#16" "#20" "#24" "#28" "#32" "#36" "#40" "#44" "#48" "#52" "#56" "#60" "#64" "#68" "#72" "#76" "#80" "#84" "#88" "#92" "#96" "#100" -o out-64x48.gif

rm -f _0.mp4
rm -f _0.gif
