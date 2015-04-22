var http = require('http');
var fs = require('fs');

function guid() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
    s4() + '-' + s4() + s4() + s4();
}

http.createServer(function(request, response) {
  var tempGuid = guid(),
      destinationFile = fs.createWriteStream(tempGuid + '.png');
  request.pipe(destinationFile);
  response.writeHead(
    204,
    {
      'Content-Type': 'text/plain',
      'Location': tempGuid
    }
  );
  response.end();
}).listen(8000);
