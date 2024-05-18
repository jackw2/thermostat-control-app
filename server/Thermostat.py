from venstarcolortouch import VenstarColorTouch
import json

class Thermostat:
  _instance = None

  def __new__(cls, *args, **kwargs):
    if not cls._instance:
      cls._instance = super().__new__(cls, *args, **kwargs)
      cls._instance._initialize()
    return cls._instance

  def _initialize(self):
    self.log_file = open("log.txt", "a")
    with open("config.json", "r") as file:
      config = json.load(file)
      self.device_info = config['device_info']
    self.device = VenstarColorTouch(device_info["ip_address"], timeout=device_info["timeout"])
    self.device.login()
    self.device.update_info()

  def get_data(self):
    # Add your code here to fetch and return the thermostat data
    pass
