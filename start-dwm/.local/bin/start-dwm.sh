#!/bin/sh

file_name=$HOME/Pictures/wallpapers/11002937.jpg
feh --bg-fill --no-fehbg $file_name &
dwmblocks &
exec dwm
