var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { reviewData } from './data/reviewStorage.js';
import { getStoreInfo } from './deliveryData.js';
export function getReviewDataForSummary(storeCode) {
    let totalCount = 0;
    let sumRating = 0;
    reviewData.forEach((review) => {
        if (review.storeInfo.storeCode === storeCode) {
            totalCount += 1;
            sumRating += review.rating;
            return true;
        }
        return false;
    });
    if (totalCount === 0) {
        return {
            average: 0,
            count: 0,
        };
    }
    let result = {
        average: sumRating / totalCount,
        count: totalCount,
    };
    return result;
}
export function getAllReviews(storeCode) {
    return __awaiter(this, void 0, void 0, function* () {
        let totalCount = 0;
        let sumRating = 0;
        let reviews = reviewData.filter((review) => {
            if (review.storeInfo.storeCode === storeCode) {
                totalCount += 1;
                sumRating += review.rating;
                return true;
            }
            return false;
        });
        if (reviews == undefined) {
            return undefined;
        }
        let reviewJson = {
            reviews: reviews,
            averageRating: sumRating / totalCount,
            storeInfo: getStoreInfo(storeCode),
        };
        return reviewJson;
    });
}
export function getReviews(storeCode, count) {
    return __awaiter(this, void 0, void 0, function* () {
        let reviews = [];
        let flag = 0;
        for (let i = 0; i < reviewData.length; i++) {
            let review = reviewData[i];
            if (review.storeInfo.storeCode === storeCode && review.photoUrl !== undefined) {
                flag++;
                reviews.push(review);
            }
            if (flag === count) {
                break;
            }
        }
        if (reviews == undefined) {
            return undefined;
        }
        return reviews;
    });
}
export function getReviewsById(id) {
    return __awaiter(this, void 0, void 0, function* () {
        let reviews = [];
        reviewData.forEach((review) => {
            if (review.userInfo.id == id) {
                reviews.push(review);
            }
        });
        return reviews;
    });
}
