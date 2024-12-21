import * as User from "../model/User";
export const getLogin = (req, res, next) => {
  res.render("login", { pageTitle: "Login" });
};

export const getJoin = (req, res, next) => {
  res.render("join", { pageTitle: "Join" });
};

export const postJoin = async (req, res, next) => {
  const pageTitle = "Join";
  const { name, username, password, password2, address } = req.body;
  const exist = await User.existUserName(username);
  console.log(exist);
  if (exist) {
    return res.status(400).render("join", {
      pageTitle,
      errorMessage: "This username is already taken.",
    });
  }
  if (password !== password2) {
    return res.status(400).render("join", {
      pageTitle,
      errorMessage: "Password confirmation does not match.",
    });
  }
  try {
    await User.create(name, username, password, address);
    return res.redirect("/login");
  } catch (error) {
    console.log(error);
    return res.status(400).render("join", {
      pageTitle,
      errorMessage: error._message,
    });
  }
};

export const postLogin = async (req, res, next) => {
  const pageTitle = "Login";
  const { username, password } = req.body;
  const exist = User.existUserName(username);
  if (!exist) {
    return res
      .status(400)
      .render("login", { pageTitle, errorMessage: "Confirm your Username!" });
  }
  const user = await User.login(username, password);
  if (!user) {
    return res.status(400).render("login", {
      pageTitle,
      errorMessage: "Wrong pasword",
    });
  }
  req.session.loggedIn = true;
  req.session.user = user;

  return res.redirect("/");
};

export const logout = (req, res, next) => {
  req.session.loggedIn = false;
  return res.redirect("/");
};
