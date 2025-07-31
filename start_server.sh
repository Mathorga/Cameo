#!/bin/bash

# Start streaming from cam.
sudo /home/pi/Cameo/start_stream.sh

# Start http server.
sudo /usr/bin/node /home/pi/Cameo/cameo_server.js