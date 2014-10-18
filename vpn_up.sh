openvpn --config /home/v/dotfiles/configs/tun0.conf --verb 0 > /dev/null &
sleep 1
ip route add 107.170.156.235 via 192.168.90.1 dev wlp3s0  proto static
ip route add default via 10.1.0.1 dev tun0 proto static
