import PopWindow from './popWindow.js';

export default class PopTask extends PopWindow {
  private input1 = document.querySelector('#pop__input__1');
  private input2: HTMLInputElement = document.querySelector('#pop__input__2');

  constructor(title: string, content: string) {
    super(title, content);
  }

  make = () => {
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

    this.mainForm?.appendChild(div);
    const deleteBtn = document.querySelector(`#delete__content__${id}`);
    deleteBtn?.addEventListener('click', this.delete);
    this.close();
  };
}
