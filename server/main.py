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
async def set_location(location: str = Query(...), description="away or home"):
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
async def set_setpoints(heat_to: int = Query(..., description="heat to temp"),
                        cool_to: int = Query(..., description="cool to temp")):
    if thermostat.set_setpoints(heat_to, cool_to):
        return {"message": "Setpoints updated successfully"}
    else:
        raise HTTPException(status_code=500)

@app.post("/set_mode")
async def set_mode(mode: str = Query(..., description="off, heat, cool, auto")):
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

# @app.get("/set_fan")
# async def set_fan(fan: str = Query(..., description="Set the fan mode")):
#     device.set_fan(fan)
#     return {"message": "Fan mode set successfully"}