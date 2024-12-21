const specialBox = document.querySelector(".specialBox");
const button1 = document.querySelector("#b1");
const button2 = document.querySelector("#b2");
const button3 = document.querySelector("#b3");

function goBy100() {
	window.scrollBy(0, 100);
}

function goTo100() {
	window.scrollTo(0, 100);
}

function goToSpecial() {
	specialBox.scrollIntoView(true);
}

button1.addEventListener("click", goBy100);
button2.addEventListener("click", goTo100);
button3.addEventListener("click", goToSpecial);
