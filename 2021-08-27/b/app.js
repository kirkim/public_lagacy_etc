const specialBox = document.querySelector(".specialBox");


function printCoordinate(event) {
	const rect = specialBox.getBoundingClientRect();
	console.log(`top: ${rect.top} bottom: ${rect.bottom}`);
	console.log(`left: ${rect.left} right: ${rect.right}`);
	console.log(`width: ${rect.width} height: ${rect.height}`);
	console.log(`x: ${rect.x} y: ${rect.y}`);
	console.log(`pageX: ${event.pageX} pageY: ${event.pageY}`);
	console.log(`\n`);
}

specialBox.addEventListener("click", printCoordinate)
