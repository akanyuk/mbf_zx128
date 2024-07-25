#! /bin/sh

rm -f 9.gif

ffmpeg -i movie.mp4 -vf "crop=576:576,scale=256:192,eq=brightness=0.3:contrast=2.5" _0.gif

gifsicle -U -k 2  _0.gif -o 9.gif

rm -f _0.gif

