// async & await
// clear style of using promise :)

// 1. async

/*
//(1)동기적 방법 (데이터를 받을때까지 기다림... 느림)
function fetchUser() {
	// do network reqeust in 10 secs....
	return 'ellie';
}
*/

/*
//(2)비동기적 방법 promise(then을 써주면 결과값을 줄 것을 약속)
function fetchUser() {
	return new Promise((resolve, reject) => {
		//do network reqeust in 10 secs....
		resolve('ellie');
	})
}
*/

//(3)async
async function fetchUser() {
	//do network reqeust in 10 secs....
	return ('ellie');
}


const user = fetchUser();
user.then(console.log);
console.log(user);


// 2. await ✨
// async가 붙은곳에서만 사용이 가능
function delay(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
}

async function getApple() {
	await delay(1000);
	return '🍎';
}

async function getBanana() {
	await delay(1000);
	return '🍌';
}
/*
//=== 위의 getBanana와 같은식 (비효율적, 체이닝을 쓸데없이하는 것보다
//	await()로 딜레이를 기다렸다 return하는게 깔끔)
function getBanana() {
	return delay(1000)
	.then(() => '🍌');
}
*/

/*
//pickFruits (1)
// 안좋은 케이스: 아래와 같이 체이닝을 너무 중첩적으로 주게되면 콜벡지옥과같은 현상이 발생
function pickFruits() {
	return getApple()
	.then(apple => {
		return getBanana()
		.then(banana => `${apple} + ${banana}`);
	});
}
*/

/*
//pickFruits (2)
// 아래에 apple과 banana는 서로 연관이 없는데 둘다 `await`를 사용하면 비효율적
async function pickFruits() {
	const apple = await getApple();
	const banana = await getBanana();
	return `${apple} + ${banana}`;
}*/

/*
//pickFruits (3)
// 아래와 같이 딜레이가 걸리는 getxxxx()함수들을 미리 선언하여 병렬적으로 수행하게 하면
// 더 빠르게 수행이가능
// 하지만 아래의 코드도 안좋은 코드
async function pickFruits() {
	const applePromise = getApple();
	const bananaPromise = getBanana();
	const apple = await applePromise;
	const banana = await bananaPromise;
	return `${apple} + ${banana}`;
}
*/

/*
//(1) ~ (3) 까지 아래 식 이용
pickFruits().then(console.log);
*/

/*
//pickFruits (4)
//Promise에 있는 all이라는 api를 사용하면 모든 promise들을 배열형식으로 처리가능(각각 병렬로 처리되는듯함)
function pickAllFruits() {
	return Promise.all([getApple(), getBanana()])
		.then(fruits => fruits.join(' + ')
	);
}
pickAllFruits().then(console.log);
*/

/*
//pickFruits (5)
//Promise에 있는 race라는 api를 사용하면 먼저 값을 리턴하는 것 하나만 값이 전달됨
function pickOnlyOne() {
	return Promise.race([getApple(), getBanana()]);
}
pickOnlyOne().then(console.log);
*/

/*
// 2-2. error가 발생할 경우 처리 (throw를 사용 임시)

function delay(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
}

async function getApple() {
	await delay(1000);
	throw `error`;
	return '🍎';
}

async function getBanana() {
	await delay(1000);
	return '🍌';
}

async function pickFruits() {
	try {
		const banana = await getBanana();
		const apple = await getApple();
	} catch() {

	}
	return `${apple} + ${banana}`;
}

pickFruits().then(console.log);
*/



// Homework
// callback-to-promise.js async를 이용하여 바꿔보기
