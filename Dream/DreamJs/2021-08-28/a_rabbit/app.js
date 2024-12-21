const rabbit = document.querySelector(".rabbit");
const btn = document.querySelector(".Btn");

function findRabbit(event) {
	rabbit.scrollIntoView({behavior: "smooth", block: "center"});
}

btn.addEventListener("click", findRabbit);
