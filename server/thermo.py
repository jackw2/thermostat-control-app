# Author: Jack Wesolowski
# https://github.com/jackw2



# Read from config.jsonn

ct = VenstarColorTouch(device_info["ip_address"], timeout=5)

if ct.login() is True:
  print("Login successful. API: {0} Type: {1}".format(ct._api_ver,ct._type))

if ct.update_info() is True:
  print("Was able to get info:{0}".format(ct._info))
else:
  print("Was not able to get info")

data = {
  "state": ct.get_info("state"),
  "away": ct.get_info("away"),
  "spacetemp": ct.get_info("spacetemp"),
  "heattemp": ct.get_info("heattemp"),
  "cooltemp": ct.get_info("cooltemp")
}
print(data)

