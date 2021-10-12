import express from "express";
import morgan from "morgan";
import globalRouter from "./routers/rootRouter";
import videoRouter from "./routers/videoRouter";
import userRouter from "./routers/userRouter";
import session from "express-session";
import MongoStore from "connect-mongo";
import { localsMiddleware } from "./middlewares";
import apiRouter from "./routers/apiRouter";

const app = express();
const logger = morgan("dev");

app.set("view engine", "pug");
app.set("views", process.cwd() + "/src/views"); // view의 위치를 서버폴더에서 찾기때문 이렇게 지정해줘야함
app.use(logger);
app.use(express.urlencoded({ extended: true })); // form을 이해하고 js형태로 바꿔줌

app.use(
  session({
    secret: process.env.COOKIE_SECRET,
    resave: false,
    saveUninitialized: false,
    store: MongoStore.create({ mongoUrl: process.env.DB_URL }),
  })
);

// app.use((req, res, next) => {
//   req.sessionStore.all((error, sessions) => {
//     console.log(sessions);
//   });
//   next();
// });

app.get("/add-one", (req, res, next) => {
  return res.send(`${req.session.id}`);
});

app.use(localsMiddleware);
app.use("/uploads", express.static("uploads"));
app.use("/static", express.static("assets"));
app.use("/", globalRouter);
app.use("/videos", videoRouter);
app.use("/users", userRouter);
app.use("/api", apiRouter);

export default app;
