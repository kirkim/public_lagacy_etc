import express from "express";
import { getDetail, getHome, getRead, postText } from "./controller";
import { uploadFiles } from "./middleware";

const router = express.Router();

router.route("/").get(getHome);
router.route("/read").get(getRead).post(uploadFiles.single("text"), postText);
router.get("/read/:id", getDetail);

export default router;
