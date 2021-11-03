var PopWindow = /** @class */ (function () {
    function PopWindow(title, content) {
        var _this = this;
        this.title = title;
        this.content = content;
        this.popSection = document.querySelector('#pop__section');
        this.bodyLabel = document.querySelector('#pop__label__2');
        this.mainForm = document.querySelector('#main__section');
        this.open = function () {
            var _a;
            (_a = _this.popSection) === null || _a === void 0 ? void 0 : _a.classList.remove('hidden');
        };
        this.close = function () {
            var _a;
            (_a = _this.popSection) === null || _a === void 0 ? void 0 : _a.classList.add('hidden');
        };
        this.make = function () {
            console.log('make!');
        };
        if (this.bodyLabel) {
            this.bodyLabel.textContent = content;
        }
    }
    return PopWindow;
}());
export default PopWindow;
