const loginForm = document.querySelector("#loginTool");
const idForm = document.querySelector("#id");
const pwForm = document.querySelector("#pw");
const loginBtn = document.querySelector("#login");
const dataBtn = document.querySelector("#data");
const dataOut = document.querySelector("#out");
const main = document.querySelector(".mainSite");
let data;

function login(id, password) {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			if (id === "kirkim" && password === "111") {
				resolve(`<사용자 정보>\n아이디: ${id}\n이름: kirkim\n국적: 대한민국`);
				dataBtn.classList.remove("hidden");
			} else {
				reject(new Error(`login fail!`));
			}
		}, 2000);
	});
}

function loginFunc() {
	data = login(idForm.value, pwForm.value);
	idForm.value = "";
	pwForm.value = "";
	loginForm.classList.add("hidden");
	main.classList.remove("hidden");
}
function layOutData() {
	data.then((data) => {
		dataOut.innerText = data;
	})
}

loginBtn.addEventListener("click", loginFunc);
dataBtn.addEventListener("click", layOutData);
