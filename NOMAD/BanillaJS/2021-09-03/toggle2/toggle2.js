const toggle = document.querySelector("#switch");


function ss(event) {
	console.log(event.target.checked);
}

toggle.addEventListener("click", ss);
