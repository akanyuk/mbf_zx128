#! /bin/sh

rm -f out.gif

ffmpeg -i video1.mp4 -ss 0:00:00.0 -t 0:00:12.00 -vf "scale=128:64,eq=brightness=1.6:contrast=2.5" _0.mp4
ffmpeg -i _0.mp4 -i interlace.png -filter_complex "overlay" _1.mp4
ffmpeg -i _1.mp4 _0.gif
ffmpeg -i _1.mp4 -vf "reverse" _1.gif

# echo `seq -f "\"#%g\" " 0 12 160`
gifsicle -U -k 2 _0.gif "#0" "#8" "#16" "#24" "#32" "#40" "#48" "#56" "#64" "#72" "#80" "#88" "#96" "#104" "#112" "#120" "#128" "#136" "#144" "#152" "#160" -o _01.gif
gifsicle -U -k 2 _1.gif "#0" "#8" "#16" "#24" "#32" "#40" "#48" "#56" "#64" "#72" "#80" "#88" "#96" "#104" "#112" "#120" "#128" "#136" "#144" "#152" "#160" -o _11.gif
gifsicle --merge _01.gif _11.gif  -o out.gif

rm -f _0.mp4
rm -f _1.mp4
rm -f _0.gif
rm -f _1.gif
rm -f _01.gif
rm -f _11.gif
