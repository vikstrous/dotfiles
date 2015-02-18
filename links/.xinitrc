if [ "$(cat /etc/hostname)" == 'suchcpuwowmuchram' ]
then
    xinput set-button-map 'Microsoft Microsoft Optical Mouse with Tilt Wheel' 1 2 3 4 5 1 1 1 8
#xrandr --output DVI-I-3 --rotate right
#    xrandr --output DVI-I-3 --pos 1680x-100
fi
xcompmgr&
exec ssh-agent "bash" -c "ssh-add && i3"
