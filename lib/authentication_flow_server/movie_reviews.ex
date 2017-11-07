defmodule AuthenticationFlowServer.MovieReviews do
  alias AuthenticationFlowServer.Accounts.User
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

  def all_reviews_for_user(%User{id: user_id}) do
    Review.Query.all_by_user_id(user_id)
  end

  def get_review_by_id_for_user(id, %User{id: user_id}) do
    case Repo.get(Review, id) do
      %Review{user_id: ^user_id} = review -> {:ok, review}
      %Review{} -> {:error, :forbidden}
      nil -> {:error, :not_found}
    end
  end
end
