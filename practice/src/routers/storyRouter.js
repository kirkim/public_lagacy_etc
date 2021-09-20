import express from "express";
import { story, edit, remove } from "../controllers/stories.js"

const storyRouter = express.Router();

storyRouter.get("/:id", story);
storyRouter.get("/:id/edit", edit);
storyRouter.get("/:id/delete", remove);

export default storyRouter;
