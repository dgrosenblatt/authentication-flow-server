defmodule AuthenticationFlowServerWeb.ReviewView do
  use AuthenticationFlowServerWeb, :view

  def render("review.json", %{review: review}) do
    %{review: %{
        id: review.id,
        updated_at: review.updated_at,
        inserted_at: review.inserted_at,
        movie_id: review.movie_id,
        user_id: review.user_id,
        body: review.body,
        rating: review.rating}
    }
  end
end
