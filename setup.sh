#!/bin/bash

# Update the system.
sudo apt update -y
sudo apt upgrade -y

# Install mjpg-streamer dependencies.
sudo apt install -y gcc g++
sudo apt install -y pkg-config
sudo apt install -y libcamera-dev
sudo apt install -y git cmake libjpeg9-dev

# Install mjpg-streamer.
git clone https://github.com/ArduCAM/mjpg-streamer.git ~/mjpg-streamer
cd ~/mjpg-streamer/mjpg-streamer-experimental
make clean distclean
make all
sudo mkdir /opt/mjpg-streamer
sudo mv * /opt/mjpg-streamer
cd

# Install web packages.
sudo apt install -y apache2 nodejs npm
sudo npm install express
sudo npm install socket.io
sudo npm install coffee-script
sudo npm install pi-gpio
sudo npm install pigpio

# Setup service to run at boot.
sudo chmod +x ~/Cameo/install_service.sh
~/Cameo/install_service.sh