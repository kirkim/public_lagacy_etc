const abcResult = document.querySelector("#abc");

function makeString(count) {
	let result;

	while (count-- > 0) {
		const value = Math.ceil(Math.random() * 100);
		if (result === undefined) {
			result = `${value}`;
		} else {
			result = `${result} ${value}`;
		}
	}
	return result;
}

function printRandom(count) {
	if (count <= 0)
		return ;
	abcResult.innerText = makeString(count);
}

printRandom(10);
