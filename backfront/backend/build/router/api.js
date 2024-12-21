import express from 'express';
let basicRouter = express.Router();
basicRouter.get('/hello', function (req, res, _next) {
    const name = req.query.name || 'World';
    res.json({ message: `Hello ${name}` });
});
export default basicRouter;
