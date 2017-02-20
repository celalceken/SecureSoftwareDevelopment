/*
 * This project uses the codes given in http://www.gianlucaguarini.com/blog/nodejs-and-a-simple-push-notification-server/
 *
 *
 */

var http = require('http');
var parser = new require('xml2json');
var fs = require('fs');


var server = http.createServer(function(req, res) {}).listen(8000);


console.log('8000 portu dinleniyor...');

var io = require('socket.io').listen(server);

// creating a new websocket to keep the content updated without any AJAX request
io.sockets.on('connection', function(socket) {
  console.log(__dirname);
  // watching the xml file
  fs.watchFile(__dirname + '/Duyurular.xml', function(curr, prev) {
    // on file change we can read the new xml
    fs.readFile(__dirname + '/Duyurular.xml', function(err, data) {
      if (err) throw err;
      // parsing the new xml data and converting them into json file
      var json = parser.toJson(data);
      // send the new data to the client
      socket.emit('notification', json);
    });
  });


  //Mesajlaşma işlemi için
  socket.on('mesaj', function(msg)
  {
    io.emit('mesaj', msg);
  });


});