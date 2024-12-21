import * as Post from "../model/Post";

export const home = async (req, res) => {
  const posts = await Post.getAllPost();
  res.render("home", { pageTitle: "Home", posts });
};
