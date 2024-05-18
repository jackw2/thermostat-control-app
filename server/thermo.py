# Author: Jack Wesolowski
# https://github.com/jackw2/thermostat-control-app
# Thermo.py
from Thermostat import Thermostat
from constants import *

Thermostat().login()
print(Thermostat().get_data())

Thermostat().device.set_away(AWAY_HOME)
Thermostat().device.set_setpoints(72,77)
Thermostat().device.set_mode(MODE_AUTO)
Thermostat().device.set_fan(FAN_AUTO)