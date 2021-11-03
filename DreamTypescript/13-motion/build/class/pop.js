var PopWindow = /** @class */ (function () {
    function PopWindow(title, content) {
        var _this = this;
        this.title = title;
        this.content = content;
        this.popSection = document.querySelector('#pop__section');
        this.click = function () {
            var _a;
            (_a = _this.popSection) === null || _a === void 0 ? void 0 : _a.classList.remove('hidden');
        };
    }
    return PopWindow;
}());
export default PopWindow;
