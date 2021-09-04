import Clock from './clock.js';
import Login from './login.js';
import Todo from './todo.js';

const mainForm = document.querySelector(".main");
const loginForm = document.querySelector(".login");
const logoutForm = document.querySelector(".logout");
const todoForm = document.querySelector(".todo");
const todoForm2 = document.querySelector(".todo2");
const clockBtn = document.querySelector("#toggle");
const clock = new Clock(".clock", ".clock__text");
const login = new Login(loginForm, mainForm);
const todo = new Todo(todoForm, 1);
const todo2 = new Todo(todoForm2, 2);

loginForm.addEventListener("submit", (event) => {
	login.in(event);
});

logoutForm.addEventListener("click", () => {
	login.out();
})

clockBtn.addEventListener("click", (event) => {
	clock.handle(event.target.checked);
});
