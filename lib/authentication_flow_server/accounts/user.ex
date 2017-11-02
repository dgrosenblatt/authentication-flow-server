defmodule AuthenticationFlowServer.Accounts.User do
  @moduledoc """
  User struct, schema, and changeset functions
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.MovieReviews.Review

  @type t :: %__MODULE__{
    id: String.t,
    email: String.t,
  }

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    has_many :reviews, Review

    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password])
    |> validate_required([:email, :encrypted_password])
    |> unique_constraint(:email)
  end
end
