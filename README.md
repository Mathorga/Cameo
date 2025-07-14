# Cameo
Raspberry Pi headless camera.

## Install
Run the following commands:

### Update the system
```
sudo apt update
sudo apt upgrade
```

### Install mjpg-streamer
```
sudo apt install -y libjpeg62-turbo-dev
sudo apt install -y cmake
git clone https://github.com/jacksonliam/mjpg-streamer.git ~/mjpg-streamer
cd ~/mjpg-streamer/mjpg-streamer-experimental
make clean
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
sudo npm install ads1x15
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