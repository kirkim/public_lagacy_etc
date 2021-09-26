import express from "express";
import morgan from "morgan";
const app = express();
const PORT = 8080;
const logger = morgan("dev");

app.use(logger);
app.get("/", (req, res, next) => {
  // console.log(req.path);
  // console.log(req.headers);
  console.log(req.params);
  console.log(req.params.id);

  console.log(req.query);
  console.log(req.query.keyword);
  res.setHeader("key", "value");
  res.end();
});

app.listen(PORT, () => console.log(`connect http://localhost:${PORT}`));
