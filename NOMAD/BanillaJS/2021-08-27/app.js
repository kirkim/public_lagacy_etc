const body = document.querySelector("body");
const colors = ["red", "blue", "purple", "orange", "skyblue"];
const INTERVAL = 60;
const BASE_WIDTH = INTERVAL * 5;


function handleWindowColor() {
	const widthValue = window.innerWidth % BASE_WIDTH;

	if (widthValue < INTERVAL) {
		body.style.backgroundColor = colors[0];
	} else if (widthValue < 2 * INTERVAL) {
		body.style.backgroundColor = colors[1];
	} else if (widthValue < 3 * INTERVAL) {
		body.style.backgroundColor = colors[2];
	} else if (widthValue < 4 * INTERVAL) {
		body.style.backgroundColor = colors[3];
	} else {
		body.style.backgroundColor = colors[4];
	}
}

window.addEventListener("resize", handleWindowColor);


/*
const body = document.querySelector("body");
const INTERVAL = 300;
const BASE_WIDTH = INTERVAL * 5;

function removeClass() {
  body.classList.remove("w1");
  body.classList.remove("w2");
  body.classList.remove("w3");
  body.classList.remove("w4");
  body.classList.remove("w5");
}

function handleWindowColor() {
  const widthValue = window.innerWidth % BASE_WIDTH;

  if (widthValue < INTERVAL) {
    if (body.classList.contains("w1")) return;
    removeClass();
    body.classList.add("w1");
  } else if (widthValue < 2 * INTERVAL) {
    if (body.classList.contains("w2")) return;
    removeClass();
    body.classList.add("w2");
  } else if (widthValue < 3 * INTERVAL) {
    if (body.classList.contains("w3")) return;
    removeClass();
    body.classList.add("w3");
  } else if (widthValue < 4 * INTERVAL) {
    if (body.classList.contains("w4")) return;
    removeClass();
    body.classList.add("w4");
  } else {
    if (body.classList.contains("w5")) return;
    removeClass();
    body.classList.add("w5");
  }
}

window.addEventListener("resize", handleWindowColor);
*/
