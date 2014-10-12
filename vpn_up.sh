openvpn --config /home/v/dotfiles/configs/tun0.conf --verb 6
ip route add default via 10.1.0.2 dev tun0 proto static
