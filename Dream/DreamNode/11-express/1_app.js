import express, { Router } from "express";
import morgan from "morgan";
const app = express();
const PORT = 8080;
const logger = morgan("dev");

app.all("/api", (req, res, next) => {
  // 오직 /api 에서만 굳이 use와 같이 쓰려면 /api/* 로 쓰면됨
  console.log("all");
  next();
});

app.use("/sky", (req, res, next) => {
  // /sky/ 뒤에 어느것 이오든
  console.log("use");
  next();
});

app.use(logger);
app.get(
  "/",
  (req, res, next) => {
    // console.log(req.path);
    // console.log(req.headers);
    console.log(req.params);
    console.log(req.params.id);

    console.log(req.query);
    console.log(req.query.keyword);
    res.send("WoW!"); //여기서 send해버리면 추후 next()가 에러
    // return res.send("WOW!"); // send는 이와같이 return을 이용하는게 좋음
    //next();
  },
  (req, res, next) => {
    console.log("second!!");
    res.send("hi");
  },
);

app.use((req, res, next) => {
  res.status(404).send("Not available!@_@");
});
app.use((error, req, res, next) => {
  console.error(error);
  res.status(500).send("Sorry, try later!");
});
app.listen(PORT, () => console.log(`connect http://localhost:${PORT}`));
