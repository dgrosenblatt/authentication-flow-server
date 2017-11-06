defmodule AuthenticationFlowServer.MovieReviews do
  alias AuthenticationFlowServer.MovieReviews.Review
  alias AuthenticationFlowServer.Repo

  def create_review(%{} = attrs) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  def update_review(%Review{} = review, attrs \\ %{}) do
    review
    |> Review.update_changeset(attrs)
    |> Repo.update
  end
end
