defmodule AuthenticationFlowServer.MovieReviews.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.{MovieReviews.Movie, Accounts.User}

  schema "reviews" do
    field :body, :string
    field :rating, :integer
    belongs_to :movie, Movie
    belongs_to :user, User

    timestamps()
  end

  def changeset(%__MODULE__{} = review, attrs) do
    review
    |> cast(attrs, [:rating, :body, :movie_id, :user_id])
    |> foreign_key_constraint(:movie_id)
    |> foreign_key_constraint(:user_id)
    |> validate_required([:rating, :body, :movie_id, :user_id])
  end

  def update_changeset(%__MODULE__{} = review, attrs) do
    review
    |> cast(attrs, [:rating, :body])
    |> validate_required([:rating, :body, :movie_id, :user_id])
  end
end
