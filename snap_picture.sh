#!/bin/bash

/usr/bin/killall mjpg_streamer

/usr/bin/rpicam-jpeg -n -t 50 -o $1

# Temp file to capture logs
LOGFILE=$(mktemp)

# Start mjpg-streamer in background and redirect output
LD_LIBRARY_PATH=/opt/mjpg-streamer/ /opt/mjpg-streamer/mjpg_streamer -i "input_libcamera.so -r 640x480 -fps 30" -o "output_http.so -p 9000 -w /opt/mjpg-streamer/www" > /dev/null 2>&1&
MJPG_PID=$!

# Wait for a known "ready" message
echo "Waiting for MJPG Streamer (PID $MJPG_PID) to be ready..."
until grep -q "HTTP TCP port" "$LOGFILE"; do
    if ! kill -0 $MJPG_PID 2>/dev/null; then
        echo "MJPG-Streamer exited prematurely."
        cat "$LOGFILE"
        exit 1
    fi
    sleep 0.1
done

echo "MJPG-Streamer is ready!"