import dotenv from 'dotenv';
import path from 'path';

dotenv.config();

function required(key, defaultValue = undefined) {
  const value = process.env[key] || defaultValue;
  if (value == null) {
    throw new Error(`${key} is undefined`);
  }
  return value;
}

const config = {
  host: {
    port: parseInt(required('HOST_PORT', 8080)),
  },
};

export default config;
