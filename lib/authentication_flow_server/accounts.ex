defmodule AuthenticationFlowServer.Accounts do
  import Ecto.Query
  alias AuthenticationFlowServer.Repo
  alias AuthenticationFlowServer.Accounts.{PasswordReset, User}
  alias Calendar.DateTime
  alias Comeonin.Bcrypt

  @password_reset_expiration_seconds 3600

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

  def create_password_reset(email) do
    user_id =
      from(u in User, select: u.id, where: u.email == ^email)
      |> Repo.one

    new_password_reset_attrs = %{
      user_id: user_id,
      token: Ecto.UUID.generate(),
      redeemed_at: nil,
      expired_at: DateTime.add!(DateTime.now_utc(), @password_reset_expiration_seconds)
    }

    %PasswordReset{}
    |> PasswordReset.changeset(new_password_reset_attrs)
    |> Repo.insert
  end
end
