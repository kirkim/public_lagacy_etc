const inputText = document.querySelector(".inputitem");
const Btn = document.querySelector(".submit");
const list = document.querySelector(".list ol");
const mainList = document.querySelector(".list");

function addItem() {
	if (inputText.value === "") {
		inputText.focus();
		return ;
	}
	const newItem = document.createElement("li");
	const newBox = document.createElement("div");
	newBox.textContent = `${inputText.value}`;
	newBox.setAttribute('class', 'item');
	const newBtn = document.createElement("span");
	newBtn.textContent = '🗑';
	newBtn.addEventListener("click", deleteItem);
	newBox.appendChild(newBtn);
	const devider = document.createElement("div");
	devider.setAttribute('class', 'item__devider');
	newItem.append(newBox, devider);
	list.appendChild(newItem);
	newItem.scrollIntoView({bloack: 'center'});
	inputText.value = "";
	inputText.focus();

}

function detectEnter(event) {
	if (event.keyCode == '13')
		addItem();
}

function deleteItem(event) {
	list.removeChild(event.target.parentNode.parentNode);
}

Btn.addEventListener("click", addItem);
inputText.addEventListener("keypress", detectEnter);
