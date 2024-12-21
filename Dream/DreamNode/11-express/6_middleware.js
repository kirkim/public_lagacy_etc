import express, { Router } from "express";
import morgan from "morgan";
import postRouter from "./5_routers/post.js";
import userRouter from "./5_routers/user.js";

const app = express();
const PORT = 8080;
const logger = morgan("dev");
app.use(logger);
//
//
//

/*🌈 유용한 미들웨어 🌈*/
// 1️⃣
app.use(express.json()); // REST API -> Body
// 2️⃣
app.use(express.urlencoded({ extended: false })); // HTML Form -> Body

// 3️⃣
const options = {
  dotfiles: "ignore", // 숨겨진파일 무시
  etag: false,
  index: false,
  maxAge: "1d", // 캐시 수명
  redirect: false,
  setHeaders: function (res, path, stat) {
    res.set("x-rimestamp", Date.now()); // 헤더에 추가데이터 보내기
  },
};
app.use(express.static("public", options)); // 이런식으로 사용하면 "public"안에 있는 모든 리소스에 접근가능
// options도 줄 수 있음, 자세한건 express.static()문서 참고하자
//
//
//

// 4️⃣
// 서버와 클라이언트의 ip가 같으면 데이터를 원없이 주고받을 수 있지만 다를 경우 데이터를 문제없이 주고 받기 위해서는
// 다음과 같이 헤더에 표시해주어야 합니다.
// 💩 이 작업은 번거로운데 다행히 유용한 미들웨어가 있습니다.
//
// app.use((req, res, next) => {
//   res.setHeader("Access-Control-Allow-Origin", "http://127.0.0.1:5500");
//   res.setHeader(
//     "Access-Control-Allow-Methods",
//     "OPTIONS, GET, POST, PUT, DELETE",
//   );
//   next();
// });
//
// ✨ 바로 "cors" 미들웨어를 이용!
import cors from "cors";
//app.use(cors()); // 이렇게 쓰면 모든 ip에서 허용되므로..
app.use(
  cors({
    origin: ["http://127.0.0.1:5500"], // 이런식으로 ip 지정 가능
    optionsSuccessStatus: 200, // 200으로 자동으로 응답하게함
    credentials: true, // Access-Control-Allow-Credentials: true 와 동일, 토큰이나 사용자정보 추가를 허용하는 기능
  }),
);

app.use("/posts", postRouter);
app.use("/uers", userRouter);
app.get("/", (req, res) => {
  res.send("HALO!");
});

app.listen(PORT, () => console.log(`connect http://localhost:${PORT}`));
