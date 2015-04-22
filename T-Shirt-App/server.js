var http = require('http');
var fs = require('fs');
http.createServer(function(request, response) {
  var destinationFile = fs.createWriteStream('image.png');
  request.pipe(destinationFile);
  response.writeHead(204, {'Content-Type': 'text/plain'});
  response.end();
}).listen(8000);
