import express from "express";
import morgan from "morgan";
import globalRouter from "./routers/rootRouter";
import videoRouter from "./routers/videoRouter";
import userRouter from "./routers/userRouter";

const app = express();
const logger = morgan("dev");

app.set("view engine", "pug");
app.set("views", process.cwd() + "/src/views"); // view의 위치를 서버폴더에서 찾기때문 이렇게 지정해줘야함
app.use(logger);
app.use(express.urlencoded({ extended: true })); // form을 이해하고 js형태로 바꿔줌
app.use("/", globalRouter);
app.use("/videos", videoRouter);
app.use("/users", userRouter);

export default app;
