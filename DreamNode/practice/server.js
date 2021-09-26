const http = require("http");
const PORT = 8080;
const app = http.createServer();

app.on("request", (req, res) => {
  const { method, url } = req;
  const headers = req.headers;

  //console.log(headers);
  console.log(headers["user-agent"]);
  console.log(headers["sec-fetch-site"]);
  console.log(headers.host);
  if (url === "/") {
    if (method === "GET") {
      res.end("hi!");
    }
  }
});
app.listen(PORT, () => console.log(`success connect http://localhost:${PORT}`));
