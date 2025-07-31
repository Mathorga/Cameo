#!/bin/bash

# Start streaming from cam.
/home/pi/Cameo/start_stream.sh

# Start http server.
/usr/bin/node /home/pi/Cameo/cameo_server.js
