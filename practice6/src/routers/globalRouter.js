import express from "express";
import { getSearch, home } from "../controllers/videoController";

const globalRouter = express.Router();

globalRouter.get("/", home);
globalRouter.get("/search", getSearch);

export default globalRouter;
