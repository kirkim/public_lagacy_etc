import express from "express";
import * as userController from "../controller/user";
import * as postController from "../controller/post";
import * as globalController from "../controller/global";

const globalRouter = express.Router();

globalRouter.get("/", globalController.home);
globalRouter.route("/post").get(postController.get).post(postController.post);
globalRouter.route("/login").get(userController.getLogin).post(userController.postLogin);
globalRouter.route("/join").get(userController.getJoin).post(userController.postJoin);
globalRouter.get("/logout", userController.logout);
export default globalRouter;
