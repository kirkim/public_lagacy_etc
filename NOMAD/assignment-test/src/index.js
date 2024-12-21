import express from "express";
import morgan from "morgan";
import globalRouter from "./routers/globalRouter";
import userRouter from "./routers/userRouter";
import storyRouter from "./routers/storyRouter";

const PORT = 8080;
const app = express();
const logger = morgan("dev");

console.log(process.cwd());
app.set("view engine", "pug");
app.set("views", process.cwd() + "/src/views");
app.use(logger);
app.use("/", globalRouter);
app.use("/stories", storyRouter);
app.use("/users", userRouter);

app.listen(PORT, () => console.log(`success connect http://localhost:${PORT} 🚀`));
