var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
import PopWindow from './popWindow.js';
var PopImage = /** @class */ (function (_super) {
    __extends(PopImage, _super);
    function PopImage(title, content) {
        var _this = _super.call(this, title, content) || this;
        _this.input1 = document.querySelector('#pop__input__1');
        _this.input2 = document.querySelector('#pop__input__2');
        _this.make = function () {
            var _a;
            var div = document.createElement('div');
            div.classList.add('main__content');
            div.innerHTML = "\n\t\t<img src=\"" + _this.input2.value + "\">\n\t\t<div class=\"content\">Image</div>\n\t\t<div class=\"delete__content\" id=\"delete__content\">\u274C</div>\n\t\t";
            _this.input2.value = '';
            _this.input1.value = '';
            (_a = _this.mainForm) === null || _a === void 0 ? void 0 : _a.appendChild(div);
            var deleteBtn = document.querySelector('#delete__content');
            deleteBtn === null || deleteBtn === void 0 ? void 0 : deleteBtn.addEventListener('click', _this.delete);
            _this.close();
        };
        _this.delete = function (event) {
            var _a;
            var node = event.target.parentNode;
            (_a = _this.mainForm) === null || _a === void 0 ? void 0 : _a.removeChild(node);
        };
        return _this;
    }
    return PopImage;
}(PopWindow));
export default PopImage;
