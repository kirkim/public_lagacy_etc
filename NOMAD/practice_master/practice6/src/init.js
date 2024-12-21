import app from "./server";
import "./models/Video.js";
import "./db";

const PORT = 8080;
app.listen(PORT, () => console.log(`http://localhost:${PORT}`));
