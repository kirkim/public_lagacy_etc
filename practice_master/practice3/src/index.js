import "./db";
import express from "express";
import path from "path";
import morgan from "morgan";
import bodyParser from "body-parser";
import movieRouter from "./movieRouter";
import { localsMiddleware } from "./middlewares";

const logger = morgan("dev");
const PORT = 4000;
const app = express();
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));
app.use(logger);
app.use(bodyParser.urlencoded({ extended: true }));
app.use(localsMiddleware);
app.use("/", movieRouter);

// Codesanbox does not need PORT :)
app.listen(PORT, () => console.log(`✅  Server Ready! http://localhost:${PORT} 🚀`));
