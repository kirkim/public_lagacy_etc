// 비동기도 error를 외부에서 잡을 수 이쎅 하는 방법
// Express.js 5.0.0 alpha.7 버전에서 해결했으나 현업에서 alpha버전을 쓰기는 꺼려지는데..
// 그 대안으로 express-async-errors 라는 라이브러리사용ㅎ면됨
// 하지만 비동기중에서도 promise를 return해줘야만 에러를 감지할 수 있으므로 return을 꼭해주자

import {} from "express-async-errors"; //<<<<<<<✨✨✨이런식으로 import만하면 사용가능✨✨✨

//🚀🚀🚀🚀🚀 하지만 이렇게 오류처리하는 것보다 해당하는 위치에서 에러처리해주는게 더 좋은 습관이다

import express from "express";
import fs from "fs";
import fsAsync from "fs/promises";
import morgan from "morgan";

const app = express();
const logger = morgan("dev");
const PORT = 8080;

app.use(logger);
app.use(express.json());

// 2. promis 예제

app.get("/file2", (req, res, next) => {
  return fsAsync.readFile("/file.txt");
});

// 3. async 예제

app.get("/file3", async (req, res) => {
  const data = await fsAsync.readFile("/file.txt");
});

app.use((error, req, res, next) => {
  console.error(error);
  res.status(500).json({ message: "Something went wrong" });
});

app.listen(PORT, () => console.log(`http://localhost:${PORT}`));
