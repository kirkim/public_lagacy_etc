import express from "express";
import { see, edit, upload, deleteVideo } from '../controllers/videoControllers';

const videoRouter = express.Router();

videoRouter.get("/:id(\\d+)", see);  // 이런식으로 숫자만 받도록하면 upload를 아래순번에 보내도됨
videoRouter.get("/:id(\\d+)/edit", edit);
videoRouter.get("/:id(\\d+)/delete", deleteVideo)
videoRouter.get("/upload", upload);  // 순서중요 :id보다 아래있음 오류생김
export default videoRouter;
