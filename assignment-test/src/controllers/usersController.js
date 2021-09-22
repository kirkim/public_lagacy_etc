export const join = (req, res) => res.send("<h1>join</h1>");
export const login = (req, res) => res.send("<h1>login</h1>");
export const seeUsers = (req, res) => res.send("<h1>seeUsers</h1>");
export const seeUser = (req, res) => res.send(`<h1>seeUser: ${req.params.id}</h1>`);
export const editProfile = (req, res) => res.send("<h1>editProfile</h1>");
