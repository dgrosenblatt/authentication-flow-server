defmodule AuthenticationFlowServer.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :s3_object_key, :string

      timestamps()
    end
  end
end
