let count = 0;

function increase() {
	count++;
}

function getCount() {
	return count;
}

module.exports.getCount = getCount;
module.exports.increase = increase;
//exports.increase = increase;
console.log(module.exports === exports);
exports = {};
console.log(module.exports === exports); // module.exports와 exports는 같은거 같으면서도 다르다
console.log(module);
