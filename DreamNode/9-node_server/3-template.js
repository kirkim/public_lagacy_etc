const http = require("http");
const fs = require("fs");
const ejs = require("ejs");

const name = "Kirkim";
const courses = [
  { name: "HTML" },
  { name: "CSS" },
  { name: "Javascript" },
  { name: "Node" },
];

const server = http.createServer((req, res) => {
  res.setHeader("Content-Type", "text/html");
  const url = req.url;
  if (url === "/") {
    ejs
      .renderFile("./template/home.ejs", { name })
      .then((data) => res.end(data));
  } else if (url === "/courses") {
    ejs
      .renderFile("./template/courses.ejs", { courses })
      .then((data) => res.end(data));
  } else {
    ejs
      .renderFile("./template/not-found.ejs", { name })
      .then((data) => res.end(data));
  }
});

server.listen(8080);
