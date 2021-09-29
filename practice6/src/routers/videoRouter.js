import express from "express";
import { getUpload, postUpload, watch } from "../controllers/videoController";

const videoRouter = express.Router();

videoRouter.route("/upload").get(getUpload).post(postUpload);
videoRouter.get("/:id([0-9a-f]{24})", watch);

export default videoRouter;
