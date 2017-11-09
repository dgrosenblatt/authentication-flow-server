defmodule AuthenticationFlowServerWeb.PasswordResetControllerTest do
  use AuthenticationFlowServerWeb.ConnCase
  use Bamboo.Test
  alias AuthenticationFlowServer.Accounts.{PasswordReset, PasswordResetEmail}
  alias AuthenticationFlowServer.Repo

  describe "create/2" do
    test "responds with JSON for a Password Reset and sends an email", %{conn: conn} do
      email = "test@example.com"
      insert(:user, email: email)
      params = %{"email" => email}

      conn =
        conn
        |> accept_headers
        |> post(password_reset_path(conn, :create), params)

      password_reset = Repo.one(PasswordReset)

      assert json_response(conn, 201)
      assert_delivered_email(PasswordResetEmail.create_email(password_reset, email))
    end

    test "responds with an error for invalid submissions", %{conn: conn} do
      email = "test@example.com"
      params = %{"email" => email}

      conn =
        conn
        |> accept_headers
        |> post(password_reset_path(conn, :create), params)

      assert %{"errors" => "User_id not found for that email"} = json_response(conn, 422)
    end
  end
end
