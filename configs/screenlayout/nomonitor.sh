#!/bin/sh
xrandr --dpi 96 --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output HDMI-1 --off
#xrandr --dpi 192 --output VIRTUAL1 --off --output eDP1 --mode 3200x1800 --pos 0x0 --rotate normal --output DP1 --off --output DP1-1 --off --output HDMI1 --off --output DP1-8 --off
sleep 5

xinput set-float-prop 14 311 2.000000, 1.600, 0.000000, 0.000000
xinput set-int-prop 14 315 8 0 0 0 0 1 3 2
xinput set-float-prop 14 140 0.8, 0.000000, 0.000000, 0.000000, 0.625000, 0.000000, 0.000000, 0.000000, 1.000000

xset -dpms
xset r rate 200 30
~/.fehbg
