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
    self.device = VenstarColorTouch(
      self.device_info["ip_address"],
      timeout=self.device_info["timeout"]
    )

  def login(self) -> bool:
    if self.device.login() is True:
      print("Login successful. API: {0} Type: {1}".format(
        self.device._api_ver, self.device._type))
      return True
    else:
      print("Login failed.")
      return False

  def get_data(self) -> dict:
    # Add your code here to fetch and return the thermostat data
    if self.device.update_info() is True:
      data = {
          "state": self.device.get_info("state"),
          "away": self.device.get_info("away"),
          "spacetemp": self.device.get_info("spacetemp"),
          "heattemp": self.device.get_info("heattemp"),
          "cooltemp": self.device.get_info("cooltemp")
      }
      return data
    return None
