# Author: Jack Wesolowski
# https://github.com/jackw2/thermostat-control-app
# Secret.py
import json
import os


class Secret:
  _instance = None

  def __new__(cls, *args, **kwargs):
    if not cls._instance:
      cls._instance = super().__new__(cls, *args, **kwargs)
      cls._instance._initialize()
    return cls._instance

  def _initialize(self):
    current_dir = os.path.dirname(os.path.abspath(__file__))
    with open(os.path.join(current_dir, "config.json"), "r") as file:
      config = json.load(file)
      self.key = config['secret']
