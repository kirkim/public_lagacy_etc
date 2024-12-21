// /* pipe 기본사용 */
// const fs = require('fs');

// const readStream = fs.createReadStream('./file.txt');
// const writeStream = fs.createWriteStream('./file4txt');
// const piping = readStream.pipe(writeStream);
// piping.on('finish', () => {
// 	console.log('done!!');
// })


// /* 노드만의 압축사용 */
// const fs = require('fs');
// const zlib = require('zlib');

// const readStream = fs.createReadStream('./file.txt');
// const zlibStream = zlib.createGzip();
// const writeStream = fs.createWriteStream('./file4.zip');
// const piping = readStream.pipe(zlibStream).pipe(writeStream);
// piping.on('finish', () => {
// 	console.log('done!!');
// })


// pipe는 나중에 서버를 만들때도 사용
// //💩
// const fs = require('fs');

// const http = require('http');
// const server = http.createServer((req, res) => {
// 	fs.readFile('file.txt', (err, data) => {
// 		res.end(data);
// 	});
// });
// server.listen(3000); // localhost:3000으로 접속가능


//✨
const fs = require('fs');

const http = require('http');
const server = http.createServer((req, res) => {
	const stream = fs.createReadStream('./file.txt'); // 파일을 다읽고 보내는 것보다 stream이용하는게 좋음
	stream.pipe(res);
});
server.listen(3000); // localhost:3000으로 접속가능
