defmodule AuthenticationFlowServer.MovieReviews.Actor do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.MovieReviews.{Movie, Role}

  schema "actors" do
    field :name, :string
    many_to_many :movies, Movie, join_through: Role

    timestamps()
  end

  def changeset(%__MODULE__{} = actor, attrs) do
    actor
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
