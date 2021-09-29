import Video from "../models/Video";

export const home = async (req, res) => {
  try {
    const videos = await Video.find({});
    return res.render("home", { pageTitle: "Home", videos });
  } catch {
    return res.send("error!");
  }
};

export const getUpload = (req, res) => {
  return res.render("upload", { pageTitle: "Upload Video" });
};

export const postUpload = async (req, res) => {
  const { title, text } = req.body;
  try {
    await Video.create({
      title: title,
      text: text,
    });
  } catch (error) {
    return res.render("upload", {
      pageTitle: "Upload Video",
      errorMessage: error._message,
    });
  }
  return res.redirect("/");
};

export const watch = async (req, res) => {
  const { id } = req.params;
  const video = await Video.findById(id);
  return res.render("details", { pageTitle: video.title, video });
};
