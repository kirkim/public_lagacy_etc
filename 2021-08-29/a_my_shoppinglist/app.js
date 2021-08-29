const inputText = document.querySelector(".inputitem");
const Btn = document.querySelector(".submit");
const list = document.querySelector(".list ol");

function addItem() {
	if (inputText.value === "")
		return ;
	const newItem = document.createElement("li");
	newItem.setAttribute('class', `item`);
	const newBtn = document.createElement("span");
	newBtn.textContent = '🗑';
	newBtn.addEventListener("click", deleteItem);
	newItem.textContent = `${inputText.value}`;
	newItem.append(newBtn);
	list.appendChild(newItem);
	inputText.value = "";
}

function detectEnter(event) {
	if (event.keyCode == '13')
		addItem();
}

function deleteItem(event) {
	list.removeChild(event.target.parentNode);
}

Btn.addEventListener("click", addItem);
inputText.addEventListener("keypress", detectEnter);
