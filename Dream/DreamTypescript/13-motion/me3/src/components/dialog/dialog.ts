import { Component, BaseComponent } from './../component.js';
import { Composable } from '../page/page.js';

type OnCloseListener = () => void;
type OnSubmitListener = () => void;

export abstract class InputDialog
  extends BaseComponent<HTMLElement>
  implements Composable
{
  closeListener?: OnCloseListener;
  submitListener?: OnSubmitListener;
  constructor() {
    super(`<dialog class="dialog">
			<div class="dialog__container">
  				<button class="close">&times;</button>
  				<div id="dialog__body"></div>
  				<button class="dialog__submit">ADD</button>
			</div>
		</dialog>`);
    const closeBtn = this.element.querySelector('.close')! as HTMLElement;
    closeBtn.onclick = () => {
      this.closeListener && this.closeListener();
    };

    const submitBtn = this.element.querySelector(
      '.dialog__submit'
    )! as HTMLElement;
    submitBtn.onclick = () => {
      this.submitListener && this.submitListener();
    };
    const dialog_body = this.element.querySelector(
      '#dialog__body'
    )! as HTMLDivElement;
    dialog_body.innerHTML = this.addBody();
  }

  abstract addBody(): string;

  setOnCloseListener(listenr: OnCloseListener) {
    this.closeListener = listenr;
  }
  setOnSubmitListener(listenr: OnSubmitListener) {
    this.submitListener = listenr;
  }
  addChild(child: Component) {
    const body = this.element.querySelector('#dialog__body')! as HTMLElement;
    child.attachTo(body);
  }
}
