export default class PopWindow {
    constructor(title, content) {
        this.title = title;
        this.content = content;
        this.popSection = document.querySelector('#pop__section');
        this.bodyLabel = document.querySelector('#pop__label__2');
        this.mainForm = document.querySelector('#main__section');
        this.open = () => {
            var _a;
            (_a = this.popSection) === null || _a === void 0 ? void 0 : _a.classList.remove('hidden');
        };
        this.close = () => {
            var _a;
            (_a = this.popSection) === null || _a === void 0 ? void 0 : _a.classList.add('hidden');
        };
        this.make = () => {
            console.log('make!');
        };
        this.delete = (event) => {
            var _a;
            const node = event.target.parentNode;
            (_a = this.mainForm) === null || _a === void 0 ? void 0 : _a.removeChild(node);
        };
        if (this.bodyLabel) {
            this.bodyLabel.textContent = content;
        }
    }
}
