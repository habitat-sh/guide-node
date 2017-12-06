const http = require('http');
const fs = require('fs');

const cfg = JSON.parse(fs.readFileSync(process.env.APP_CONFIG || '../config/config.json', 'utf8'));

const message = cfg.message;
const port = cfg.port;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end(`Hello World! ${message}!  It's running on port ${port}\n`);
});

server.listen(port, function() {
  console.log(`Server running at http://0.0.0.0:%d`, port);
});