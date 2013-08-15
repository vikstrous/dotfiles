#!/usr/bin/fish

# rsyslog
pacman -S rsyslog
mkdir /etc/rsyslog.d
cp rsyslog/rsyslog.d/* /etc/rsyslog.d/
cp rsyslog/rsyslog.conf /etc/rsyslog.conf
systemctl daemon-reload
systemctl enable rsyslog
systemctl stop rsyslog
systemctl start rsyslog

# iptables
iptables-restore < iptables/laptop.conf
iptables  -nvL
