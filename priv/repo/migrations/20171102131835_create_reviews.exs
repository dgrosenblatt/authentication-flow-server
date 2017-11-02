defmodule AuthenticationFlowServer.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :rating, :integer
      add :body, :string
      add :movie_id, references(:movies, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:reviews, [:movie_id])
    create index(:reviews, [:user_id])
  end
end
