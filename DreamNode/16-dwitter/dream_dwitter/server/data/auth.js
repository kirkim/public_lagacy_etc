import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";

let auths = [];

export async function create(username, password, name, email, url) {
  if (auths.find((a) => a.username === username)) {
    return false;
  }
  const token = jwt.sign(
    {
      id: username,
      isAdmin: false,
    },
    bcrypt.hashSync(password, 10),
  );
  const auth = {
    username,
    password,
    name,
    email,
    url,
    token,
  };
  auths = [auth, ...auths];
  return { username, token };
}

export async function checkLogin(username, password) {
  const user = auths.find((auth) => auth.username === username);
  if (!user) {
    return false;
  }
  const token = user.token;
  jwt.verify(token, password, (error, decoded) => {
    if (error) {
      return false;
    }
  });
  return { username, token };
}
