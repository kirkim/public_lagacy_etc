import express from 'express';
import morgan from 'morgan';
import config from './config.js';
import cors from 'cors';
import userRouter from './router/userRouter.js';
import bannerRouter from './router/bannerRouter.js';
import deliveryRouter from './router/deliveryRouter.js';
import basicRouter from './router/api.js';
import indexRouter from './router/index.js';
const server = express();
const staticUrl = config.static.url;
server.use(morgan('dev'));
server.use(cors());
server.use(express.json());
server.use(express.static(staticUrl));
server.use('/', indexRouter);
server.use('/user', userRouter);
server.use('/banner', bannerRouter);
server.use('/delivery', deliveryRouter);
server.use('/api', basicRouter);
server.use((_req, res, _next) => {
    return res.sendStatus(404);
});
server.use((error, _req, res, _next) => {
    console.error(error);
    return res.sendStatus(500);
});
export default server;
