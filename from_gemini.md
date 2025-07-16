# Raspberry pi video stream
To stream video from a Raspberry Pi, you can use the libcamera-vid utility to capture video and send it over a network using TCP or UDP. You can then view the stream on another device using a media player like VLC. Alternatively, you can use a Python-based web framework like Flask to create a video streaming server accessible from a web browser. </br>

## 1. Using libcamera-vid and VLC:
Enable the camera: Ensure the Raspberry Pi camera module is enabled via sudo raspi-config. 
Install VLC: If VLC is not already installed on the Raspberry Pi, install it using sudo apt-get install vlc. 
Stream using libcamera-vid: Open a terminal and run the following command, replacing [port] with your desired port number and [IP_ADDRESS] with the Raspberry Pi's IP address: 

```
libcamera-vid -t 0 --inline --listen -o tcp://[IP_ADDRESS]:[port]
```
```-t 0``` streams indefinitely. </br>
```--inline``` enables inline headers for the stream. </br>
```--listen``` tells libcamera-vid to listen for connections. </br>
```-o tcp://[IP_ADDRESS]:[port]``` specifies the output stream as TCP with the given IP and port. </br>

View the stream: Open VLC on another device, go to Media > Open Network Stream, and enter the stream address (e.g., tcp://[IP_ADDRESS]:[port]).

## 2. Using Flask (Python):
Install Flask and PiCamera: If not already installed, install them using pip3 install flask picamera. 
Create a Flask app: Write a Python script using Flask to serve the video stream. 
Example Flask code:
```
    from flask import Flask, Response
    import time
    import picamera

    app = Flask(__name__)

    def generate_frames():
        with picamera.PiCamera() as camera:
            camera.resolution = (640, 480)
            camera.framerate = 24
            for frame in camera.capture_continuous(format="jpeg", use_video_port=True):
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
                time.sleep(1/24)

    @app.route('/video_feed')
    def video_feed():
        return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000, debug=True)
```

Run the Flask app: Execute the Python script to start the server. 
Access the stream: Open a web browser on another device and navigate to http://[IP_ADDRESS]:5000/video_feed (replace [IP_ADDRESS] with the Raspberry Pi's IP). 
3. Using mjpg_streamer:
Install mjpg_streamer: Compile and install mjpg_streamer from source.
Start the stream: Run mjpg_streamer with the appropriate input and output plugins, specifying the port for the stream. 