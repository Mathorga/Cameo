#!/bin/bash

# Update the system.
# sudo apt update -y
# sudo apt upgrade -y

# Install mjpg-streamer dependencies.
echo "Installing gcc and g++"
sudo apt install -y gcc g++
if [[ $? -eq 0 ]]; then
    echo "Successfully installed gcc and g++"
else
    echo "Error installing gcc and g++"
    exit 1
fi
echo "Installing pkg-config"
sudo apt install -y pkg-config
if [[ $? -eq 0 ]]; then
    echo "Successfully installed pkg-config"
else
    echo "Error installing pkg-config"
    exit 1
fi
echo "Installing libcamera-dev"
sudo apt install -y libcamera-dev
if [[ $? -eq 0 ]]; then
    echo "Successfully installed libcamera-dev"
else
    echo "Error installing libcamera-dev"
    exit 1
fi
echo "Installing git, cmake and libjpeg62-turbo-dev"
sudo apt install -y git cmake libjpeg62-turbo-dev
if [[ $? -eq 0 ]]; then
    echo "Successfully installed libjpeg62-turbo-dev"
else
    echo "Error installing libjpeg62-turbo-dev"
    exit 1
fi

# Install mjpg-streamer.
echo "installing mjpg-streamer"
git clone https://github.com/ArduCAM/mjpg-streamer.git ~/mjpg-streamer
cd ~/mjpg-streamer/mjpg-streamer-experimental
make clean distclean
make all
if [[ $? -eq 0 ]]; then
    echo "Successfully installed mjpg-streamer"
else
    echo "Error installing mjpg-streamer"
    exit 1
fi
sudo mkdir /opt/mjpg-streamer
sudo mv * /opt/mjpg-streamer
cd

# Install web packages.
echo "installing apache, nodejs and npm"
sudo apt install -y apache2 nodejs npm
if [[ $? -eq 0 ]]; then
    echo "Successfully installed apache, nodejs and npm"
else
    echo "Error installing apache, nodejs and npm"
    exit 1
fi
echo "installing node dependencies"
sudo npm install express
if [[ $? -eq 0 ]]; then
    echo "Successfully installed express"
else
    echo "Error installing express"
    exit 1
fi
sudo npm install socket.io
if [[ $? -eq 0 ]]; then
    echo "Successfully installed socket.io"
else
    echo "Error installing socket.io"
    exit 1
fi
sudo npm install coffee-script
if [[ $? -eq 0 ]]; then
    echo "Successfully installed coffee-script"
else
    echo "Error installing coffee-script"
    exit 1
fi
sudo npm install pi-gpio
if [[ $? -eq 0 ]]; then
    echo "Successfully installed pi-gpio"
else
    echo "Error installing pi-gpio"
    exit 1
fi
sudo npm install pigpio
if [[ $? -eq 0 ]]; then
    echo "Successfully installed pigpio"
else
    echo "Error installing pigpio"
    exit 1
fi

# Setup service to run at boot.
echo "installing services"
sudo chmod +x ~/Cameo/install_services.sh
~/Cameo/install_services.sh
echo "services installed"
