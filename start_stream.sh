#!/bin/bash

# Launch mjpg-streamer with libcamera input and http output. All outputs are suppressed.
# Remove [... > /dev/null 2>&1&] at the end to display outputs.
LD_LIBRARY_PATH=/opt/mjpg-streamer/ /opt/mjpg-streamer/mjpg_streamer -i "input_libcamera.so -r 640x480 -fps 30" -o "output_http.so -p 9000 -w /opt/mjpg-streamer/www" > /dev/null 2>&1&