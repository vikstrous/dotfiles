#!/usr/bin/fish

# rsyslog
pacman -S rsyslog
mkdir /etc/rsyslog.d
cp rsyslog.d/* /etc/rsyslog.d/
systemctl daemon-reload
systemctl stop syslog-ng
systemctl start rsyslog

# iptables
iptables-restore < iptables/laptop.conf
iptables  -nvL
