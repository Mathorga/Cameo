var app = require("express")();
var http = require("http").Server(app);
var io = require("socket.io")(http);
var exec = require("child_process").exec, child;
var port = process.env.PORT || 3000;
// var ads1x15 = require("node-ads1x15");
// var adc = new ads1x15(1); // set to 0 for ads1015

// var Gpio = require("pigpio").Gpio,
//   A1 = new G pio(27, {mode: Gpio.OUTPUT}),
//   A2 = new Gpio(17, {mode: Gpio.OUTPUT}),
//   B1 = new Gpio( 4, {mode: Gpio.OUTPUT}),
//   B2 = new Gpio(18, {mode: Gpio.OUTPUT});
//   LED = new Gpio(22, {mode: Gpio.OUTPUT});

app.get(
  "/",
  function (req, res) {
    res.sendFile(__dirname + "/cameo_client.html");
    console.log("HTML sent to client");
  }
);

//Whenever someone connects this gets executed
io.on(
  "connection",
  function (socket) {
    console.log("A user connected");

    socket.on(
      "cam",
      function (toggle) {
        var numPics = 0;
        console.log("Taking a picture..");
        //Count jpg files in directory to prevent overwriting
        child = exec("/usr/bin/find ~/Cameo/ -type f -name \"*.jpg\" | wc -l", function (error, stdout, stderr) {
          numPics = parseInt(stdout) + 1;
          // Turn off streamer, take photo, restart streamer
          const command = "/usr/bin/killall mjpg_streamer ; /usr/bin/rpicam-jpeg -n -t 50 -o ~/Cameo/cam" + numPics + ".jpg -n ; sudo bash ~/Cameo/start_stream.sh";
          child = exec(command, function (error, stdout, stderr) {
            console.log("Picture taken: cam" + numPics + ".jpg");
            io.emit("cam", 1);
          });
        });
      }
    );

    socket.on(
      "power",
      function (toggle) {
        child = exec("sudo poweroff");
      }
    );

    //Whenever someone disconnects this piece of code is executed
    socket.on(
      "disconnect",
      function () {
        console.log("A user disconnected");
      }
    );

    setInterval(
      function () { // send temperature every 5 sec
        child = exec(
          "cat /sys/class/thermal/thermal_zone0/temp",
          function (error, stdout, stderr) {
            if (error !== null) {
              console.log("exec error: " + error);
            } else {
              var temp = parseFloat(stdout) / 1000;
              io.emit("temp", temp);
              console.log("temp", temp);
            }
          }
        );
      },
      5000
    );
  }
);

http.listen(
  port,
  function () {
    console.log("listening on *:" + port);
  }
);
