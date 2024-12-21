import * as tweetRepository from "../data/tweet.js";

export const getTweets = async (req, res, next) => {
  const username = req.query.username;
  const data = await (username
    ? tweetRepository.getAllByUsername(username)
    : tweetRepository.getAll());
  return res.status(200).json(data);
};

export const getTweet = async (req, res, next) => {
  const id = req.params.id;
  const tweet = await tweetRepository.getById(id);
  if (tweet) {
    return res.status(200).json(tweet);
  } else {
    return res.status(404).json({ message: `Tweet id(${id}) not found` });
  }
};

export const createTweet = async (req, res, next) => {
  const { text, name, username } = req.body;
  const tweet = await tweetRepository.create(text, name, username);
  return res.status(201).json(tweet);
};

export const updateTweet = async (req, res, next) => {
  const id = req.params.id;
  const text = req.body.text;
  const tweet = await tweetRepository.update(id, text);
  if (tweet) {
    return res.status(200).json(tweet);
  } else {
    return res.status(404).json({ message: `Tweet id(${id}) not found` });
  }
};

export const deleteTweet = async (req, res, next) => {
  const id = req.params.id;
  await tweetRepository.remove(id);
  return res.sendStatus(204);
};
