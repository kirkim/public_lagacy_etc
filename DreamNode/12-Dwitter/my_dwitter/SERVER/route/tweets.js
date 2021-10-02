import express from "express";
import "express-async-errors";

const tweets = [
  {
    id: "1",
    text: "kirkim 화이팅!",
    createdAt: Date.now().toString(),
    name: "Bob",
    username: "bob",
    url: "https://https://kirkim.github.io/assets/icons/icon-70x70.png",
  },
  {
    id: "2",
    text: "하위 화이팅!",
    createdAt: Date.now().toString(),
    name: "Bob",
    username: "미ㅣ",
  },
];
const router = express.Router();

// GET /tweets
// GET /tweets?username=:username
router.get("/", (req, res, next) => {
  const username = req.query.username;
  const data = username
    ? tweets.filter((t) => t.username === username)
    : tweets;
  res.status(200).json(data);
});
// GET /tweets/:id
// POST /tweets
// PUT /tweets/:id
// DELETE /tweets/:id
export default router;
