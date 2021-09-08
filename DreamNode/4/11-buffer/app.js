// Fixed-size chuck of memory
// array of integers, byte of data

const buf = Buffer.from('Hi');
console.log(buf);  // 유니코드 형태로 출력
console.log(buf.length);
console.log(buf[0]);  // 배열형태로 뽑으면 아스키코드가 출력
console.log(buf[1]);
console.log(buf.toString('utf-8'));  // 기본은 utf-8

// create
const buf2 = Buffer.alloc(2); // 초기화 시켜주고 메모리 할당
const buf3 = Buffer.allocUnsafe(2);  // fast, 초기화를 시켜주지않음
console.log(buf2); // 00 00
console.log(buf3); // 쓰래기값 있을 수 있음

// create2
const buf4 = Buffer.alloc(2);
const buf5 = Buffer.allocUnsafe(2);
buf4[0] = 72
buf4[1] = 105;
buf4.copy(buf5);
console.log(buf4.toString());
console.log(buf5.toString());

// concat
const newBuf = Buffer.concat([buf, buf4, buf5]);
console.log(newBuf.toString());
