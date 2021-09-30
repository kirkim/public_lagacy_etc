import express from "express";
import { home, movieDetail, getAddMovie, postAddMovie } from "./movieController";

const movieRouter = express.Router();

// create the '/' route
movieRouter.get("/", home);
// create the /:id route
movieRouter.get("/:id(\\d+)", movieDetail);
// create the /add route (GET + POST)
movieRouter.route("/add").get(getAddMovie).post(postAddMovie);

export default movieRouter;
