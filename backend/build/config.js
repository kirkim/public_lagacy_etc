import dotenv from 'dotenv';
import path from 'path';
dotenv.config();
function required(key, defaultValue) {
    const value = process.env[key] || defaultValue;
    if (value == null) {
        throw new Error(`${key} is undefined`);
    }
    return value;
}
const config = {
    host: {
        port: Number(required('HOST_PORT', 8080)),
        url: 'https://kirkim.com',
    },
    bcrypt: {
        saltRounds: parseInt(required('BCRTPY_SALT_ROUNDS', 10)),
    },
    static: {
        url: required('BASE_URL', path.resolve() + '/assets'),
    },
    server: {
        baseUrl: required('PORT', 4000),
    },
};
export default config;
