import app from "./server.js";
import "./db.js";

const PORT = 8080;
app.listen(PORT, () => console.log(`connect http://localhost:${PORT}`));
