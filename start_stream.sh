# LD_LIBRARY_PATH=/opt/mjpg-streamer/ /opt/mjpg-streamer/mjpg_streamer -i "input_raspicam.so -vf -hf -fps 15 -q 50 -x 640 -y 480" -o "output_http.so -p 9000 -w /opt/mjpg-streamer/www" > /dev/null 2>&1&
# rpicam-vid -t 0 --inline --listen -o tcp://127.0.0.1:9000
# rpicam-vid -t 0 -o - | nc -l -p 9000
LD_LIBRARY_PATH=/opt/mjpg-streamer/ /opt/mjpg-streamer/mjpg_streamer -i "input_uvc.so -d /dev/video0 -r 640x480 -f 30" -o "output_http.so -p 9000 -w /opt/mjpg-streamer/www" > /dev/null 2>&1&