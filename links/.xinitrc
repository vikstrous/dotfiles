xset r rate 200 30
xmodmap ~/dotfiles/configs/remap_caps_lock
xsetroot -cursor_name left_ptr
#dropboxd&
if [ "$(cat /etc/hostname)" == 'suchcpuwowmuchram' ]
then
    xinput set-button-map 'Microsoft Microsoft Optical Mouse with Tilt Wheel' 1 2 3 4 5 1 1 1 8
    xrandr --output DVI-I-3 --rotate right
    xrandr --output DVI-I-3 --pos 1680x-100
fi
numlockx on
#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --alpha 0 --tint 0x000000 --height 10&
#nm-applet&
xscreensaver -no-splash&
eval $(cat ~/.fehbg)
#exec xmonad
exec i3
