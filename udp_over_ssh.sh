#client:
ssh -L 6667:localhost:6667 server

#server:
socat -T10 TCP4-LISTEN:6667,fork UDP4:8.8.8.8:53

#client:
sudo socat UDP4-LISTEN:53,fork TCP4:localhost:6667
