defmodule AuthenticationFlowServer.Accounts.UserTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.Accounts.User

  describe "changeset/2" do
    test "with valid params" do
      params = %{"email" => "test@example.com", "encrypted_password" => "password1"}
      changeset = User.changeset(%User{}, params)
      assert changeset.valid? == true
    end

    test "with missing required param" do
      params = %{"email" => "", "encrypted_password" => "password1"}
      changeset = User.changeset(%User{}, params)
      assert changeset.valid? == false
    end
  end
end
