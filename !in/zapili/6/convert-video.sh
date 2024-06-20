#! /bin/sh

rm -f 6.gif

ffmpeg -i sh01.mp4 -vf "select='mod(n,2)', transpose=2, scale=192:192" _0.gif

gifsicle --colors 256 _0.gif -o _1.gif
gifsicle --unoptimize _1.gif -o _2.gif
gifsicle --colors 2 _2.gif -o 6.gif

rm -f _0.gif
rm -f _1.gif
rm -f _2.gif
