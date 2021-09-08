const hor = document.querySelector(".horizon");
const ver = document.querySelector(".vertical");
const img = document.querySelector(".targetImg");
const tag = document.querySelector(".tag");


addEventListener('load', () => {
	const imgRect = img.getBoundingClientRect();
	const imgHalfWidth = imgRect.width / 2;
	const imgHalfHeight = imgRect.height / 2;

	document.addEventListener("mousemove", (event) => {
		const x = event.pageX;
		const y = event.pageY;


		ver.style.transform = `translateX(${x}px)`;
		hor.style.transform = `translateY(${y}px)`;
		img.style.transform = `translate(${x - imgHalfWidth}px, ${y - imgHalfHeight}px)`;
		tag.style.transform = `translate(${x}px, ${y}px)`;

		//ver.style.left = `${x}px`;
		//hor.style.top = `${y}px`;
		//img.style.left = `${x}px`;
		//img.style.top = `${y}px`;
		//tag.style.left = `${x}px`;
		//tag.style.top = `${y}px`;
		tag.innerText = `${x}px, ${y}px`;
	})
});
