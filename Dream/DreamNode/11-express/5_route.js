import express, { Router } from "express";
import morgan from "morgan";
import postRouter from "./5_routers/post.js";
import userRouter from "./5_routers/user.js";

const app = express();
const PORT = 8080;
const logger = morgan("dev");

app.use(express.json());
// 1. 체인형식은 가독성이 떨어지고 유지보수가 힘들다
// app
//   .route("/posts")
//   .get((req, res, next) => {
//     res.status(201).send("GET: /posts");
//   })
//   .post((req, res) => {
//     res.status(201).send("POST: /posts");
//   });

// app
//   .route("/posts/:id")
//   .put((req, res) => {
//     res.status(201).send("PUT: /posts/:id");
//   })
//   .delete((req, res) => {
//     res.status(201).send("DELETE: /posts/:id");
//   });

// 2. 이런식으로 라우터를 크게 분류하는게 좋음
app.use("/posts", postRouter);
app.use("/suers", userRouter);

app.listen(PORT, () => console.log(`connect http://localhost:${PORT}`));
