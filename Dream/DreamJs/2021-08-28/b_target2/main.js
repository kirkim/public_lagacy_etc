const hor = document.querySelector(".horizon");
const ver = document.querySelector(".vertical");
const img = document.querySelector(".targetImg");
const tag = document.querySelector(".tag");

function handlePosition(event) {
	const x = event.pageX;
	const y = event.pageY;
	ver.style.left = `${x}px`;
	hor.style.top = `${y}px`;
	img.style.left = `${x}px`;
	img.style.top = `${y}px`;
	tag.style.left = `${x}px`;
	tag.style.top = `${y}px`;
	tag.innerText = `${x}px, ${y}px`;
}


document.addEventListener("mousemove", handlePosition);
