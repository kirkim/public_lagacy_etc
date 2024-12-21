import express from "express";
import { create } from "../controllers/stories";
import { join, login } from "../controllers/users";

const globalRouter = express.Router();

globalRouter.get("/join", join);
globalRouter.get("/login", login);
globalRouter.get("/new", create);
globalRouter.get("/", (req, res) => res.send("home!"));

export default globalRouter;
