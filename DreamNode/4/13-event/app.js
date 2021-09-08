// EventEmitter를 이용하여 원하는 이베느 만들 수 있음
// emit 을 이용하여 만들어준 이벤트 실행가능

// /* 1 */
// const EventEmitter = require('events');
// const emitter = new EventEmitter();

// emitter.on('ellie', (args) => {
// 	console.log('first callback - ', args);
// });

// emitter.on('ellie', (args) => {
// 	console.log('second callback - ', args);
// });

// emitter.emit('ellie', { message: 1 });
// emitter.emit('ellie', { message: 2 });
// emitter.emit('ellie', { message: 3 });

/* 2 */
const EventEmitter = require('events');
const emitter = new EventEmitter();
const callback1 = (args) => {
	console.log('first callback - ', args);
}
emitter.on('ellie', callback1);

emitter.on('ellie', (args) => {
	console.log('second callback - ', args);
});

emitter.emit('ellie', { message: 1 });
emitter.emit('ellie', { message: 2 });
emitter.removeListener('ellie', callback1); // 인자로 아무것도 안넣어주면 모든 이벤트를 없앰
emitter.emit('ellie', { message: 3 });
