# Location Based Thermostat Control for iOS

## Concept Overview

This project is an iOS app (and server) to help you save on your energy bill. By using your location, the app adjusts your thermostat's heating & cooling while you are away!


<img src="./readme-images/thermostat.jpg" width="300"/>

## Technology Overview

iOS:

- Combine - used for implementing the Observer pattern, much like ReactiveX
- Security / Keychain - for securely storing the password on the device
- Alamofire - handling requests to the server
- CoreLocation - tracking the user's location 
- MapKit - displaying the users location
- SwiftUI - building the UI

Server:

- FastAPI - exposing some thermostat functionality to the internet via a REST API

## iOS Setup

You can set the temperature, fan settings, and mode here.

<img src="./readme-images/control-panel.png" width="300"/>

Connect to the server, rename your home, and set the radius where you want the thermostat to begin heating/cooling.

<img src="./readme-images/settings-empty.png" width="300"/>
<img src="./readme-images/settings.png" width="300"/>

Search for the address you want to mark as your home.

<img src="./readme-images/address-search.png" width="300"/>
<img src="./readme-images/saving-address.png" width="300"/>

Now as you approach your home, the thermostat will automatically turn on, and disable as you leave, reducing wasted energy temperature-controlling your home.

<img src="./readme-images/away.png" width="300"/>
<img src="./readme-images/home.png" width="300"/>

## Server Setup

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

On the iPhone app in the settings tab, configure the url and secret to match that of your server configuration. Search for your home address and configure the radius to your preferred distance.
