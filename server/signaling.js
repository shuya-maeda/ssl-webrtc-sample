var WebSocket = require('ws');
var fs = require('fs');
var https = require('https');
var express = require('express');
var app = express();

var  _certfile = '/root/server/server_cert.pem'; // Edit this line
var  _keyfile = '/root/server/server_nopass.pem'; // Edit this line
let port = 3001;

var key = fs.readFileSync(_keyfile);
var cert = fs.readFileSync(_certfile);

var options = {
  key: key,
  cert: cert,
};

var server = https.createServer(options, app);
var wss_secure = new WebSocket.Server({server:server});
wss_secure.on('connection', function(ws) {
  console.log('-- websocket connected --');
  ws.on('message', function(message) {
   wss_secure.clients.forEach(function each(client) {
      if (isSame(ws, client)) {
        console.log('- skip sender -');
      }
      else {
        client.send(message);
      }
    });
  });
});

function isSame(ws1, ws2) {
  // -- compare object --
  return (ws1 === ws2);     

  // -- compare undocumented id --
  //return (ws1._ultron.id === ws2._ultron.id);
}

server.listen(port)
