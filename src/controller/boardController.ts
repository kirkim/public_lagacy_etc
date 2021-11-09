import * as postDb from '../db/postData.js';
import { Request, Response } from 'express';

export async function getBoards(req: Request, res: Response) {
  const range: number = req.query.range ? Number(req.query.range) : 10;
  const page: number = req.query.page ? Number(req.query.page) : 1;
  const posts = await postDb.getPosts((page - 1) * range, range);
  return res.status(200).json(posts);
}
