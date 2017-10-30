defmodule AuthenticationFlowServer.Factory do
  use ExMachina.Ecto, repo: AuthenticationFlowServer.Repo
  alias AuthenticationFlowServer.Accounts.User

  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      encrypted_password: sequence(:encrypted_password, &"encrypted_password_#{&1}")
    }
  end
end
