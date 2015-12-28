if [ "$(hostname)" == 'nothingtoseehere' ]
then
    xinput set-button-map 'Microsoft Microsoft Optical Mouse with Tilt Wheel' 1 2 3 4 5 1 1 1 8
fi
if [ "$(hostname)" == 'compooter' ]
then
    /home/v/dotfiles/configs/screenlayout/nomonitor-fast.sh
fi
exec i3
