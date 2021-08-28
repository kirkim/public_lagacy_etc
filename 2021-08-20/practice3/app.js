function func1() {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			resolve(`apple`)
		}, 1000);
	});
}
function func2(a) {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			resolve(`${a} + banana`)
		}, 1000);
	});
}
function func3(a) {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			resolve(`${a} + strawberry`)
		}, 1000);
	});
}
function func4(a, b) {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			resolve(`${a}${b}`)
		}, 1000);
	});
}

function usePromiseChain() {
	let a;
	let b;
	func1()
	.then((s1) => {
		func2(s1).then((s2) => a = s2).then(() => {
			func3(s1).then((s3) => b = s3)
			.then(() => {
				func4(a, b).then(console.log);
			})
		})

	});
}

usePromiseChain();
