import express from "express";
import morgan from "morgan";

const POST = 8080;
const app = express();
const logger = morgan("dev");

app.use(logger);
app.use(express.json());
app.post("/", (req, res, next) => {
  console.log(req.body);
});

app.listen(POST, () => console.log(`Success Connect http://localhost:${POST}`));
