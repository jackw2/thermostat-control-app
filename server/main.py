# Author: Jack Wesolowski
# https://github.com/jackw2/thermostat-control-app
# main.py
from fastapi import FastAPI, Query, HTTPException, Header
from Thermostat import Thermostat
from constants import *
from Secret import Secret
from fastapi import Body


def is_authorized(authorization_header):
  # very basic secret for auth
  return authorization_header == Secret().key


app = FastAPI()
thermostat = Thermostat()


@app.get("/")
async def root():
  return {"message": "Control for thermostat OK.",
          "api_version": "1.0.0"}


@app.post("/set_location")
async def set_location(
  location: str = Query(...),
  Authorization: str = Header()
):
  if not is_authorized(Authorization):
    raise HTTPException(status_code=401, detail="Unauthorized")

  location_value = None
  match location:
    case "home":
      location_value = AWAY_HOME
    case "away":
      location_value = AWAY_AWAY
    case _:
      raise HTTPException(status_code=400)

  if thermostat.set_location(location_value):
    return {"message": "Location set successfully"}
  else:
    raise HTTPException(status_code=500)


@app.post("/set_setpoints")
async def set_setpoints(
  heat_to: int = Query(..., description="heat to temp"),
  cool_to: int = Query(..., description="cool to temp"),
  Authorization: str = Header()
):
  if not is_authorized(Authorization):
    raise HTTPException(status_code=401, detail="Unauthorized")

  if thermostat.set_setpoints(heat_to, cool_to):
    return {"message": "Setpoints updated successfully"}
  else:
    raise HTTPException(status_code=500)


@app.post("/set_mode")
async def set_mode(
  mode: str = Query(..., description="off, heat, cool, auto"),
  Authorization: str = Header()
):
  if not is_authorized(Authorization):
    raise HTTPException(status_code=401, detail="Unauthorized")

  mode_value = None
  match mode:
    case "off":
      mode_value = MODE_OFF
    case "heat":
      mode_value = MODE_HEAT
    case "cool":
      mode_value = MODE_COOL
    case "auto":
      mode_value = MODE_AUTO
    case _:
      raise HTTPException(status_code=400)

  if thermostat.set_mode(mode_value):
    return {"message": "Thermostat mode set successfully"}
  else:
    raise HTTPException(status_code=500)


@app.post("/set_fan")
async def set_fan(
  fan: str = Query(..., description="auto or on"),
  Authorization: str = Header()
):
  if not is_authorized(Authorization):
    raise HTTPException(status_code=401, detail="Unauthorized")

  fan_value = None
  match fan:
    case "auto":
      fan_value = FAN_AUTO
    case "on":
      fan_value = FAN_ON
    case _:
      raise HTTPException(status_code=400)

  if thermostat.set_fan(fan_value):
    return {"message": "Fan mode set successfully"}
  else:
    raise HTTPException(status_code=500)

@app.get("/device_status")
async def get_data(Authorization: str = Header()):
  if not is_authorized(Authorization):
    raise HTTPException(status_code=401, detail="Unauthorized")

  if thermostat.get_data():
    return thermostat.get_data()
  else:
    raise HTTPException(status_code=500)