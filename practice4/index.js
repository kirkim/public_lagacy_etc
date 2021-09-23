const colors = ["#1abc9c", "#3498db", "#9b59b6", "#f39c12", "#e74c3c"];
const h2 = document.querySelector("h2");

const superEventHandler = {
  handlerClick: function handlerClick() {
    h2.innerText = "Mouse is here";
    h2.style.color = colors[0]; // 위에 colors array가져다 쓸라고 이렇게 했는데 왜 에러가 날까요?
  },
};

h2.addEventListener("mouseenter", superEventHandler.handlerClick);
