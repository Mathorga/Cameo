from flask import Flask
from flask import Response
import subprocess
import cv2
import numpy as np

app = Flask(__name__)

def generate_mjpeg():
    # Connect to the rpicam-vid TCP stream
    ffmpeg = subprocess.Popen(
        [
            "ffmpeg",
            "-i", "tcp://127.0.0.1:9000",
            "-f", "image2pipe",
            "-pix_fmt", "bgr24",
            "-vcodec", "rawvideo",
            "-"
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL
    )

    width, height = 640, 480  # Set to match rpicam-vid output
    frame_size = width * height * 3

    while True:
        raw_frame = ffmpeg.stdout.read(frame_size)
        if not raw_frame:
            break

        frame = np.frombuffer(raw_frame, dtype=np.uint8).reshape((height, width, 3))
        ret, jpeg = cv2.imencode('.jpg', frame)
        if not ret:
            continue

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + jpeg.tobytes() + b'\r\n')

@app.route('/video_feed')
def video_feed():
    return Response(generate_mjpeg(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/')
def index():
    return '<img src="/video_feed" width="640" height="480">'
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, threaded=True)
