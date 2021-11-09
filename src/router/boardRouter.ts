import express from 'express';
import * as boardCtl from '../controller/boardController.js';

const boardRouter = express.Router();

boardRouter.route('/').get(boardCtl.getBoards);

export default boardRouter;
