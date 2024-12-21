import mongoose from "mongoose";

const videoSchema = new mongoose.Schema({
  title: { type: String, required: true, trim: true },
  text: { type: String, required: true, maxLength: 200 },
});

const Video = mongoose.model("Video", videoSchema);

export default Video;
