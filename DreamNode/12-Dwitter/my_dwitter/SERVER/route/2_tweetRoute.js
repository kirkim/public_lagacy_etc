import express from "express";
import "express-async-errors";
import * as tweetController from "../controller/tweetController.js";

const router = express.Router();

router
  .route("/")
  .get(tweetController.getTweets)
  .post(tweetController.createTweet);
router
  .route("/:id")
  .get(tweetController.getTweet)
  .put(tweetController.updateTweet)
  .delete(tweetController.deleteTweet);

export default router;
