import mongoose from "mongoose";

const postSchema = new mongoose.Schema({
  title: { type: String, required: true, trim: true },
  content: { type: String, required: true },
  user: { type: Object, required: true },
});

export const model = mongoose.model("Post", postSchema);

export async function create(title, content, user) {
  try {
    await model.create({
      title,
      content,
      user,
    });
  } catch (error) {
    throw error;
  }
}

export async function getAllPost() {
  return await model.find();
}
