#! /bin/sh

rm -f _0.mp4
rm -f _1.mp4
rm -f _0.gif
rm -f 4.gif

ffmpeg -i 4.mp4 -ss 0:00:01.8 -t 0:00:00.55 -vf "select='mod(n,3)', scale=300:192, crop=256:192" _0.mp4
ffmpeg -i _0.mp4 -vf "fade=out:13:4" _1.mp4
ffmpeg -i _1.mp4 -i interlace2.png -filter_complex "overlay" _0.gif

gifsicle -U -k 2 _0.gif -o 4.gif

