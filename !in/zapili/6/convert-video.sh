#! /bin/sh

rm -f 6.gif

ffmpeg -i sh01.mp4 -ss 0:00:00.0 -t 0:00:00.45 -vf "scale=320:320, crop=256:192" _0.mp4
ffmpeg -i _0.mp4 -vf "reverse" _1.mp4
ffmpeg -i _0.mp4 -i interlace.png -filter_complex "overlay" _0.gif
ffmpeg -i _1.mp4 -i interlace.png -filter_complex "overlay" _1.gif

gifsicle -k 2 -U _0.gif _1.gif -o 6.gif

rm -f _0.mp4
rm -f _1.mp4
rm -f _0.gif
rm -f _1.gif
