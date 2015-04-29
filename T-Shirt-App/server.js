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

fs.mkdir('incoming', function() {});
fs.mkdir('outgoing', function() {});

http.createServer(function(request, response) {
  if (request.method === 'POST') {
    var tempGuid = guid(),
        destinationFile = fs.createWriteStream('incoming/' + tempGuid + '.png');
    console.log('REQUEST[POST]');
    request.pipe(destinationFile);
    console.log('REQUEST[POST] - Created job ' + tempGuid);
    response.writeHead(
      204,
      {
        'Content-Type': 'text/plain',
        'Location': tempGuid
      }
    );
    response.end();
  } else if (request.method === 'GET') {
    console.log('REQUEST[GET] : ' + request.url);
    var guidPath = url.parse(request.url).pathname,
        guidSegment = path.normalize(guidPath).split('/')[1],
        imagePath = 'outgoing/' + guidSegment + '.png';
    fs.stat(imagePath, function(err, stats) {
      if (err) {
        console.log('REQUEST[GET]  - No such job ' + guidSegment + ' [' + imagePath+ ']');
        response.writeHead(404);
        response.end();
      } else {
        console.log('REQUEST[GET]  - Sending job result ' + guidSegment);
        response.writeHead(
          200,
          {
            'Content-Type': 'image/png',
            'Content-Length': stats.size
          }
        );
        fs.createReadStream(imagePath).pipe(response);
      }
    });
    
  }
}).listen(8000);

console.log('Server started')
