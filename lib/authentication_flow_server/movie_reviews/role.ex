defmodule AuthenticationFlowServer.MovieReviews.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.MovieReviews.{Actor, Movie}

  schema "roles" do
    belongs_to :movie, Movie
    belongs_to :actor, Actor

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = role, attrs) do
    role
    |> cast(attrs, [])
    |> validate_required([])
  end
end
