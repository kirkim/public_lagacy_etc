const inputR = document.querySelector(".inputRange");
const inputY = document.querySelector(".inputChose");
const gameForm = document.querySelector(".form");
const yc = document.querySelector(".youchose");
const mc = document.querySelector(".machinechose");
const rs = document.querySelector(".result");
const ot = document.querySelector(".out");

function printResult() {
	if(yc.textContent === mc.textContent) {
		rs.textContent = "You won!";
	} else {
		rs.textContent = "You lost!";
	}
}

function checkValue() {
	if (inputR.value === "") {
		ot.classList.add("hidden");
		inputR.focus();
		alert("Please enter the max number!");
		return (-1);
	} else if (inputY.value === "") {
		ot.classList.add("hidden");
		inputY.focus();
		alert("Please enter the guess number!");
		return (-1);
	} else if (inputR.value < inputY.value) {
		ot.classList.add("hidden");
		inputY.value = "";
		inputY.focus();
		alert("Please guess a number in a range!");
		return (-1);
	}
	return (0);
}

function printChose() {
	const r = Number(inputR.value);
	const y = Number(inputY.value);
	const max = Math.floor(r) + 1;
	yc.textContent = y;
	mc.textContent = Math.floor(Math.random() * max);
}

gameForm.addEventListener("submit", (event) => {
	event.preventDefault();
	if (checkValue() === -1)
		return ;
	printChose();
	printResult();
	ot.classList.remove("hidden");
})
