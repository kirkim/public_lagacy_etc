import express, { Router } from "express";
import morgan from "morgan";
import postRouter from "./5_routers/post.js";
import userRouter from "./5_routers/user.js";

const app = express();
const PORT = 8080;
const logger = morgan("dev");
app.use(logger);
//
//
///*🌈 유용한 미들웨어 🌈*/

//
//
// 1️⃣ cookie-parser
import cookieParser from "cookie-parser";
app.get("/cookies", (req, res) => {
  console.log(req.cookies); // req.body처럼 cookies도 미들웨어의 도움을 통해 읽어야함

  res.send("Welcome!");
});
//
//
// 2️⃣ helmet
// Network-Header에 보안에 관련된 헤더들을 추가해준다.
//
import helmet from "helmet";
app.use(helmet());
//
//
app.use("/posts", postRouter);
app.use("/uers", userRouter);
app.get("/", (req, res) => {
  res.send("HALO!");
});

app.listen(PORT, () => console.log(`connect http://localhost:${PORT}`));
