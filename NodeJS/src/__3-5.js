import express from "express";

const PORT = 4000;

const app = express();

// app.get("/", (request, response) => {
// 	return (response.send("<h1>I still love you.</h1>"));
// });

const gossipMiddleware = (req, res, next) => {  // 미들웨어는 응답함수가 아니다 next()로 다음handler로 넘겨줌
	console.log(`Someone is going to: ${req.url}`);
	next();
}
const handleHome = (request, response) => {
	return (response.end());
}

app.get("/", gossipMiddleware, handleHome); // 첫번째인자로 path를 받고 그다음부터 handler를 여러개 받을 수 있음

// function handleLogin(req, res) {
// 	return (res.send("Login here."));
// }
const handleLogin = (req, res) => {
	return (res.send({ message: "Login here." }));
}

app.get("/login", handleLogin);

const handleListening = () => console.log(`Server listenting on port http://localhost:${PORT} 🌻`);

app.listen(PORT, handleListening)
