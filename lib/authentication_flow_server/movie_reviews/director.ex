defmodule AuthenticationFlowServer.MovieReviews.Director do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.MovieReviews.Movie

  schema "directors" do
    field :name, :string
    has_many :movies, Movie

    timestamps()
  end

  def changeset(%__MODULE__{} = director, attrs) do
    director
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
