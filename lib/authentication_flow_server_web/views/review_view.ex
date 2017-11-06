defmodule AuthenticationFlowServerWeb.ReviewView do
  use AuthenticationFlowServerWeb, :view

  def render("review.json", %{review: review}) do
    %{review: render_review(review)}
  end

  def render("index.json", %{reviews: reviews}) do
    %{reviews: render_reviews(reviews)}
  end

  defp render_review(review) do
    %{id: review.id,
      updated_at: review.updated_at,
      inserted_at: review.inserted_at,
      movie_id: review.movie_id,
      user_id: review.user_id,
      body: review.body,
      rating: review.rating}
  end

  defp render_reviews(reviews) do
    Enum.map(reviews, &(render_review(&1)))
  end
end
