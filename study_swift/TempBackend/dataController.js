import * as dataDB from './tempDB.js';

export async function getDatas(req, res) {
  const datas = await dataDB.getAllDatas();
  return res.status(200).json(datas);
}
