defmodule AuthenticationFlowServer.MovieReviews.Review.Query do
  import Ecto.Query
  alias AuthenticationFlowServer.MovieReviews.Review
  alias AuthenticationFlowServer.Repo

  def all_by_user_id(user_id) do
    Review
    |> where(user_id: ^user_id)
    |> Repo.all
  end

  def get_by_id_for_user(id, user_id) do
    Review
    |> Repo.get_by(id: id, user_id: user_id)
  end
end
