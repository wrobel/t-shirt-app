var http = require('http');
var fs = require('fs');
var url = require('url');
var path = require('path');

function guid() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
    s4() + '-' + s4() + s4() + s4();
}

fs.mkdir('incoming');
fs.mkdir('outgoing');

http.createServer(function(request, response) {
  if (request.method === 'POST') {
    var tempGuid = guid(),
        destinationFile = fs.createWriteStream('incoming/' + tempGuid + '.png');
    request.pipe(destinationFile);
    response.writeHead(
      204,
      {
        'Content-Type': 'text/plain',
        'Location': tempGuid
      }
    );
    response.end();
  } else if (request.method === 'get') {
    var guidPath = url.parse(request.url).pathname,
        guid = path.normalize(guidPath).split('/')[0],
        imagePath = 'outgoing/' + guid + '.png';
    fs.stat(imagePath, 'r', function(err, stats) {
      if (err) {
        response.writeHead(404);
        response.end();
      } else {
        response.writeHead(
          200,
          {
            'Content-Type': 'image/png',
            'Content-Length': stats.size
          }
        );
        fs.createReadStream(imagePath).pipe(response);
        response.end();
      }
    });
    
  }
}).listen(8000);
