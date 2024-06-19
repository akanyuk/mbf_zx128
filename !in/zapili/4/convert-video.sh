#! /bin/sh

rm -f 4.gif

ffmpeg -i 4.mp4 -ss 0:00:01.8 -t 0:00:00.5 -vf "select='mod(n,3)', scale=300:192, crop=256:192" 4in.gif

gifsicle --colors 256 4in.gif -o _1.gif
gifsicle --unoptimize _1.gif -o _2.gif
gifsicle --colors 2 _2.gif -o 4.gif

rm -f _1.gif
rm -f _2.gif
rm -f 4in.gif