import PopWindow from './popWindow.js';

export default class PopImage extends PopWindow {
  private input1 = document.querySelector('#pop__input__1');
  private input2 = document.querySelector('#pop__input__2');

  constructor(title: string, content: string) {
    super(title, content);
  }

  make = () => {
    const div = document.createElement('div');
    div.classList.add('main__content');
    div.innerHTML = `
		<img src="${this.input2.value}">
		<div class="content">Image</div>
		<div class="delete__content" id="delete__content">❌</div>
		`;
    this.input2.value = '';
    this.input1.value = '';

    this.mainForm?.appendChild(div);
    const deleteBtn = document.querySelector('#delete__content');
    deleteBtn?.addEventListener('click', this.delete);
    this.close();
  };

  delete = (event) => {
    const node = event.target.parentNode;
    this.mainForm?.removeChild(node);
  };
}
