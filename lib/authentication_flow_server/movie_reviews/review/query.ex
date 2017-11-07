defmodule AuthenticationFlowServer.MovieReviews.Review.Query do
  import Ecto.Query
  alias AuthenticationFlowServer.MovieReviews.Review
  alias AuthenticationFlowServer.Repo

  def all_by_user_id(user_id) do
    Review
    |> where(user_id: ^user_id)
    |> Repo.all
  end
end
