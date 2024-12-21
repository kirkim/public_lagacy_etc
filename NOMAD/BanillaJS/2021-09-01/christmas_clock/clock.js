const timer = document.querySelector(".timer");
const christmas = new Date(2021, 11, 25);
const DAY = 1000 * 60 * 60 * 24;
const HOUR = 1000 * 60 * 60;
const MINUTE = 1000 * 60;
const SECOND = 1000;

setInterval(() => {
	const now = new Date();
	const ddate = christmas - now;
	const dday = Math.floor(ddate / DAY);
	const dhours = String(Math.floor(ddate % DAY / HOUR)).padStart(2, "0");
	const dminutes = String(Math.floor(ddate % HOUR / MINUTE)).padStart(2, "0");
	const dseconds = String(Math.floor(ddate % MINUTE / SECOND)).padStart(2, "0");
	console.log(now.getTime());
	timer.innerText = `${dday}d ${dhours}h ${dminutes}m ${dseconds}s`;
}, 1000);
