defmodule AuthenticationFlowServer.Accounts.PasswordReset do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.Accounts.User

  schema "password_resets" do
    field :expired_at, :naive_datetime
    field :redeemed_at, :naive_datetime
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(%__MODULE__{} = password_reset, attrs) do
    password_reset
    |> cast(attrs, [:token, :expired_at, :redeemed_at, :user_id])
    |> foreign_key_constraint(:user_id)
    |> validate_required([:expired_at, :token, :user_id])
  end
end
