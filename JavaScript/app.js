/*
// 선언방법 1
const loginForm = document.getElementById("login-form");
const loginInput = loginForm.querySelector("input");
const loginButton = loginForm.querySelector("button");
*/

/*
// 선언방법 2
const loginInput = document.querySelector("#login-form input");
const loginButton = document.querySelector("#login-form button");

function onLoginBtnClick() {
	const username = loginInput.value;
	if (username === "") {
		alert("pleas write your name!");
	} else if (username.length > 15) {
		alert("your name is too long!");
	}
}

loginButton.addEventListener("click", onLoginBtnClick);
*/

const loginForm = document.querySelector("#login-form");
const loginInput = document.querySelector("#login-form input");

const link = document.querySelector("a");

function onLoginSubmit(event) {
	event.preventDefault();
	console.log(loginInput.value);
}

/* handleLinkClick({information about the event that just happened}) */
function handleLinkClick(event) {
	event.preventDefault();
	console.log(event);
}

loginForm.addEventListener("submit", onLoginSubmit);
link.addEventListener("click", handleLinkClick);
