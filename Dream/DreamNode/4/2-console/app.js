console.log('logging....');
console.clear();

// log level
console.log(1);  // 개발
console.info(2); // 정보
console.warn(3); // 경보
console.error(4); // 에러, 사용자 에러, 시스템 에러

// assert
console.assert(2 === 3, 'not same!');
console.assert(2 === 2, 'same!');

// print object
const student = { name: 'ellie', age: 20, company: { name: 'AC' } };
console.log(student);
console.table(student);
console.dir(student, { showHidden: true, colors: false, depth: 0});

// measuring time
console.time('for loop');
for (let i = 0; i < 10; i++) {
	i++;
}
console.timeEnd('for loop');

// counting // 얼마나 호출했는지 세줌
function a() {
	console.count('a function');
}
a();
a();
console.countReset(`a function`); // 카운터갯수 초기화 시켜줌
a();

// trace : 디버깅할 때 좋음(어디서 호출??)
function f1() {
	f2();
}
function f2() {
	f3();
}
function f3() {
	console.log('f3');
	console.trace();
}
f1();
