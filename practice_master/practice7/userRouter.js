import express from "express";
import { getJoin, getLogin, home, postJoin, postLogin, logout } from "./userController";

const userRouter = express.Router();

// Add your magic here!

userRouter.get("/", home);
userRouter.route("/join").get(getJoin).post(postJoin);
userRouter.route("/login").get(getLogin).post(postLogin);
userRouter.get("/logout", logout);
export default userRouter;
