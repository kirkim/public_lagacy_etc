
function sleep(ms) {
	return new Promise((resolve, reject) => {
		setTimeout(resolve, ms)});
}

async function func1() {
	await sleep(1000);
	return (`1`);
}
async function func2(a) {
	await sleep(1000);
	return (`2`)

}
async function func3() {
	await sleep(1000);
	return (`3`);
}
async function func4() {
	await sleep(1000);
	return (`4`);
}

async function usePromiseChain() {
	const a1 = func1();
	const a2 = func2();
	const a3 = func3();
	const a4 = func4();

	const c1 = await a1;
	const c2 = await a2;
	const c3 = await a3;
	const c4 = await a4;
	console.log(c1, c2, c3, c4);
}

usePromiseChain();
