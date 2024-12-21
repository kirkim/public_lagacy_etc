var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import * as deliveryDB from '../db/deliveryData.js';
import * as reviewDB from '../db/reviewData.js';
import * as userDB from '../db/userData.js';
export function getSummaryStores(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { type } = req.query;
        if (type == undefined) {
            return res.sendStatus(400);
        }
        let datas = yield deliveryDB.getSummaryStores(type);
        return res.status(200).send(datas);
    });
}
export function getLikeSummaryStores(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { id } = req.query;
        if (id == undefined) {
            return res.sendStatus(400);
        }
        let codes = yield userDB.findLikeStoresById(id);
        if (codes == undefined) {
            return res.sendStatus(400);
        }
        let datas = yield deliveryDB.getSummaryStoresByCode(codes);
        return res.status(200).send(datas);
    });
}
export function getDetailStore(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { storeCode } = req.query;
        if (storeCode == undefined) {
            return res.sendStatus(400);
        }
        let datas = yield deliveryDB.getDetailStore(storeCode);
        return res.status(200).send(datas);
    });
}
export function getReviews(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { storeCode, count, id } = req.query;
        if (id !== undefined) {
            let datas = yield reviewDB.getReviewsById(id);
            return res.status(200).send(datas);
        }
        else if (storeCode === undefined) {
            return res.sendStatus(400);
        }
        if (count === undefined) {
            let datas = yield reviewDB.getAllReviews(storeCode);
            return res.status(200).send(datas);
        }
        else {
            let datas = yield reviewDB.getReviews(storeCode, Number(count));
            return res.status(200).send(datas);
        }
    });
}
