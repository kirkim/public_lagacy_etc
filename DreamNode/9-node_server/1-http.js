const http = require('http');
// const http2 = require('http2'); // https

//console.log(http.STATUS_CODES);
//console.log(http.METHODS);

const server = http.createServer((req, res) => {
	console.log('incoming...');
	console.log(`------headers-----`);
	console.log(req.headers);
	console.log(`------httpVersion-----`);
	console.log(req.httpVersion);
	console.log(`------method-----`);
	console.log(req.method);
	console.log(`------url-----`);
	console.log(req.url);
	const url = req.url;
	if (url === '/') {
		res.setHeader('Content-Type', 'text/html');
		res.write('<html>');
		res.write('<head><title>Academy</title></head>');
		res.write('<body><h1>Welcome!</h1></body>');
		res.write('</html>');
	} else if (url === '/courses') {
		res.setHeader('Content-Type', 'text/html');
		res.write('<html>');
		res.write('<head><title>Academy</title></head>');
		res.write('<body><h1>Course</h1></body>');
		res.write('</html>');
	} else {
		res.setHeader('Content-Type', 'text/html');
		res.write('<html>');
		res.write('<head><title>Academy</title></head>');
		res.write('<body><h1>NotFound!</h1></body>');
		res.write('</html>');
	}
	res.end();
});

server.listen(8080);
