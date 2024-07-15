#! /bin/sh

rm -f 9.gif

ffmpeg -i video.mp4 -ss 0:00:00.0 -t 0:00:10.0 -vf "scale=256:256,crop=256:192,eq=brightness=0.3:contrast=2.5" _0.mp4
ffmpeg -i _0.mp4 _0.gif
ffmpeg -i _0.mp4 -vf "reverse" _1.gif

gifsicle -U -k 2  --merge _0.gif _1.gif -o 9.gif

rm -f _0.mp4
rm -f _1.mp4
rm -f _0.gif
rm -f _1.gif
