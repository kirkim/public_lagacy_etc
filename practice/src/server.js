import express from "express"

const PORT = 4000;
const app = express();

const viewURL = (req, res, next) => {
	console.log(`Path: ${req.url}`);
	next();
}

const viewTime = (req, res, next) => {
	const now = new Date();
	console.log(`Time: ${now.getFullYear()}.${now.getMonth()}.${now.getDate()}`);
	next();
}

const checkSecurity = (req, res, next) => {
	let mark;
	mark = req.protocol === 'https' ? '⭕️' : '❌';
	console.log(`Insecure ${mark}`);
	next();
}

const checkProtected = (req, res, next) => {
	if (req.url === '/protected') {
		return res.send("<h1>Not Allowed</h1>");
	}
	next();
}

const endWare = (req, res) => {
	return res.send("<h1>Welcome Home!</h1>");
}

app.use(viewURL);
app.use(viewTime);
app.use(checkSecurity);
app.use(checkProtected);
app.get("/", endWare);
app.listen(PORT, () => console.log(`success conect server http://localhost:${PORT} 🌈`));
