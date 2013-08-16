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
cp iptables/laptop.conf /etc/iptables/iptables.rules
systemctl enable iptables
systemctl stop iptables
systemctl start iptables
iptables  -nvL
