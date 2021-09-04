export default class Todo {
	constructor(todoForm, code) {
		this.todoForm = todoForm;
		this.todoInput = this.todoForm.querySelector(".todo__input");
		this.todoOutput = this.todoForm.querySelector(".todo__output");
		this.savedTodo = [];
		this.TODO_KEY = `todo${code}`;
		this.todoForm.addEventListener("submit", this.handle)
		this.loadData();
	}

	deleteList = (event) => {
		const target = this.todoOutput.querySelector(`li[id="${event.target.id}"]`);
		target.remove();
		this.savedTodo = this.savedTodo.filter((toDos) => toDos.id !== parseInt(target.id));
  		this.saveData();
	}

	printData(newObj) {
		const li = document.createElement("li");
		const deleteBtn = document.createElement("span");
		li.setAttribute('id', newObj.id);
		li.textContent = `${newObj.todo}`
		deleteBtn.setAttribute('id', newObj.id);
		deleteBtn.setAttribute('class', "deleteBtn");
		deleteBtn.textContent = "❌";
		deleteBtn.addEventListener("click", this.deleteList);
		li.appendChild(deleteBtn);
		this.todoOutput.appendChild(li);
	}

	loadData() {
		const savedData = localStorage.getItem(this.TODO_KEY);
		if(savedData !== null) {
			const parsedData = JSON.parse(savedData);
			this.savedTodo = parsedData;
			parsedData.forEach((obj) => this.printData(obj));
		}
	}

	saveData() {
		localStorage.setItem(this.TODO_KEY, JSON.stringify(this.savedTodo));
	}

	handle = (event) => {
		event.preventDefault();
		const todoList = {
			todo: this.todoInput.value,
			id: Date.now(),
		}
		this.todoInput.value = "";
		this.savedTodo.push(todoList);
		this.printData(todoList);
		this.saveData(todoList);
	}
}
