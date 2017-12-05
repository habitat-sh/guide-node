const http = require('http');
const fs = require('fs');

const cfg = JSON.parse(fs.readFileSync(process.env.APP_CONFIG || './config-default.json', 'utf8'));

const host = cfg.srv.host;
const port = cfg.srv.port;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end(`Hello World! I am running at ${host} on port ${port}\n`);
});

server.listen(port, host, () => {
  console.log(`Server running at http://${host}:${port}/`);
});