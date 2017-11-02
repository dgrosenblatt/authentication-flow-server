defmodule AuthenticationFlowServer.AccountsTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.{Accounts, Accounts.User}

  @password "password1"
  @encrypted_password Comeonin.Bcrypt.hashpwsalt(@password)

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

  describe "find_or_create_user_by_email/1" do
    test "returns an existing user if one exists for provided email" do
      email = "ex@mp.le"
      insert(:user, email: email, encrypted_password: "")
      {:ok, user} = Accounts.find_or_create_user_by_email(email)
      user_count = Repo.aggregate(User, :count, :id)

      assert user_count == 1
      assert %User{email: ^email} = user
    end

    test "creates a user for a new email" do
      email = "ex@mp.le"
      {:ok, user} = Accounts.find_or_create_user_by_email(email)
      user_count = Repo.aggregate(User, :count, :id)

      assert user_count == 1
      assert %User{email: ^email} = user
    end
  end

  describe "authenticate_email_password/1" do
    test "returns a user when email is associated with a user and password is correct" do
      insert(:user, email: "ex@mp.le", encrypted_password: @encrypted_password)

      assert {:ok, %User{email: "ex@mp.le"}} =
        Accounts.authenticate_email_password(%{"email" => "ex@mp.le", "password" => @password})

    end

    test "returns an error when email does not exist" do
      assert {:error, :unauthorized} =
        Accounts.authenticate_email_password(%{"email" => "fake", "password" => ""})
    end

    test "return an error when password is incorrect" do
      insert(:user, email: "ex@mp.le", encrypted_password: @encrypted_password)

      assert {:error, :unauthorized} =
        Accounts.authenticate_email_password(%{"email" => "ex@mp.le", "password" => "wrongpass"})
    end
  end
end
