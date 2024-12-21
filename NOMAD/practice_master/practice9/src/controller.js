import fs from "fs";

export const getHome = async (req, res) => {
  fs.readdir("./uploads", (error, files) => {
    if (error) {
      console.log(error);
      return res.send("error");
    }
    return res.render("home", { pageTitle: "TXT2HTML!", files });
  });
};

export const postText = (req, res) => {
  const file = req.file.filename;
  return res.redirect(`/read/${file}`);
};

export const getRead = (req, res) => {
  return res.redirect("/");
};

export const getDetail = (req, res) => {
  const filename = req.params.id;
  fs.readFile(`./uploads/${filename}`, (error, file) => {
    if (error) {
      console.log(error);
      return res.send("error");
    }
    return res.render("detail", { file });
  });
};
