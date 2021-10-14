import express from "express";
import "express-async-errors";
import * as tweetController from "../controller/tweetController.js";
import { param, body, validationResult } from "express-validator";
import { validate } from "../middleware/validator.js";

const router = express.Router();

const validateTweet = [
  body("text").trim().notEmpty().withMessage("메시지를 입력하세요."),
  validate,
];

router
  .route("/")
  .get(tweetController.getTweets)
  .post(validateTweet, tweetController.createTweet);

router
  .route("/:id")
  .all([
    param("id").trim().notEmpty().withMessage("id주소가 유효하지 않습니다."),
    validate,
  ])
  .get(tweetController.getTweet)
  .put(validateTweet, tweetController.updateTweet)
  .delete(tweetController.deleteTweet);

export default router;
