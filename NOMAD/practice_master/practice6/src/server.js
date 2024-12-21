import express from "express";
import morgan from "morgan";
import globalRouter from "./routers/globalRouter";
import path from "path";
import videoRouter from "./routers/videoRouter";

const logger = morgan("dev");
const app = express();
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");
app.use(logger);
app.use(express.urlencoded({ extended: true }));
app.use("/", globalRouter);
app.use("/videos", videoRouter);
export default app;
