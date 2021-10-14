const jwt = require("jsonwebtoken");

const secret = "qvWopD*P6U!$1teeOU$L4S2u#Ge&8scj";
const token = jwt.sign(
  {
    id: "kirkim",
    isAdmin: false,
  },
  secret,
  { expiresIn: 2 },
);
setTimeout(() => {
  jwt.verify(token, secret, (error, decoded) => {
    console.log(error, decoded);
  });
}, 2000);
