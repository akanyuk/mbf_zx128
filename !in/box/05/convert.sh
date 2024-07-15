#! /bin/sh

rm -f _0.mp4
rm -f _0.gif
rm -f _1.gif
rm -f out.gif

ffmpeg -i video16.mp4 -vf "crop=420:420,scale=64:64,eq=brightness=0.1:contrast=2.0" _0.mp4
ffmpeg -i _0.mp4 -i interlace.png -filter_complex "overlay" _0.gif

gifsicle -U -k 2 _0.gif  "#0" "#8" "#16" "#24" "#32" "#40" "#48" "#56" "#64" "#72" "#80" "#88" "#96" -o _1.gif
gifsicle --change-color "0,0,0" "255,255,255" --change-color "252,252,255" "0,0,0" _1.gif -o out.gif
