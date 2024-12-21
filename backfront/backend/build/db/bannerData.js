var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import fs from 'fs';
import config from '../config.js';
let datas;
export function getAllBanner() {
    return __awaiter(this, void 0, void 0, function* () {
        return datas;
    });
}
function updateData() {
    fs.readdir(config.static.url + '/banner', (_err, files) => {
        let banners = [];
        files.forEach((fileString) => {
            let fileUrl = config.server.baseUrl + '/banner/' + fileString;
            let data = {
                imageUrl: fileUrl,
                index: 1,
            };
            banners.push(data);
        });
        let bundle = {
            bannersCount: banners.length,
            banners: banners,
            updatedAt: new Date(),
        };
        datas = bundle;
    });
}
updateData();
