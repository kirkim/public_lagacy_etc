var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import bcrypt from 'bcrypt';
import config from '../config.js';
import { userDatas } from './data/userStorage.js';
export function getRandomUser() {
    let rand = Math.floor(Math.random() * userDatas.length);
    let rValue = userDatas[rand];
    return {
        userID: rValue.data.userID,
        name: rValue.data.name,
        id: rValue.id,
    };
}
function hashPassword(password) {
    return __awaiter(this, void 0, void 0, function* () {
        return yield bcrypt.hash(password, config.bcrypt.saltRounds);
    });
}
export function create(user) {
    return __awaiter(this, void 0, void 0, function* () {
        user.password = yield hashPassword(user.password);
        const created = { data: user, id: Date.now().toString(), likeStores: [] };
        userDatas.push(created);
        return;
    });
}
export function findByUserID(userID) {
    return __awaiter(this, void 0, void 0, function* () {
        return userDatas.find((user) => user.data.userID === userID);
    });
}
export function findByID(id) {
    return __awaiter(this, void 0, void 0, function* () {
        return userDatas.find((user) => user.id === id);
    });
}
export function checkByUserID(userID) {
    return __awaiter(this, void 0, void 0, function* () {
        let checkValue = userDatas.find((user) => user.data.userID === userID);
        if (checkValue === undefined) {
            return true;
        }
        return false;
    });
}
export function getAllUser() {
    return __awaiter(this, void 0, void 0, function* () {
        return userDatas;
    });
}
export function findLikeStoresById(id) {
    return __awaiter(this, void 0, void 0, function* () {
        let data = userDatas.find((data) => data.id === id);
        return data === null || data === void 0 ? void 0 : data.likeStores;
    });
}
export function addOrRemoveLikeStore(id, storeCode) {
    return __awaiter(this, void 0, void 0, function* () {
        let user = userDatas.find((user) => user.id === id);
        if (user === undefined) {
            throw new Error('No User');
        }
        let isDelete = false;
        let hasStore = user === null || user === void 0 ? void 0 : user.likeStores.filter((code) => {
            if (code == storeCode) {
                isDelete = true;
                return false;
            }
            return true;
        });
        if (isDelete == false) {
            hasStore === null || hasStore === void 0 ? void 0 : hasStore.unshift(storeCode);
        }
        user.likeStores = hasStore;
        return !isDelete;
    });
}
