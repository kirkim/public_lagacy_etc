const page = document.querySelector("body");
const aa = document.querySelector(".a");
const bb = document.querySelector(".b");
const targetPoint = document.querySelector(".targetImg");

function detectPoint(event) {
	const mouseX = event.pageX;
	const mouseY = event.pageY;
	aa.style.width = mouseX + "px";
	aa.style.height = mouseY + "px";
	bb.style.left = mouseX + "px";
	bb.style.top = mouseY + "px";
	bb.style.width = document.documentElement.clientWidth - mouseX + "px";
	bb.style.height = document.documentElement.clientHeight - mouseY + "px";
	bb.innerHTML = `${mouseX}px, ${mouseY}px`
	targetPoint.style.left = mouseX - targetPoint.width/2 + "px";
	targetPoint.style.top = mouseY - targetPoint.height/2 + "px";
}

page.addEventListener("mousemove", detectPoint);
