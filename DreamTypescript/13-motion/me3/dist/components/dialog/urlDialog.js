import { InputDialog } from './dialog.js';
export class UrlInputDialog extends InputDialog {
    constructor() {
        super();
    }
    addBody() {
        return `<label for="">Title</label>
      		<input type="text" id="input-title" />
      		<label for="">Url</label>
      		<input type="text" id="input-url" />`;
    }
}
