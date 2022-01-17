'use strict';

import express from 'express';
import morgan from 'morgan';
import config from './config.js';
import dataRouter from './dataRouter.js';

const app = express();
const PORT = config.host.port;

app.use(morgan('dev'));

app.use('/datas', dataRouter);

app.use((req, res, next) => {
  return res.sendStatus(404);
});

app.use((error, req, res, next) => {
  console.error(error);
  return res.sendStatus(500);
});

app.listen(PORT, () => console.log(`success connect! http://localhost:${PORT}`));
