const http = require('http');
const fs = require('fs');

const server = http.createServer((req, res) => {
	const url = req.url;
	console.log(url);
	if (url === '/') {
		fs.createReadStream('./html/home.html').pipe(res);
	} else if (url === '/courses') {
		fs.createReadStream('./html/courses.html').pipe(res);
	} else {
		fs.createReadStream('./html/not-found.html').pipe(res);
	}
})

server.listen(8080);
