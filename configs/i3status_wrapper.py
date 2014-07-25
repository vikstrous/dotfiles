#!/usr/bin/env python2
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import sys
import json
import urllib2
import subprocess

#def get_governor():
#    """ Get the current governor for cpu0, assuming all CPUs use the same. """
#    with open('/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor') as fp:
#        return fp.readlines()[0].strip()

def get_updates():
    p = subprocess.Popen("pacman -Qu", shell=True, stdin=subprocess.PIPE, stderr=subprocess.STDOUT, stdout=subprocess.PIPE, close_fds=True)
    out, err = p.communicate()
    return len(out.split('\n')) - 1

def get_red():
    data = json.loads(urllib2.urlopen('http://redflare.ofthings.net/reports').read().decode('UTF-8'))
    return str(reduce(lambda a,b: max(a, data[b]['clients']), data, 0))

def get_btc(currency):
    return str(float(json.loads(urllib2.urlopen('https://api.bitcoinaverage.com/ticker/global/'+currency+'/').read().decode('UTF-8'))['last']))

def get_ltc():
    return str(float(json.loads(urllib2.urlopen('https://btc-e.com/api/2/ltc_usd/ticker').read().decode('UTF-8'))['ticker']['last']))

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        try:
            j.insert(0, {'full_text' : 'LTC: $%s' % get_ltc(), 'name' : 'LTC'})
        except:
            pass
        try:
            j.insert(0, {'full_text' : 'BTC: $%s' % get_btc('USD'), 'name' : 'BTCUSD'})
        except:
            pass
        try:
            j.insert(0, {'full_text' : 'BTC: %s CAD' % get_btc('CAD'), 'name' : 'BTCCAD'})
        except:
            pass
        try:
            j.insert(0, {'full_text' : '%s RE' % get_red(), 'name' : 'redeclipse'})
        except:
            pass

        try:
            updates = get_updates()
            if updates > 0:
              j.insert(0, {'full_text' : 'Updates: %s' % get_updates(), 'name' : 'updates'})
        except:
            pass
        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
