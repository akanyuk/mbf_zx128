#! /bin/sh

rm -f 13.gif

ffmpeg -i video4.mp4 -vf "scale=256:192,eq=brightness=0.5:contrast=1.5" _0.mp4
ffmpeg -i _0.mp4 -i interlace.png -filter_complex "overlay" _0.gif

gifsicle -U -k 2 _0.gif -o 13.gif

rm -f _0.mp4
rm -f _0.gif
