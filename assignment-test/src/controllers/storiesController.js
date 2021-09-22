export const home = (req, res) => res.render("home");
export const trending = (req, res) => res.render("trending");
export const newStories = (req, res) => res.send("<h1>newStories</h1>");
export const seeStory = (req, res) => res.send(`<h1>seeStory: ${req.params.id}</h1>`);
export const editStory = (req, res) => res.send(`<h1>editStory: ${req.params.id}</h1>`);
export const deleteStory = (req, res) => res.send(`<h1>deleteStory: ${req.params.id}</h1>`);
