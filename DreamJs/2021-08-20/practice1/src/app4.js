
function promisFunc(num) {
	return new Promise ((resolve, reject) => {
		setTimeout(() => {
			num--;
			if (num > 3) {
				resolve(num);
			} else {
				reject(new Error(`num isn't over 3`));
			}
		}, 1000);
	})
}

promisFunc(6)
.then(promisFunc)
.then(console.log)
.catch;

/*
function callbackFunc(num, success, fail) {
	setTimeout(() => {
		num--;
		if (num > 3) {
			success(num);
		} else {
			fail(new Error(`num isn't over 3`));
		}
	}, 1000);
}

callbackFunc(
	6,
	(num) => callbackFunc(
		num,
		(num2) => console.log(`${num2} is over 3`),
		(error) => console.log(error)
		),
	(error) => console.log(error)
);
*/
