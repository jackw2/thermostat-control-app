# Author: Jack Wesolowski
# https://github.com/jackw2

from venstarcolortouch import VenstarColorTouch
import json

# Read from config.jsonn
with open('config.json', 'r') as file:
  config = json.load(file)

device_info = config['device_info']

ct = VenstarColorTouch(device_info["ip_address"], timeout=5)

if ct.login() is True:
  print("Login successful. API: {0} Type: {1}".format(ct._api_ver,ct._type))

if ct.update_info() is True:
  print("Was able to get info:{0}".format(ct._info))
else:
  print("Was not able to get info")