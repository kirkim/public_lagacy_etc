"use strict";

const Btn = document.querySelector(".gameBtn");
const playBtn = document.querySelector("#playBtn");
const timer = document.querySelector(".timer");
const mg = document.querySelector(".message");
const popUp = document.querySelector(".popup");
const popBtn = document.querySelector(".popBtn");
const GD = document.querySelector(".ground");
const countCarrot = document.querySelector(".count");

/* audio */
const audioAlert = new Audio('./sound/alert.wav');
const audioCarrot = new Audio('./sound/carrot_pull.mp3');
const audioBg = new Audio('./sound/bg.mp3');
const audioBug = new Audio('./sound/bug_pull.mp3');
const audioWin = new Audio('./sound/game_win.mp3');

let started = false;
let intervalTool;
let score;
const TIME = 10;
const COUNT = 2;
const HIDDEN_CLASS = "hidden";
const CARROT_CLASS = "carrot";
const BUG_CLASS = "bug";
const WIDTH_MAX = 841;
const HEIGHT_MAX = 171;



function failGame() {
	audioAlert.play();
	audioBg.load();
	clearInterval(intervalTool);
	mg.textContent = "Replay❓";
	Btn.classList.add(HIDDEN_CLASS);
	popUp.classList.remove(HIDDEN_CLASS);
	GD.removeEventListener("click", findItem);
}

function successGame() {
	audioWin.play();
	clearInterval(intervalTool);
	mg.textContent = "YOUWON🌈";
	Btn.classList.add(HIDDEN_CLASS);
	popUp.classList.remove(HIDDEN_CLASS);
	GD.removeEventListener("click", findItem);
}

function makeItems(item, count) {
	let cnt = count;
	let carrot;
	while (cnt-- > 0) {
		const w = Math.floor(Math.random()*WIDTH_MAX);
		const h = Math.floor(Math.random()*HEIGHT_MAX);
		carrot = document.createElement("div");
		carrot.setAttribute('class', item);
		carrot.style.transform = `translate(${w}px, ${h}px)`;
		GD.appendChild(carrot);
	}
}

function setTimer(time) {
	if (time === 0) {
		failGame();
		clearInterval(intervalTool);
	}
	const minutes = String(Math.floor(time / 60)).padStart(2, "0");
	const seconds = String(Math.floor(time % 60)).padStart(2, "0");
	timer.innerHTML = `${minutes}:${seconds}`;
}

function handleBtn() {
	playBtn.classList.toggle(`play`);
	playBtn.classList.toggle(`stop`);

	if (playBtn.classList.contains('play')) {
		audioBg.pause();
		clearInterval(intervalTool);
	} else {
		let time = TIME;
		score = COUNT;
		countCarrot.textContent = score;
		GD.addEventListener("click", findItem);
		audioBg.play();
		while (GD.hasChildNodes()) {
			GD.removeChild(GD.firstChild);
		}
		popUp.classList.add(HIDDEN_CLASS);
		setTimer(time);
		intervalTool = setInterval(() => {
			time--;
			setTimer(time);
		}, 1000);
		makeItems(CARROT_CLASS, COUNT);
		makeItems(BUG_CLASS, COUNT);
	}
}

function findCarrot(event) {
	event.target.remove();
	ct--;
	countCarrot.textContent = ct;
	if (ct === 0) {
		successGame();
	}
}

function findItem(event) {
	if (event.target.className === "carrot") {
		audioCarrot.play();
		findCarrot(event);
	} else if (event.target.className === "bug") {
		audioBug.play();
		failGame();
	}
}

Btn.addEventListener("click", handleBtn);
popBtn.addEventListener("click", (event) => {
	Btn.classList.remove(HIDDEN_CLASS);
	playBtn.classList.toggle(`play`);
	playBtn.classList.toggle(`stop`);
	handleBtn(event);
});
