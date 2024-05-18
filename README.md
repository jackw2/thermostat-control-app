# Venstar Colortouch Thermostat Control via iOS

This project is an iOS app and server built with fastapi to enable your Venstar Colortouch thermostat to automatically reduce it's heating/cooling when you are away from home based on the location services of your iPhone.

## Setup

```
git clone https://github.com/jackw2/thermostat-control-app.git
pip install venstarcolortouch
pip install fastapi
```

To enable your thermostat to network access, enable wifi access at `Settings > Wifi > Local API. Verify you can access the thermostat via it's ip address:

```
curl $thermostat_ip_address
{"api_ver":9,"type":"residential","model":"COLORTOUCH","firmware":"6.93"}
```

Configure `config.json```, then start the sever:

```
fastapi dev main.py
```

Set up [telebit.cloud](https://telebit.cloud/) to make your server availible to the internet (you can use a static ip if you prefer).

```
curl https://get.telebit.io/ | bash
~/telebit http 8000
```