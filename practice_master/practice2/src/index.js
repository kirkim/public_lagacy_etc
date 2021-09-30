import express from "express";
import path from "path";
import "./db";
import movieRouter from "./movieRouter";

const PORT = 4000;
const app = express();
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));
app.use(express.urlencoded({ extended: true }));
app.use("/", movieRouter);

app.listen(PORT, () => console.log(`success connect http://localhost:${PORT} 🧑‍💻`));
