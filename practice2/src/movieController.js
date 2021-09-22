import {
  getMovieById,
  getMovies,
  getMovieByMinimumRating,
  getMovieByMinimumYear,
} from "./db";

export const home = (req, res) => {
  const movies = getMovies();
  return res.render("index", { pageTitle: "Movies!", movies });
};

export const movieDetail = (req, res) => {
  const { id } = req.params;
  const { title } = getMovieById(id);
  const movies = getMovieById(id);
  return res.render("detail", { pageTitle: `${title}`, movies });
};

export const filterMovie = (req, res) => {
  const { year } = req.query;
  const { rating } = req.query;
  if (year !== "") {
    return res.render("index", {
      pageTitle: `Searching by year: ${year}`,
      movies: getMovieByMinimumYear(year),
    });
  } else if (rating !== "") {
    return res.render("index", {
      pageTitle: `Searching by rating: ${rating}`,
      movies: getMovieByMinimumRating(rating),
    });
  } else {
    return res.render("index", {
      pageTitle: `Movies!`,
      movies: getMovieByMinimumRating(1),
    });
  }
};
