import asyncio
import subprocess
import numpy as np
from av import VideoFrame
from aiortc import RTCPeerConnection, RTCSessionDescription, MediaStreamTrack
from aiohttp import web

class CameraStreamTrack(MediaStreamTrack):
    kind = "video"

    def __init__(self):
        super().__init__()
        self.width = 640
        self.height = 480
        self.proc = subprocess.Popen(
            [
                "libcamera-vid",
                "-t", "0",
                "--width", str(self.width),
                "--height", str(self.height),
                "--framerate", "30",
                "--codec", "yuv420",
                "-o", "-"
            ],
            stdout=subprocess.PIPE
        )

    async def recv(self):
        pts, time_base = await self.next_timestamp()
        frame_size = self.width * self.height * 3 // 2  # YUV420p

        loop = asyncio.get_event_loop()
        raw = await loop.run_in_executor(None, self.proc.stdout.read, frame_size)

        if not raw:
            raise ConnectionError("Camera stream ended")

        yuv = np.frombuffer(raw, np.uint8).reshape((self.height * 3 // 2, self.width))
        bgr = cv2.cvtColor(yuv, cv2.COLOR_YUV2BGR_I420)

        frame = VideoFrame.from_ndarray(bgr, format="bgr24")
        frame.pts = pts
        frame.time_base = time_base
        return frame

async def index(request):
    html = open("index.html", "r").read()
    return web.Response(content_type="text/html", text=html)

async def offer(request):
    params = await request.json()
    offer = RTCSessionDescription(sdp=params["sdp"], type=params["type"])

    pc = RTCPeerConnection()
    pc.addTrack(CameraStreamTrack())

    await pc.setRemoteDescription(offer)
    answer = await pc.createAnswer()
    await pc.setLocalDescription(answer)

    return web.json_response(
        {"sdp": pc.localDescription.sdp, "type": pc.localDescription.type}
    )

app = web.Application()
app.router.add_get("/", index)
app.router.add_post("/offer", offer)

web.run_app(app, port=8080)
