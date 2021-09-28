import Video from "../models/Video";

/*
Video.find({}, (error, videos) => {     // find 안기다려줌
	if (error) {
		return res.render("server-error")
	}
	return res.render("home", { pageTitle: "Home", videos: [] });
});
*/

export const home = async (req, res) => {
  try {
    const videos = await Video.find({}).sort({ createdAt: "desc" }); /// find()할떄까지 기다려줌
    return res.render("home", { pageTitle: "Home", videos });
  } catch {
    return res.render("server-error");
  }
};
export const watch = async (req, res) => {
  const { id } = req.params;
  const video = await Video.findById(id);
  if (video === null) {
    return res.render("404", { pageTitle: "Video not found." });
  }
  return res.render("watch", { pageTitle: video.title, video });
};

export const getEdit = async (req, res) => {
  const { id } = req.params;
  const video = await Video.findById(id);
  if (!video) {
    return res.render("404", { pageTitle: "Video not found." });
  }
  return res.render("edit", { pageTitle: `Edit: ${video.title}`, video });
};

export const postEdit = async (req, res) => {
  const { id } = req.params;
  const { title, description, hashtags } = req.body;
  //const video = await Video.findById(id);
  const video = await Video.exists({ _id: id }); // video 오브젝트가 필요없고 boolean만 알면되므로 exists()를 이용하여 존제하는지만 알아본다
  if (!video) {
    return res.render("404", { pageTitle: "Video not found." });
  }
  await Video.findByIdAndUpdate(id, {
    title,
    description,
    hashtags: Video.formatHashtags(hashtags),
  });
  //   video.title = title;
  //   video.description = description;
  //   video.hashtags = hashtags
  //     .split(",")
  //     .map((word) => (word.startsWith("#") ? word : `#${word}`));
  //   await video.save();
  return res.redirect(`/videos/${id}`);
};

export const getUpload = (req, res) => {
  return res.render("upload", { pageTitle: "Upload Video" });
};

export const postUpload = async (req, res) => {
  // here we will add a video to the videos array.
  const { title, description, hashtags } = req.body;
  /*
  const video = new Video({
    title: title,
    description: description,
    createdAt: Date.now(),
    hashtags: hashtags.split(",").map((word) => `#${word}`),
    meta: {
      views: 0,
      rating: 0,
    },
  });
	await video.save();
	*/
  try {
    await Video.create({
      title: title,
      description: description,
      hashtags: Video.formatHashtags(hashtags),
    });
  } catch (error) {
    return res.render("upload", {
      pageTitle: "Upload Video",
      errorMessage: error._message,
    });
  }

  return res.redirect("/");
};

export const deleteVideo = async (req, res) => {
  const { id } = req.params;
  await Video.findByIdAndDelete(id);
  return res.redirect("/");
};

export const search = async (req, res) => {
  const { keyword } = req.query;
  let videos = [];
  if (keyword) {
    videos = await Video.find({
      title: {
        $regex: new RegExp(`${keyword}$`, "i"),
      },
    });
  }
  return res.render("search", { pageTitle: "Search", videos });
};
