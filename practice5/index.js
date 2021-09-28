import "./db";
import "./models/Movie";
import express from "express";
import path from "path";
import bodyParser from "body-parser";
import movieRouter from "./movieRouter";
import { localsMiddleware } from "./middlewares";
import morgan from "morgan";

const logger = morgan("dev");
const PORT = 8080;
const app = express();
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));
app.use(logger);
app.use(bodyParser.urlencoded({ extended: true }));
app.use(localsMiddleware);
app.use("/", movieRouter);

app.listen(PORT, () => console.log(`✅  Server Ready! http://localhost:${PORT}`));
