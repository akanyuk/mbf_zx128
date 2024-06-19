#! /bin/sh

rm -f 5.gif

ffmpeg -i 5.mp4 -ss 0:00:00.0 -t 0:00:02.5 -vf "select='mod(n,2)', transpose=2, scale=256:192" _0.gif

gifsicle --colors 256 _0.gif -o _1.gif
gifsicle --unoptimize _1.gif -o _2.gif
gifsicle --colors 2 _2.gif -o 5.gif

rm -f _0.gif
rm -f _1.gif
rm -f _2.gif
