import express from 'express';
import * as dataController from './dataController.js';

const dataRouter = express.Router();

dataRouter.route('/').get(dataController.getDatas);

export default dataRouter;
