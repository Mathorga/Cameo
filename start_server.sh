#!/bin/bash

# Start streaming from cam.
LD_LIBRARY_PATH=/opt/mjpg-streamer/ /opt/mjpg-streamer/mjpg_streamer -i "input_libcamera.so -r 640x480 -fps 30" -o "output_http.so -p 9000 -w /opt/mjpg-streamer/www"
/usr/bin/node /home/pi/Cameo/cameo_server.js