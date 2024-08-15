#! /bin/sh

rm -f out.gif

ffmpeg -i movie.mp4 -vf "crop=576:576, scale=192:192, eq=brightness=0.5:contrast=2.5" _0.mp4
ffmpeg -i _0.mp4 -i interlace2.png -filter_complex "overlay" _0.gif

# echo `seq -f "\"#%g\" " 0 4 100`
#gifsicle -U -k 2 _0.gif "#0" "#8" "#16" "#24" "#32" "#40" "#48" "#56" "#64" "#72" "#80" "#88" "#96" "#104" "#112" "#120" "#128" "#136" "#144" "#152" "#160" -o 9.gif

gifsicle -U -k 2 _0.gif "#0" "#4" "#8" "#12" "#16" "#20" "#24" "#28" "#32" "#36" "#40" "#44" "#48" "#52" "#56" "#60" "#64" "#68" "#72" "#76" "#80" "#84" "#88" "#92" "#96" "#100" -o _1.gif
gifsicle _1.gif "#7" "#8" "#9" "#10" "#11" "#12" "#13" "#14" -o out.gif

rm -f _0.mp4
rm -f _0.gif
rm -f _1.gif

