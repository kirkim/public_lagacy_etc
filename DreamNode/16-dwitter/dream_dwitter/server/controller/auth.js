import * as authRepository from "../data/auth.js";

export async function signup(req, res, next) {
  const { username, password, name, email, url } = req.body;
  const auth = await authRepository.create(
    username,
    password,
    name,
    email,
    url,
  );
  if (auth) {
    return res.status(200).json(auth);
  } else {
    res.status(400).json({ message: "already exist username" });
  }
}

export async function login(req, res, next) {
  const { username, password } = req.body;
  const login = await authRepository.checkLogin(username, password);
  if (login) {
    return res.status(200).json(login);
  } else {
    return res.status(400).json({ message: "fail login!" });
  }
}

export async function get(req, res, next) {}
