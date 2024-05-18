from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}

temperature = 0

@app.put("/temperature/increase")
async def increase_temperature():
    global temperature
    temperature += 1
    return {"message": "Temperature increased"}

@app.put("/temperature/decrease")
async def decrease_temperature():
    global temperature
    temperature -= 1
    return {"message": "Temperature decreased"}