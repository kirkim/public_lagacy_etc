export default abstract class PopWindow {
  private popSection = document.querySelector('#pop__section');
  private bodyLabel = document.querySelector('#pop__label__2');
  protected mainForm = document.querySelector('#main__section');

  constructor(protected title: string, protected content: string) {
    if (this.bodyLabel) {
      this.bodyLabel.textContent = content;
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

  delete = (event) => {
    const node = event.target.parentNode;
    this.mainForm?.removeChild(node);
  };
}
