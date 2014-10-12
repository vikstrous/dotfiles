openvpn --config /home/v/dotfiles/configs/tun0.conf --verb 0 > /dev/null &
sleep 1
ip route add default via 10.1.0.1 dev tun0 proto static
