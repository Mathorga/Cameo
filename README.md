# Cameo
Raspberry Pi headless camera.

## Install
Run the following commands:
```
sudo apt update
sudo apt upgrade
sudo apt install -y apache2 nodejs npm
```
```
git clone https://github.com/Mathorga/Cameo.git
```
or
```
git clone git@github.com:Mathorga/Cameo.git
```
```
cd Cameo
sudo npm install express
sudo npm install socket.io
```

Install GPIO control (not needed):
```
sudo npm install pi-gpio
sudo npm install pigpio
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