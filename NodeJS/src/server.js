import express from "express";
import morgan from "morgan";
import globalRouter from './routers/globalRouter';
import videoRouter from './routers/videoRouter';
import userRouter from './routers/userRouter';

const PORT = 4000;
const app = express();
const logger = morgan("dev");

app.set("view engine", "pug");
app.set("views", process.cwd() + "/src/views"); // view의 위치를 서버폴더에서 찾기때문 이렇게 지정해줘야함
app.use(logger);
app.use("/", globalRouter);
app.use("/videos", videoRouter);
app.use("/users", userRouter);

const handleListening = () => {
	console.log(`Server listenting on port http://localhost:${PORT} 🌻`);
}
app.listen(PORT, handleListening)
