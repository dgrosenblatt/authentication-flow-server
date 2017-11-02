defmodule AuthenticationFlowServer.MovieReviews.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.MovieReviews.{Actor, Director, Review, Role}

  schema "movies" do
    field :name, :string
    field :release_date, :date
    belongs_to :director, Director
    has_many :reviews, Review
    many_to_many :actors, Actor, join_through: Role

    timestamps()
  end

  def changeset(%__MODULE__{} = movie, attrs) do
    movie
    |> cast(attrs, [:name, :release_date])
    |> validate_required([:name, :release_date])
  end
end
