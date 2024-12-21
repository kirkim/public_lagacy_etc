const colors = [
	"#ef5777",
	"#575fcf",
	"#4bcffa",
	"#34e7e4",
	"#0be881",
	"#f53b57",
	"#3c40c6",
	"#0fbcf9",
	"#00d8d6",
	"#05c46b",
	"#ffc048",
	"#ffdd59",
	"#ff5e57",
	"#d2dae2",
	"#485460",
	"#ffa801",
	"#ffd32a",
	"#ff3f34"
  ];
const Btn = document.querySelector("body button");
const body = document.querySelector("body");
const COUNT = 4;

function setTwoDiffColor() {
	const num1 = Math.floor(Math.random() * COUNT);
	const num2 = (num1 + Math.ceil(Math.random() * (COUNT - 1))) % COUNT;
	const degree = Math.floor(Math.random() * 5) * 45;

	body.style.background = `linear-gradient(${degree}deg,${colors[num1]}, ${colors[num2]})`;
	console.log(degree, num1, num2);
}

Btn.addEventListener("click", setTwoDiffColor);
