import "./db";
import "./models/User";
import express from "express";
import path from "path";
import bodyParser from "body-parser";
import session from "express-session";
import userRouter from "./userRouter";
import { localsMiddleware } from "./middlewares";
import morgan from "morgan";

const PORT = 8080;
const logger = morgan("dev");
const app = express();
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));
app.use(logger);
app.use(bodyParser.urlencoded({ extended: true }));
app.use(
  session({
    secret: "Hello!",
    resave: true,
    saveUninitialized: true,
  })
);
app.use(localsMiddleware);
app.use("/", userRouter);

// Codesanbox does not need PORT :)
app.listen(PORT, () => console.log(`✅  Server Ready! http://localhost:${PORT}`));
