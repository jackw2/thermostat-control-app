# Venstar Colortouch Thermostat Control via iOS

This project is an iOS app and fastapi server to enable your Venstar Colortouch thermostat to automatically reduce it's heating/cooling when you are away from home based on the location services of your iPhone.

## Setup

`pip install venstarcolortouch`

To enable your thermostat to network access, enable wifi access at `Settings > Wifi > Local API. Verify you can access the thermostat via it's ip address:

`curl 172.20.3.221` 

You should see a similar response:

`{"api_ver":9,"type":"residential","model":"COLORTOUCH","firmware":"6.93"}`

## Usage

Start the sever:

`fastapi dev main.py`