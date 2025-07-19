# Cameo
Raspberry Pi headless camera.

## Install

Run the following commands:

### Update the system
```
sudo apt update -y
sudo apt upgrade -y
```

```
rpicam-vid -t 0 --inline --listen -o tcp://[IP_ADDRESS]:[port]
```

### Install mjpg-streamer
https://github.com/jacksonliam/mjpg-streamer/blob/master/mjpg-streamer-experimental/plugins/output_http/README.md
```
sudo apt install -y gcc g++
-- sudo apt install -y libraspberrypi-dev libraspberrypi-bin libjpeg8-dev cmake
sudo apt install -y git cmake libjpeg9-dev
git clone https://github.com/ArduCAM/mjpg-streamer.git ~/mjpg-streamer
cd ~/mjpg-streamer/mjpg-streamer-experimental
make clean distclean
make all
sudo mkdir /opt/mjpg-streamer
sudo mv * /opt/mjpg-streamer
cd
```

### Install web packages
```
sudo apt install -y apache2 nodejs npm
sudo npm install express
sudo npm install socket.io
sudo npm install node-ads1x15
sudo npm install coffee-script
sudo npm install pi-gpio
sudo npm install pigpio
```

### Install Cameo
```
git clone https://github.com/Mathorga/Cameo.git ~/Cameo
cd ~/Cameo
```

## Run the web app
```
sudo node cameo_server.js
```

## Run at boot
Make sure the ```/etc/rc.local``` file exists. If it does not exist, create it with the command:
```
sudo touch /etc/rc.local
```

Add the following commands to /etc/rc.local before "exit 0":

```
cd /home/pi/Desktop/touchUI
sudo node cameo.js&
cd
```

If you just created the ```rc.local``` file, then also add the
```
exit 0
```
line at the end.