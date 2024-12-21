
const aa = document.querySelectorAll(".hello");

function mouseEnterFunc(event) {
	event.target.style.color = "#"+(parseInt(Math.random()*0xffffff)).toString(16);
	event.target.style.fontSize = "300%";
	event.target.innerText = "Hello Mouse!";
}
function mouseLeaveFunc(event) {
	event.target.style.color = "#"+(parseInt(Math.random()*0xffffff)).toString(16);
	event.target.style.fontSize = "200%";
	event.target.innerText = "@@@@@@@@@@@";
}

aa.forEach((a) => {
	a.addEventListener("mouseenter", mouseEnterFunc);
	a.addEventListener("mouseleave", mouseLeaveFunc);
})

