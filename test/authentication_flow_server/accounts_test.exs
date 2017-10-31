defmodule AuthenticationFlowServer.AccountsTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.{Accounts, Accounts.User}

  describe "create_user/1" do
    test "persists and returns a User" do
      email = "test@example.com"
      user_params = %{"email" => email, "password" => "password1"}
      {:ok, user} = Accounts.create_user(user_params)
      user_count = Repo.aggregate(User, :count, :id)

      assert user_count == 1
      assert %User{email: "test@example.com"} = user
      assert !is_nil(user.encrypted_password)
    end
  end
end
