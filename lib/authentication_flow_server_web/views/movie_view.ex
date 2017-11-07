defmodule AuthenticationFlowServerWeb.MovieView do
  use AuthenticationFlowServerWeb, :view
  alias AuthenticationFlowServer.MovieReviews.{Actor, Director, Movie, Review}
  alias AuthenticationFlowServer.Accounts.User

  @doc """
  V1 of the API nests associated records
  """
  def render("index_v1.json", %{movies: movies}) do
    %{movies: render_movies(movies, :v1)}
  end

  @doc """
  V2 of the API side-loads associated records
  """
  def render("index_v2.json", %{movies: movies}) do
    directors =
      movies
      |> Stream.map(&(&1.director))
      |> Stream.uniq()
      |> Stream.map(&render("director.json", &1))
      |> Enum.into([])

    actors =
      movies
      |> Stream.flat_map(&(&1.actors))
      |> Stream.uniq()
      |> Stream.map(&render("actor.json", &1))
      |> Enum.into([])

    reviews_preloaded_users = Enum.flat_map(movies, &(&1.reviews))
    reviews = Enum.map(reviews_preloaded_users, &render("review_v2.json", &1))

    users =
      reviews_preloaded_users
      |> Stream.map(&(&1.user))
      |> Stream.uniq()
      |> Stream.map(&render("user.json", &1))
      |> Enum.into([])

    %{movies: render_movies(movies, :v2),
      directors: directors,
      actors: actors,
      reviews: reviews,
      users: users}
  end

  def render("movie_v1.json", %Movie{} = movie) do
    %{id: movie.id,
      inserted_at: movie.inserted_at,
      updated_at: movie.updated_at,
      name: movie.name,
      release_date: movie.release_date,
      director: render("director.json", movie.director),
      actors: render_actors(movie.actors),
      reviews: render_reviews(movie.reviews)}
  end

  def render("movie_v2.json", %Movie{} = movie) do
    actor_ids = Enum.map(movie.actors, &(&1.id))
    review_ids = Enum.map(movie.reviews, &(&1.id))

    %{id: movie.id,
      inserted_at: movie.inserted_at,
      updated_at: movie.updated_at,
      name: movie.name,
      release_date: movie.release_date,
      director_id: movie.director_id,
      actor_ids: actor_ids,
      review_ids: review_ids}
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
      user: render("user.json", review.user)}
  end

  def render("review_v2.json", %Review{} = review) do
    %{id: review.id,
      inserted_at: review.inserted_at,
      updated_at: review.updated_at,
      body: review.body,
      rating: review.rating,
      user_id: review.user_id}
  end

  def render("user.json", %User{} = user) do
    %{id: user.id,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at,
      email: user.email}
  end

  defp render_movies(movies, :v1) do
    Enum.map(movies, &render("movie_v1.json", &1))
  end

  defp render_movies(movies, :v2) do
    Enum.map(movies, &render("movie_v2.json", &1))
  end

  defp render_actors(actors) do
    Enum.map(actors, &render("actor.json", &1))
  end

  defp render_reviews(reviews) do
    Enum.map(reviews, &render("review.json", &1))
  end
end
