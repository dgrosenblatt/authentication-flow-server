defmodule AuthenticationFlowServer.MovieReviews do
  alias AuthenticationFlowServer.MovieReviews.Review
  alias AuthenticationFlowServer.Repo

  def create_review(%{} = attrs) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end
end
