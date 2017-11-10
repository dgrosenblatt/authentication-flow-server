defmodule AuthenticationFlowServer.Accounts.User.Query do
  import Ecto.Query
  alias AuthenticationFlowServer.{Accounts.User, Repo}

  def get_by_email(email), do: Repo.get_by(User, email: email)

  def get_user_id_by_email(email) do
    Repo.one(from u in User, select: u.id, where: u.email == ^email)
  end
end
