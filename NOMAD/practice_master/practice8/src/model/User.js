import mongoose from "mongoose";
import bcrypt from "bcrypt";

const userSchema = mongoose.Schema({
  name: { type: String, required: true },
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  address: { type: String },
});

userSchema.pre("save", async function () {
  this.password = await bcrypt.hash(this.password, 5);
});

export const model = mongoose.model("User", userSchema);
export async function existUserName(username) {
  const exists = await model.exists({ username });
  return exists;
}
export async function create(name, username, password, address) {
  try {
    await model.create({
      name,
      username,
      password,
      address,
    });
  } catch (error) {
    throw error;
  }
}
export async function login(username, password) {
  const user = await model.findOne({ username });
  if (!user) {
    return false;
  }
  const ok = await bcrypt.compare(password, user.password);
  if (!ok) {
    return false;
  }
  return user;
}
