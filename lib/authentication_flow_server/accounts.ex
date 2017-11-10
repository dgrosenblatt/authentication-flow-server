defmodule AuthenticationFlowServer.Accounts do
  import Ecto.Query
  alias __MODULE__.{PasswordReset, PasswordReset.Redemption, User}
  alias AuthenticationFlowServer.Repo
  alias Calendar.DateTime
  alias Comeonin.Bcrypt

  @password_reset_expiration_seconds 3600

  @doc """
  Accepts a user email and password map, hashes the password, and inserts user
  """
  def create_user(%{"email" => email, "password" => password}) do
    user_params = %{
      email: email,
      encrypted_password: Bcrypt.hashpwsalt(password)
    }

    %User{}
    |> User.changeset(user_params)
    |> Repo.insert()
  end

  @doc """
  Finds existing or creates a new user by email
  """
  def find_or_create_user_by_email(email) do
    user = Repo.one(from u in User, where: [email: ^email])

    case user do
      %User{email: ^email} -> {:ok, user}
      nil -> create_google_user(email)
    end
  end

  defp create_google_user(email) do
    create_user(%{"email" => email, "password" => ""})
  end

  @doc """
  Accepts email and password and returns user if password is correct
  """
  @spec authenticate_email_password(map) :: {:ok, User.t} | {:error, :unauthorized}
  def authenticate_email_password(%{"email" => email, "password" => password}) do
    user = Repo.one(from u in User, where: [email: ^email])

    case Bcrypt.check_pass(user, password) do
      {:ok, user} -> {:ok, user}
      {:error, _} -> {:error, :unauthorized}
    end
  end

  def create_password_reset(password_reset_params) do
    %PasswordReset{}
    |> PasswordReset.changeset(password_reset_params)
    |> Repo.insert
  end

  def build_password_reset(email_address) do
    user_id = Repo.one(from u in User, select: u.id, where: u.email == ^email_address)

    case user_id do
      nil ->
        {:error, :not_found}
      id ->
        token = Ecto.UUID.generate()
        expiration =
          DateTime.add!(DateTime.now_utc(), @password_reset_expiration_seconds)

        {:ok, %{user_id: id, token: token, redeemed_at: nil, expired_at: expiration}}
    end
  end

  def reset_user_password(token, new_password) do
    with {:ok, password_reset} <- Redemption.redeem_with_token(token),
         %User{} = user <- Repo.get(User, password_reset.user_id),
         {:ok, user} <- update_user_password(user, new_password)
    do
      {:ok, user}
    end
  end

  defp update_user_password(user, password) do
    user
    |> User.changeset(%{encrypted_password: Bcrypt.hashpwsalt(password)})
    |> Repo.update
  end
end
