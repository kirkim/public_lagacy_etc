// const { nextTick } = require('process');

// console.log('code1');
// setTimeout(() => {
// 	console.log('setTimeout 0');
// }, 0);

// console.log('code2');
// setImmediate(() => {             // setTimeout과 큰 차이가 없다
// 	console.log('setImmediate');
// });

// console.log('code3');
// process.nextTick(() => {
// 	console.log('process.nextTick');
// })

console.log('code1');
console.time('timeout 0');
setTimeout(() => {
	console.timeEnd('timeout 0');
	console.log('setTimeout 0');
}, 0);
