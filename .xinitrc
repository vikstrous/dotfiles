xset r rate 200 30
xmodmap ~/.remap_caps_lock
xsetroot -cursor_name left_ptr
dropboxd&
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x000000 --height 10&
#nm-applet&
eval $(cat ~/.fehbg)
exec xmonad
