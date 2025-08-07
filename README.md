# Cameo
Raspberry Pi headless camera.

Tested on Raspberry pi OS Bookworm 32-bit on RPi zero W and zero 2 W.

## Install

### Option 1: Clone Cameo and run the setup script.
The script will take care of everything for you, you'll just need to prompt as requested along the way.
```
sudo apt install -y git
git clone https://github.com/Mathorga/Cameo.git ~/Cameo
sudo chmod +x ~/Cameo/setup.sh
~/Cameo/setup.sh
```

### Option 2: DIY

Run the following commands

#### Update the system
```
sudo apt update -y
sudo apt upgrade -y
```

#### Install mjpg-streamer
```
sudo apt install -y gcc g++
sudo apt install -y pkg-config
sudo apt install -y libcamera-dev
sudo apt install -y git cmake libjpeg9-dev
git clone https://github.com/ArduCAM/mjpg-streamer.git ~/mjpg-streamer
cd ~/mjpg-streamer/mjpg-streamer-experimental
make clean distclean
make all
sudo mkdir /opt/mjpg-streamer
sudo mv * /opt/mjpg-streamer
cd
```

#### Install web packages
```
sudo apt install -y apache2 nodejs npm
sudo npm install express
sudo npm install socket.io
sudo npm install coffee-script
sudo npm install pi-gpio
sudo npm install pigpio
```

#### Install Cameo
```
git clone https://github.com/Mathorga/Cameo.git ~/Cameo
cd ~/Cameo
```

#### Run the web app once (if you want to test it before going on)
```
chmod +x start_stream.sh
sudo start_stream.sh
sudo node cameo_server.js
```

#### Run at boot
In order to make the app run at boot you can run the following commands
```
sudo chmod +x ~/Cameo/install_services.sh
./install_services.sh
```
This script will install a systemd service which runs the server at boot time and then it will reboot the system, so be ready to be logged off.

If you ever need to stop, start or restart the service:
```
sudo systemctl stop cameo.service
sudo systemctl start cameo.service
sudo systemctl restart cameo.service
```

If you ever need to prevent it from starting at boot:
```
sudo systemctl disable cameo.service
```

If you ever need to monitor the output of one of the service:
```
journalctl -u cameo.service
```

#### Setup private hotspot
Create a wifi hotspot using the builtin controller (wlan0).

The network will be named "cameo" and its password will be "raspberry"
```
chmod +x start_hotspot.sh
sudo start_hotspot.sh
```

If you ever need to stop the hotspot
```
sudo nmcli connection down Hotspot
```

## Usage
1. After everything is installed, turn the pi on and from another device wait for the "cameo" wifi network to show up.
2. Once it's up, connect to it using the password "raspberry". The device you're connecting from will tell you the network has no internet access, but that's ok, just confirm you want to stay connected if prompted.
3. Open up a browser (any browser will do) and connect to http://10.42.0.1:3000/. If everything went as planned you should see the Cameo UI with live feed from your camera.
4. Point to your favorite subject and snap a picture with the shoot button.