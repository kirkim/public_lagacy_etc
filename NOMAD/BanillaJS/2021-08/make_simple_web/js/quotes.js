const quotes = [
	{
		quote: "삶이 있는 한 희망은 있다",
		author: "키케로",
	},
	{
		quote: "하루에 3시간을 걸으면 7년 후에 지구를 한바퀴 돌 수 있다.",
		author: "사무엘존슨",
	},
	{
		quote: "피할수 없으면 즐겨라",
		author: "로버트 엘리엇",
	},
	{
		quote: "절대 어제를 후회하지 마라. 인생은 오늘의  내 안에 있고 내일은 스스로 만드는것이다.",
		author: "L론허바드",
	},
	{
		quote: "성공의 비결은 단 한 가지, 잘할 수 있는 일에 광적으로 집중하는 것이다.",
		author: "톰 모나건",
	},
	{
		quote: "평생 살 것처럼 꿈을 꾸어라.그리고 내일 죽을 것처럼 오늘을 살아라.",
		author: "제임스 딘",
	},
	{
		quote: "절대 포기하지 말라. 당신이 되고 싶은 무언가가 있다면, 그에 대해 자부심을 가져라. 당신 자신에게 기회를 주어라. 스스로가 형편없다고 생각하지 말라. 그래봐야 아무 것도 얻을 것이 없다. 목표를 높이 세워라.인생은 그렇게 살아야 한다.",
		author: "마이크 멕라렌",
	},
	{
		quote: "고통이 남기고 간 뒤를 보라! 고난이 지나면 반드시 기쁨이 스며든다.",
		author: "괴테",
	},
	{
		quote: "마음만을 가지고 있어서는 안된다. 반드시 실천하여야 한다.",
		author: "이소룡",
	},
	{
		quote: "화가 날 때는 100까지 세라. 최악일 때는 욕설을 퍼부어라.",
		author: "마크 트웨인",
	},
];

const quote = document.querySelector("#quote span:first-child");
const author = document.querySelector("#quote span:last-child");

const todaysQuote = quotes[Math.floor(Math.random() * quotes.length)];

quote.innerText = todaysQuote.quote;
author.innerText = `\n -${todaysQuote.author}-`;
