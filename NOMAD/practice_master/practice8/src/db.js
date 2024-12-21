import mongoose from "mongoose";

mongoose.connect("mongodb://127.0.0.1:27017/practice8", {});

const db = mongoose.connection;

db.once("open", () => console.log("✅success connect DB!"));
db.on("error", (error) => console.log("DB Error", error));
