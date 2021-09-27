/* 서버 구동 */
const express = require("express");
const PORT = 8080;
server = express();
server.use(express.urlencoded({ extended: true })); // input body 읽기용
server.listen(PORT, () =>
  console.log(`success connect server! http://localhost:${PORT}`)
);

/* morgan이용 */
const morgan = require("morgan");
const logger = morgan("dev");
server.use(logger);

/* get요청처리 */
server.get("/", (req, res) => res.sendFile(__dirname + "/index.html"));
server.get("/purchase/complete", (req, res) =>
  res.sendFile(__dirname + "/purchaseDone.html")
);
server.get("/purchase", (req, res) => res.sendFile(__dirname + "/purchase.html"));

/////////////////////////// 위에 무시해도 됨 ////////////////////////////////////

/* post요청처리 */
const fakeDB = [];

server.post("/purchase", (req, res) => {
  const id = new Date().getTime();
  const product = req.body;
  fakeDB.push({ id, product });
  console.log(fakeDB);
  return res.redirect("/purchase/complete");
});

//return res.sendFile(__dirname + "/purchase.html");
//return res.sendFile(__dirname + "/purchaseDone.html");
//return res.redirect("/purchase/complete");
