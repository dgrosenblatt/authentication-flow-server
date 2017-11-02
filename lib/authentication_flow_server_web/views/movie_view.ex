defmodule AuthenticationFlowServerWeb.MovieView do
  use AuthenticationFlowServerWeb, :view
  alias AuthenticationFlowServer.MovieReviews.{Actor, Director, Movie, Review}
  alias AuthenticationFlowServer.Accounts.User

  def render("index.json", %{movies: movies}) do
    %{movies: render_movies(movies)}
  end

  def render("movie.json", %Movie{} = movie) do
    %{id: movie.id,
      inserted_at: movie.inserted_at,
      updated_at: movie.updated_at,
      name: movie.name,
      release_date: movie.release_date,
      director: render("director.json", movie.director),
      actors: render_actors(movie.actors),
      reviews: render_reviews(movie.reviews)}
  end

  def render("director.json", %Director{} = director) do
    %{id: director.id,
      inserted_at: director.inserted_at,
      updated_at: director.updated_at,
      name: director.name}
  end

  def render("actor.json", %Actor{} = actor) do
    %{id: actor.id,
      inserted_at: actor.inserted_at,
      updated_at: actor.updated_at,
      name: actor.name}
  end

  def render("review.json", %Review{} = review) do
    %{id: review.id,
      inserted_at: review.inserted_at,
      updated_at: review.updated_at,
      body: review.body,
      rating: review.rating,
      reviewer: render("user.json", review.user)}
  end

  def render("user.json", %User{} = user) do
    %{id: user.id,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at,
      email: user.email}
  end

  defp render_movies(movies) do
    Enum.map(movies, &(render("movie.json", &1)))
  end

  defp render_actors(actors) do
    Enum.map(actors, &(render("actor.json", &1)))
  end

  defp render_reviews(reviews) do
    Enum.map(reviews, &(render("review.json", &1)))
  end
end
