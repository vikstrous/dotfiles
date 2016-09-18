#!/bin/sh
xrandr --dpi 144 --output eDP1 --primary --mode 2560x1440 --pos 1296x1440 --rotate normal \
    --output DP1-1 --mode 2560x1440 --pos 0x0 --rotate normal \
    --output DP1-8 --mode 2560x1440 --pos 2560x0 --rotate normal
xset -dpms
xset r rate 200 30
sleep 5
~/.fehbg
