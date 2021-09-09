import express from "express";

const PORT = 4000;
const app = express();

const logger = (req, res, next) => {  // 미들웨어는 응답함수가 아니다 next()로 다음handler로 넘겨줌
	console.log(`${req.method} ${req.url}`);
	next();
};

const privateMiddleware = (req, res, next) => {
	const url = req.url;
	if(url === "/protected") {
		return (res.send("<h1>Not Allowed</h1>"));
	}
	console.log("Allowed, you may continue.");
	next();
};

const handleHome = (request, response) => {
	return (response.send("I love middlewares"));
};

const handleProtected = (req, res) => {
	return (res.send("Welcome to the private lounge."));
}

app.use(logger);
app.use(privateMiddleware);
app.get("/", handleHome);
app.get("/protected", handleProtected);

const handleLogin = (req, res) => {
	return (res.send({ message: "Login here." }));
}
app.get("/login", handleLogin);

const handleListening = () => console.log(`Server listenting on port http://localhost:${PORT} 🌻`);
app.listen(PORT, handleListening)
