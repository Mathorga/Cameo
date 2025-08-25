#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

# Update the system.
printf "Updating the system"
sudo apt update -y
sudo apt upgrade -y

# Install mjpg-streamer dependencies.
printf "${RED}Installing gcc and g++${NC}\n"
sudo apt install -y gcc g++
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed gcc and g++${NC}\n"
else
    printf "${RED}Error installing gcc and g++${NC}\n"
    exit 1
fi
printf "${RED}Installing pkg-config${NC}\n"
sudo apt install -y pkg-config
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed pkg-config${NC}\n"
else
    printf "${RED}Error installing pkg-config${NC}\n"
    exit 1
fi
printf "${RED}Installing libcamera-dev${NC}\n"
sudo apt install -y libcamera-dev
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed libcamera-dev${NC}\n"
else
    printf "${RED}Error installing libcamera-dev${NC}\n"
    exit 1
fi
printf "${RED}Installing git, cmake and libjpeg62-turbo-dev${NC}\n"
sudo apt install -y git cmake libjpeg62-turbo-dev
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed libjpeg62-turbo-dev${NC}\n"
else
    printf "${RED}Error installing libjpeg62-turbo-dev${NC}\n"
    exit 1
fi

# Install mjpg-streamer.
printf "${RED}installing mjpg-streamer${NC}\n"
git clone https://github.com/ArduCAM/mjpg-streamer.git ~/mjpg-streamer
cd ~/mjpg-streamer/mjpg-streamer-experimental
make clean distclean
make all
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed mjpg-streamer${NC}\n"
else
    printf "${RED}Error installing mjpg-streamer${NC}\n"
    exit 1
fi
sudo mkdir /opt/mjpg-streamer
sudo mv * /opt/mjpg-streamer
cd

# Install web packages.
printf "${RED}installing apache, nodejs and npm${NC}\n"
sudo apt install -y apache2 nodejs npm
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed apache, nodejs and npm${NC}\n"
else
    printf "${RED}Error installing apache, nodejs and npm${NC}\n"
    exit 1
fi
printf "${RED}installing node dependencies${NC}\n"
sudo npm install express
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed express${NC}\n"
else
    printf "${RED}Error installing express${NC}\n"
    exit 1
fi
sudo npm install socket.io
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed socket.io${NC}\n"
else
    printf "${RED}Error installing socket.io${NC}\n"
    exit 1
fi
sudo npm install coffee-script
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed coffee-script${NC}\n"
else
    printf "${RED}Error installing coffee-script${NC}\n"
    exit 1
fi
sudo npm install pi-gpio
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed pi-gpio${NC}\n"
else
    printf "${RED}Error installing pi-gpio${NC}\n"
    exit 1
fi
sudo npm install pigpio
if [[ $? -eq 0 ]]; then
    printf "${RED}Successfully installed pigpio${NC}\n"
else
    printf "${RED}Error installing pigpio${NC}\n"
    exit 1
fi

# Setup service to run at boot.
printf "${RED}installing services${NC}\n"
sudo chmod +x ~/Cameo/install_services.sh
~/Cameo/install_services.sh
printf "${RED}services installed${NC}\n"
