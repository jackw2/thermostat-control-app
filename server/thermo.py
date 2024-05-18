# Author: Jack Wesolowski
# https://github.com/jackw2/thermostat-control-app
# Thermo.py
from Thermostat import Thermostat
from constants import *

Thermostat().login()
print(Thermostat().get_data())

Thermostat().device.set_away(AWAY_HOME)