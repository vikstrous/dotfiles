#!/bin/sh
xrandr  --dpi 192 --output VIRTUAL1 --off --output eDP1 --mode 3200x1800 --pos 2296x2160 --rotate normal --output DP1 --off --output DP1-1 --mode 3840x2160 --pos 0x0 --rotate normal --output HDMI1 --off --output DP1-8 --mode 3840x2160 --pos 3840x0 --rotate normal
sleep 5
xrandr  --dpi 192 --output VIRTUAL1 --off --output eDP1 --mode 3200x1800 --pos 2296x2160 --rotate normal --output DP1 --off --output DP1-1 --mode 3840x2160 --pos 0x0 --rotate normal --output HDMI1 --off --output DP1-8 --mode 3840x2160 --pos 3840x0 --rotate normal
sleep 5
xset -dpms
xset r rate 200 30
~/.fehbg
