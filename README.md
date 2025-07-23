# Cameo
Raspberry Pi headless camera.
	
	## Install
	
	Run the following commands:

### Update the system
```
sudo apt update -y
sudo apt upgrade -y
```

### Install mjpg-streamer
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

### Install web packages
```
sudo apt install -y apache2 nodejs npm
sudo npm install express
sudo npm install socket.io
sudo npm install coffee-script
sudo npm install pi-gpio
sudo npm install pigpio
```

### Install Cameo
```
git clone https://github.com/Mathorga/Cameo.git ~/Cameo
cd ~/Cameo
```

## Run the web app once
```
chmod +x start_stream.sh
sudo start_stream.sh
sudo node cameo_server.js
```

## Run at boot
Copy the provided service file to the services directory
```
sudo cp ~/Cameo/cameo_stream.service /etc/systemd/system/
sudo cp ~/Cameo/cameo_app.service /etc/systemd/system/
```

Make the copied service readable by all
```
sudo chmod 644 /etc/systemd/system/cameo_stream.service
sudo chmod 644 /etc/systemd/system/cameo_app.service
```

Enable the service
```
sudo systemctl daemon-reload
sudo systemctl enable cameo_app.service
sudo reboot
```

If you ever need to stop, start or restart the service:
```
sudo systemctl stop cameo_app.service
sudo systemctl start cameo_app.service
sudo systemctl restart cameo_app.service
```

If you ever need to prevent it from starting at boot:
```
sudo systemctl disable cameo_app.service
```

## Setup private hotspot
https://www.raspberrypi.com/tutorials/host-a-hotel-wifi-hotspot/