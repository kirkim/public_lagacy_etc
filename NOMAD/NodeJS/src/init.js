import 'regenerator-runtime/runtime';
import 'dotenv/config';
import './db';
import './models/Video';
import './models/User';
import './models/Comment';
import app from './server';

const PORT = 4000;
console.log(process.env);
const handleListening = () => {
  console.log(`Server listenting on port http://localhost:${PORT} 🌻`);
};
app.listen(PORT, handleListening);
