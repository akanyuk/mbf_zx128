#! /bin/sh

rm -f out-64x48.gif

# -ss 0:00:01.0 -t 0:00:03.5

ffmpeg -i video2.mp4 -vf "scale=64:16,pad=width=64:height=48:x=0:y=16:color=black,eq=brightness=0.5:contrast=2.0" _0.mp4
ffmpeg -i _0.mp4 _0.gif
ffmpeg -i _0.mp4 -vf "reverse" _1.gif

gifsicle -U -k 6 _0.gif "#0" "#8" "#16" "#24" "#32" "#40" "#48" "#56" "#64" "#72" "#80" "#88" "#96" "#104" "#112" "#120" "#128" "#136" "#144" "#152" "#160" -o _01.gif
gifsicle -U -k 6 _1.gif "#0" "#8" "#16" "#24" "#32" "#40" "#48" "#56" "#64" "#72" "#80" "#88" "#96" "#104" "#112" "#120" "#128" "#136" "#144" "#152" "#160" -o _11.gif
gifsicle --merge _01.gif _11.gif  -o out-64x48.gif

rm -f _0.mp4
rm -f _0.gif
rm -f _1.gif
rm -f _01.gif
rm -f _11.gif
