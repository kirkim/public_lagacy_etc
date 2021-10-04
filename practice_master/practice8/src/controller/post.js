import * as Post from "../model/Post";

export const get = (req, res) => {
  res.render("uploadPost", { pageTitle: "Post" });
};

export const post = async (req, res) => {
  const { title, content } = req.body;
  const pageTitle = "Post";
  try {
    await Post.create(title, content, res.locals.loggedInUser);
  } catch (error) {
    console.log(error);
    return res.status(400).render("uploadPost", { pageTitle, errorMessage: "fail post" });
  }
  return res.redirect("/");
};
