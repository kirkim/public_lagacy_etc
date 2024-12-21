import express from 'express';
import {
  watch,
  getEdit,
  postEdit,
  getUpload,
  postUpload,
  deleteVideo,
} from '../controllers/videoControllers';
import { protectMiddleWare, videoUpload } from '../middlewares';

const videoRouter = express.Router();

videoRouter.get('/:id([0-9a-f]{24})', watch); // 이런식으로 숫자만 받도록하면 upload를 아래순번에 보내도됨
videoRouter
  .route('/:id([0-9a-f]{24})/edit')
  .all(protectMiddleWare)
  .get(getEdit)
  .post(postEdit);
videoRouter
  .route('/:id([0-9a-f]{24})/delete')
  .all(protectMiddleWare)
  .get(deleteVideo);
videoRouter
  .route('/upload')
  .all(protectMiddleWare)
  .get(getUpload)
  .post(
    videoUpload.fields([
      { name: 'video', maxCount: 1 },
      { name: 'thumb', maxCount: 1 },
    ]),
    postUpload
  );

export default videoRouter;
