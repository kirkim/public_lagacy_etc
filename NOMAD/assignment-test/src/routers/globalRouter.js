import express from "express";
import { join, login } from "../controllers/usersController";
import { home, trending, newStories } from "../controllers/storiesController";

const globalRouter = express.Router();

globalRouter.get("/", home);
globalRouter.get("/trending", trending);
globalRouter.get("/new", newStories);
globalRouter.get("/join", join);
globalRouter.get("/login", login);

export default globalRouter;
