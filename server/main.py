# Author: Jack Wesolowski
# https://github.com/jackw2/thermostat-control-app
# main.py
from fastapi import FastAPI, Query, HTTPException
from Thermostat import Thermostat
from constants import *

app = FastAPI()
thermostat = Thermostat()
device = thermostat.device

@app.get("/")
async def root():
    return {"message": "Control for thermostat OK.",
            "api_version": "1.0.0"}

@app.post("/set_location")
async def set_location(location: str = Query(...)):
    set_to = None
    match location:
        case "home":
            set_to = AWAY_HOME
        case "away":
            set_to = AWAY_AWAY
        case _:
            raise HTTPException(status_code=400)
    print(set_to)
    if device.set_away(set_to):
        return {"message": "Location set successfully"}
    else:
        raise HTTPException(status_code=500)

# @app.get("/set_setpoints")
# async def set_setpoints(low: int = Query(..., description="Set the low setpoint"),
#                         high: int = Query(..., description="Set the high setpoint")):
#     device.set_setpoints(low, high)
#     return {"message": "Setpoints updated successfully"}

# @app.get("/set_mode")
# async def set_mode(mode: str = Query(..., description="Set the thermostat mode")):
#     device.set_mode(mode)
#     return {"message": "Thermostat mode set successfully"}

# @app.get("/set_fan")
# async def set_fan(fan: str = Query(..., description="Set the fan mode")):
#     device.set_fan(fan)
#     return {"message": "Fan mode set successfully"}