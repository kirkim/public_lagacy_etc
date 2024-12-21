const inputText = document.querySelector(".inputitem");
const Btn = document.querySelector(".submit");
const list = document.querySelector(".list ol");

function createItem(text) {
	const newItem = document.createElement("li");
	const newBox = document.createElement("div");
	newBox.textContent = `${text}`;
	newBox.setAttribute('class', 'item');

	const newBtn = document.createElement("span");
	newBtn.textContent = '🗑';
	newBtn.setAttribute('class', 'delete');
	//newBtn.addEventListener("click", deleteItem);

	const devider = document.createElement("div");
	devider.setAttribute('class', 'item__devider');

	newBox.appendChild(newBtn);
	newItem.append(newBox, devider);

	return (newItem);
}

function addItem() {
	const text = inputText.value;
	if (text === "") {
		inputText.focus();
		return ;
	}
	const item = createItem(text);
	list.appendChild(item);
	item.scrollIntoView({block: 'center'});
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

function deleteFunc(event) {
	if(event.target.className == 'delete') {
		deleteItem(event);
	}
}

Btn.addEventListener("click", addItem);
inputText.addEventListener("keypress", detectEnter);
list.addEventListener("click", deleteFunc);
