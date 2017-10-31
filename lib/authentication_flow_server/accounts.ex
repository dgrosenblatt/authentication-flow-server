defmodule AuthenticationFlowServer.Accounts do
  alias AuthenticationFlowServer.Repo
  alias AuthenticationFlowServer.Accounts.User
  alias Comeonin.Bcrypt

  @doc """
  Accepts a user email and password map, hashes the password, and inserts user
  """
  def create_user(user_params) do
    encrypted_password_params = encrypt_password(user_params)

    %User{}
    |> User.changeset(encrypted_password_params)
    |> Repo.insert()
  end

  defp encrypt_password(%{"email" => email, "password" => password}) do
    %{"email" => email,
      "encrypted_password" => Bcrypt.hashpwsalt(password)}
  end
end
