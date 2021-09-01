const Btn = document.querySelector(".gameBtn");
const playBtn = document.querySelector("#playBtn");
const timer = document.querySelector(".timer");
const mg = document.querySelector(".message");
const popUp = document.querySelector(".popup");
const popBtn = document.querySelector(".popBtn");

let intervalTool;
const TIME = 2;
const COUNT = 10;
const HIDDEN_CLASS = "hidden";

function failGame() {
	mg.textContent = "Replay❓";
	Btn.classList.add(HIDDEN_CLASS);
	popUp.classList.remove(HIDDEN_CLASS);
}

function handleBtn() {
	playBtn.classList.toggle(`play`);
	playBtn.classList.toggle(`stop`);

	if (playBtn.classList.contains('play')) {
		clearInterval(intervalTool);
		timer.textContent = "00:00";
		//Todo
		//exitGame();
	} else {
		let time = TIME;
		popUp.classList.add(HIDDEN_CLASS);
		intervalTool = setInterval(() => {
			if (time === 0) {
				failGame();
				clearInterval(intervalTool);
				//Todo

			}
			const minutes = String(Math.floor(time / 60)).padStart(2, "0");
			const seconds = String(Math.floor(time % 60)).padStart(2, "0");
			timer.innerHTML = `${minutes}:${seconds}`;
			time--;
		}, 1000);
	}
}

Btn.addEventListener("click", handleBtn);
popBtn.addEventListener("click", (event) => {
	Btn.classList.remove(HIDDEN_CLASS);
	playBtn.classList.toggle(`play`);
	playBtn.classList.toggle(`stop`);
	handleBtn(event);
});
