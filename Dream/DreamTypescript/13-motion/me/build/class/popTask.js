import PopWindow from './popWindow.js';
export default class PopTask extends PopWindow {
    constructor(title, content) {
        super(title, content);
        this.input1 = document.querySelector('#pop__input__1');
        this.input2 = document.querySelector('#pop__input__2');
        this.make = () => {
            var _a;
            const id = Date.now();
            const div = document.createElement('div');
            div.classList.add('main__content');
            div.innerHTML = `
		<div>Todo</div>
		<ul class="content">
			<li>${this.input2.value}</li>
		</ul>
		<div class="delete__content" id="delete__content__${id}">❌</div>
		`;
            this.input2.value = '';
            this.input1.value = '';
            (_a = this.mainForm) === null || _a === void 0 ? void 0 : _a.appendChild(div);
            const deleteBtn = document.querySelector(`#delete__content__${id}`);
            deleteBtn === null || deleteBtn === void 0 ? void 0 : deleteBtn.addEventListener('click', this.delete);
            this.close();
        };
    }
}
