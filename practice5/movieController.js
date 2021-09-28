/*
You DONT have to import the Movie with your username.
Because it's a default export we can nickname it whatever we want.
So import Movie from "./models"; will work!
You can do Movie.find() or whatever you need like normal!
*/
import model from "./models/Movie";

// Add your magic here!

export const home = async (req, res) => {
  try {
    const videos = await model.find({}).sort({ createdAt: "desc" });
    return res.render("home", { pageTitle: "Home", videos });
  } catch {
    return res.render("server-error");
  }
};

export const getUpload = (req, res) => {
  return res.render("upload", { pageTitle: "Upload Video" });
};

export const postUpload = async (req, res) => {
  const { title, summary, year, rating, genres } = req.body;
  console.log(title, summary, year, rating, genres);
  try {
    await model.create({
      title: title,
      summary: summary,
      year: year,
      rating: rating,
      genres: model.formatGenres(genres),
    });
  } catch (error) {
    console.log(error);
    return res.render("upload", {
      pageTitle: "Upload Video",
      errorMessage: error._message,
    });
  }

  return res.redirect("/");
};

export const watch = async (req, res) => {
  const { id } = req.params;
  const video = await model.findById(id);
  if (video === null) {
    return res.render("404", { pageTitle: "Video not found." });
  }
  return res.render("watch", { pageTitle: video.title, video });
};

export const postEdit = async (req, res) => {
  const { id } = req.params;
  const { title, summary, year, rating, genres } = req.body;

  const video = await model.exists({ _id: id });
  if (!video) {
    return res.render("404", { pageTitle: "Movie not found." });
  }
  await model.findByIdAndUpdate(id, {
    title,
    summary,
    year,
    rating,
    genres: model.formatGenres(genres),
  });

  return res.redirect(`/movies/${id}`);
};

export const getEdit = async (req, res) => {
  const { id } = req.params;
  const video = await model.findById(id);
  if (!video) {
    return res.render("404", { pageTitle: "Movie not found." });
  }
  return res.render("edit", { pageTitle: `Edit: ${video.title}`, video });
};

export const deleteMovie = async (req, res) => {
  const { id } = req.params;
  await model.findByIdAndDelete(id);
  return res.redirect("/");
};

export const search = async (req, res) => {
  const { keyword } = req.query;
  let videos = [];
  if (keyword) {
    videos = await model.find({
      title: {
        $regex: new RegExp(`${keyword}$`, "i"),
      },
    });
  }
  return res.render("search", { pageTitle: "Search", videos });
};
