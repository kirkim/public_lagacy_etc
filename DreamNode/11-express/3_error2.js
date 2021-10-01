import express from "express";
import fs from "fs";
import fsAsync from "fs/promises";
import morgan from "morgan";

const app = express();
const logger = morgan("dev");
const PORT = 8080;

app.use(logger);
app.use(express.json());

// 1. 비동기 예제
// readFileSync과 같은 동기는 에러가 던져지기 때문에 try,catch문으로 에러를 잡는다.
// 좀 더 세부적으로 에러를 처리하는게 가능하다.(마지막 에러호출망에 잡히기는해서 처리안해줘도 되긴함)
// readFile과 같은 비동기는 에러가 생겨도 콜백으로 에러를 던지기 때문에 에러가 나면 무한로딩
// 에 빠질 수 있으므로 반드시 콜백함수 내부에서 에러를 처리해주도록 한다.
app.get("/file1", (req, res) => {
  try {
    const data = fs.readFileSync("/file.txt"); // 동기적이기 때문에 에러처리하기 간단
  } catch (error) {
    res.status(404).send("File not found");
  }
  fs.readFile("/file1.txt", (err, data) => {
    if (err) {
      res.status(404).send("File not found");
    }
  });
});

// 2. promis 예제
// 아래와 같은 promise도 외부에서 try,catch를 이용해 에러를 잡을 수 없다.
// 내부적으로 에러를 잡기 위해서는 .catch를 이용해서 내부에러를 잡아야함
app.get("/file2", (req, res, next) => {
  // try {
  // 	fsAsync.readFile('/file.txt');
  // } catch (error) {
  // 	res.status(404).send('File not found');
  // }
  fsAsync
    .readFile("/file.txt")
    .then((data) => {})
    //.catch(next);  // 이런식으로 next를 사용해서 외부로 error를 날릴 수 있음
    .catch((error) => {
      return res.status(404).send("File not found");
    });
});

// 3. async 예제
// await를 이용하여 동기적으로 처리되는 것 같지만 async자체는 promise 이기 때문에 promise를 리턴해줌
// 그러므로 에러가 발생해도 외부로 에러를 던지지않는다.
// await자체는 동기적이기 때문에 async내부에서 try, catch를 이용해서 에러를 잡을 수 있다
app.get("/file3", async (req, res) => {
  try {
    const data = await fsAsync.readFile("/file.txt");
  } catch {
    return res.status(404).send("File not found");
  }
});

app.use((error, req, res, next) => {
  console.error(error);
  res.status(500).json({ message: "Something went wrong" });
});

app.listen(PORT, () => console.log(`http://localhost:${PORT}`));
