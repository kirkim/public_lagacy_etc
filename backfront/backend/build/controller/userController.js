var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import * as userDB from '../db/userData.js';
import bcrypt from 'bcrypt';
export function postLogin(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { userID, password } = req.body;
        const user = yield userDB.findByUserID(userID);
        if (!user) {
            return res.sendStatus(400);
        }
        const ok = yield bcrypt.compare(password, user.data.password);
        if (!ok) {
            return res.sendStatus(400);
        }
        return res.status(200).send(user);
    });
}
export function postSignUp(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { userID, password, name } = req.body;
        const exist = yield userDB.findByUserID(userID);
        if (exist) {
            return res.sendStatus(400);
        }
        let newUser = {
            userID: userID,
            password: password,
            name: name,
        };
        yield userDB.create(newUser);
        return res.sendStatus(200);
    });
}
export function getAllUser(_req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        let datas = yield userDB.getAllUser();
        return res.status(200).send(datas);
    });
}
export function checkId(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        console.log(req.body);
        const userID = req.body.userID;
        const exist = yield userDB.checkByUserID(userID);
        return res.status(200).json(exist);
    });
}
export function getLikeStoresById(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        let { id } = req.query;
        if (id === undefined) {
            return res.sendStatus(400);
        }
        let datas = yield userDB.findLikeStoresById(id);
        return res.status(200).json(datas);
    });
}
export function addOrRemoveLikeStore(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        let { id, storeCode } = req.query;
        if (id === undefined || storeCode === undefined) {
            return res.sendStatus(400);
        }
        try {
            let data = yield userDB.addOrRemoveLikeStore(id, storeCode);
            return res.status(200).json(data);
        }
        catch (error) {
            console.log(error);
            return res.sendStatus(400);
        }
    });
}
