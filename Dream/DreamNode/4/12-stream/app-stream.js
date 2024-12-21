/* 스트림은 조금조금씩 데이터를 읽어옴 */

const { on } = require('events');
const fs = require('fs');

// /* exmple1 */
// const readStream = fs.createReadStream('./file.txt', {  // createTeadStream 는 이벤트기반이라 종류가 많다 눌러서확인!
// 	highWaterMark: 8, // 기본 64 kbtyes
// 	encoding: 'utf-8',
// });

// readStream.on('data', (chunk) => {
// 	// console.log(chunk);
// 	console.count('data');
// });

// readStream.on('error', (error) => {
// 	console.log(error);
// });

// /* exampe2 */
// const readStream = fs.createReadStream('./file.txt', {
// 	//highWaterMark: 8, // 기본 64 kbtyes
// 	//encoding: 'utf-8',
// });

// const data = [];
// readStream.on('data', (chunk) => {
// 	// console.log(chunk);
// 	data.push(chunk);
// 	console.count('data');
// });

// readStream.on('end', () => {
// 	console.log(data.join(''));
// })
// readStream.on('error', (error) => {
// 	console.log(error);
// });

/* exmple 3 */ //on()은 자기자신을 반환하므로 chaining이 가능
const data = [];
const readStream = fs.createReadStream('./file.txt', {
	//highWaterMark: 8, // 기본 64 kbtyes
	//encoding: 'utf-8',
}).on('data', (chunk) => {
	// console.log(chunk);
	data.push(chunk);
	console.count('data');
}).on('end', () => {
	console.log(data.join(''));
}).on('error', (error) => {
	console.log(error);
});


/// on 말고 once를 쓰면 데이터를 딱한번만 받아옴

