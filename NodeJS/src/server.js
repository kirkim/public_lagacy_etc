import express from "express";
import morgan from "morgan";

const PORT = 4000;
const app = express();

const logger = morgan("dev");  // morgan에서 index.js파일 보면 next()를 호출함을 볼 수 있음
//const logger = morgan("combine");
//const logger = morgan("short");
//const logger = morgan("tiny");

const handleHome = (request, response) => {
	return (response.send("I love middlewares"));
};

const handleProtected = (req, res) => {
	return (res.send("Welcome to the private lounge."));
}

const handleLogin = (req, res) => {
	return (res.send({ message: "Login here." }));
}

app.use(logger);
app.get("/", handleHome);
app.get("/login", handleLogin);

const handleListening = () => console.log(`Server listenting on port http://localhost:${PORT} 🌻`);
app.listen(PORT, handleListening)
