export default class PopWindow {
  private popSection = document.querySelector('#pop__section');
  private input2 = document.querySelector('#pop__label__2');

  constructor(private title: string, private content: string) {
    if (this.input2) {
      this.input2.textContent = content;
    }
  }

  open = () => {
    this.popSection?.classList.remove('hidden');
  };

  close = () => {
    this.popSection?.classList.add('hidden');
  };

  make = () => {
    console.log('make!');
  };
}
