var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { storeData } from './data/deliveryStorage.js';
import { getReviewDataForSummary } from './reviewData.js';
export function getStoreInfo(storeCode) {
    var name = '';
    storeData.stores.forEach((store) => {
        if (store.code === storeCode) {
            name = store.storeName;
            return;
        }
    });
    return {
        storeCode: storeCode,
        storeName: name,
    };
}
export function getSummaryStoresByCode(codes) {
    return __awaiter(this, void 0, void 0, function* () {
        let validStores = [];
        codes.forEach((code) => {
            let tempStore = storeData.stores.find((store) => store.code === code);
            if (tempStore !== undefined) {
                validStores.push(tempStore);
            }
        });
        let summaryStores = validStores.map((store) => {
            var _a, _b, _c, _d;
            let reviewData = getReviewDataForSummary(store.code);
            let summaryStore = {
                storeCode: store.code,
                storeType: store.storeType,
                storeName: store.storeName,
                averageRating: reviewData.average,
                reviewCount: reviewData.count,
                minPrice: store.minPrice,
                deliveryPrice: store.deliveryPrice,
                thumbnailUrl: store.thumbnailUrl,
                twoMainMenuName: [
                    (_b = (_a = store.menuSection[0]) === null || _a === void 0 ? void 0 : _a.menu[0]) === null || _b === void 0 ? void 0 : _b.menuName,
                    (_d = (_c = store.menuSection[0]) === null || _c === void 0 ? void 0 : _c.menu[1]) === null || _d === void 0 ? void 0 : _d.menuName,
                ],
            };
            return summaryStore;
        });
        return summaryStores;
    });
}
export function getSummaryStores(type) {
    return __awaiter(this, void 0, void 0, function* () {
        let validStores = storeData.stores.filter((store) => {
            return store.storeType == type;
        });
        let summaryStores = validStores.map((store) => {
            var _a, _b, _c, _d;
            let reviewData = getReviewDataForSummary(store.code);
            let summaryStore = {
                storeCode: store.code,
                storeType: store.storeType,
                storeName: store.storeName,
                averageRating: reviewData.average,
                reviewCount: reviewData.count,
                minPrice: store.minPrice,
                deliveryPrice: store.deliveryPrice,
                thumbnailUrl: store.thumbnailUrl,
                twoMainMenuName: [
                    (_b = (_a = store.menuSection[0]) === null || _a === void 0 ? void 0 : _a.menu[0]) === null || _b === void 0 ? void 0 : _b.menuName,
                    (_d = (_c = store.menuSection[0]) === null || _c === void 0 ? void 0 : _c.menu[1]) === null || _d === void 0 ? void 0 : _d.menuName,
                ],
            };
            return summaryStore;
        });
        return summaryStores;
    });
}
export function getDetailStore(storeCode) {
    return __awaiter(this, void 0, void 0, function* () {
        let store = storeData.stores.find((store) => store.code === storeCode);
        if (store == undefined) {
            return undefined;
        }
        let detailStore = {
            code: store.code,
            storeName: store.storeName,
            deliveryPrice: store.deliveryPrice,
            minPrice: store.minPrice,
            address: store.address,
            bannerPhotoUrl: store.bannerPhotoUrl,
            thumbnailUrl: store.thumbnailUrl,
            menuSection: store.menuSection,
        };
        return detailStore;
    });
}
