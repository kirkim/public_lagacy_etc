import express from 'express';
var indexRouter = express.Router();
indexRouter.get('/', function (_req, res, _next) {
    res.render('index', { title: 'Express' });
});
export default indexRouter;
