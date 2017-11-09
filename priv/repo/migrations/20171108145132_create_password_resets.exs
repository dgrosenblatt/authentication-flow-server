defmodule AuthenticationFlowServer.Repo.Migrations.CreatePasswordResets do
  use Ecto.Migration

  def change do
    create table(:password_resets) do
      add :token, :string
      add :expired_at, :naive_datetime
      add :redeemed_at, :naive_datetime
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:password_resets, [:user_id])
  end
end
