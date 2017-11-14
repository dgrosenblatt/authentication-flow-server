defmodule AuthenticationFlowServer.AccountsTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.{Accounts, Accounts.User, Accounts.PasswordReset}
  alias Calendar.DateTime

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

  describe "create_password_reset/1" do
    test "persists and returns a password reset" do
      user = insert(:user)
      params = %{user_id: user.id, token: "abc", expired_at: DateTime.now_utc(),
        redeemed_at: nil}

      assert {:ok, %PasswordReset{}} = Accounts.create_password_reset(params)
      assert Repo.aggregate(PasswordReset, :count, :id) == 1
    end
  end

  describe "build_password_reset/1" do
    test "assembles attributes for a password reset when the provided email is associated with a user" do
      email = "test@email.com"
      user = insert(:user, email: email)

      assert {:ok, %{
        token: token,
        user_id: user_id,
        redeemed_at: nil,
        expired_at: expired_at}
      } = Accounts.build_password_reset(email)

      {:ok, expired_at_dt} = DateTime.from_naive(expired_at, "Etc/UTC")
      assert DateTime.after?(expired_at_dt, DateTime.now_utc())
      assert user_id == user.id
      refute is_nil(token)
    end

    test "returns an error when provided an unknown email" do
      assert {:error, :not_found} = Accounts.build_password_reset("fake@email.com")
    end
  end

  describe "reset_user_password/2" do
    test "updates a user's password" do
      token = "abc-123"
      user = insert(:user, encrypted_password: @encrypted_password)
      insert(:password_reset, user: user, token: token)

      assert {:ok, %User{
        encrypted_password: encrypted_password
      }} = Accounts.reset_user_password(token, "new-password-1234")
      refute encrypted_password == @encrypted_password
    end

    test "returns an error when the token is invalid" do
      assert {:error, _} = Accounts.reset_user_password("faketoken", "new-password-1234")
    end
  end
end
