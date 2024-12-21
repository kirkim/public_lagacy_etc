import express, { application } from "express";
import helmet from "helmet";
import morgan from "morgan";
import { localsMiddleware } from "./middleware";
import globalRouter from "./router/router";
import session from "express-session";

const app = express();
app.set("view engine", "pug");
app.set("views", __dirname + "/views");

/* middleware */
app.use(helmet());
app.use(morgan("dev"));
app.use(express.urlencoded({ extended: true }));
app.use(
  session({
    secret: "Hi!",
    resave: true,
    saveUninitialized: true,
  })
);
app.use(localsMiddleware);
/* router */
app.use("/", globalRouter);

/* Url error! */
app.use((req, res) => {
  res.status(404).send("Wrong Page!");
});

/* Server error! */
app.use((error, req, res, next) => {
  console.log(error);
  res.sendStatus(500);
});
export default app;
