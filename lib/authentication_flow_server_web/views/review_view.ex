defmodule AuthenticationFlowServerWeb.ReviewView do
  use AuthenticationFlowServerWeb, :view

  def render("show.json", %{review: review}) do
    %{review: render_one(review, __MODULE__, "review.json")}
  end

  def render("create.json", %{review: review}) do
    %{review: render_one(review, __MODULE__, "review.json")}
  end

  def render("update.json", %{review: review}) do
    %{review: render_one(review, __MODULE__, "review.json")}
  end

  def render("index.json", %{reviews: reviews}) do
    %{reviews: render_many(reviews, __MODULE__, "review.json")}
  end

  def render("review.json", %{review: review}) do
    %{id: review.id,
      updated_at: review.updated_at,
      inserted_at: review.inserted_at,
      movie: render("movie.json", %{movie: review.movie}),
      user: render("user.json", %{user: review.user}),
      body: review.body,
      rating: review.rating}
  end

  def render("movie.json", %{movie: movie}) do
    %{id: movie.id,
      inserted_at: movie.inserted_at,
      updated_at: movie.updated_at,
      name: movie.name,
      release_date: movie.release_date}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at,
      email: user.email}
  end
end
