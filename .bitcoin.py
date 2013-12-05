#!/usr/bin/env python
import urllib.request, json

print(float(json.loads(urllib.request.urlopen('https://data.mtgox.com/api/1/BTCUSD/ticker').read().decode('UTF-8'))['return']['last']['value']))
