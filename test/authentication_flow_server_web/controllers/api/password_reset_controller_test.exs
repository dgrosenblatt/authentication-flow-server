defmodule AuthenticationFlowServerWeb.PasswordResetControllerTest do
  use AuthenticationFlowServerWeb.ConnCase
  import Mock
  alias AuthenticationFlowServer.Accounts.PasswordReset
  alias AuthenticationFlowServer.Mail.SendgridMailer
  alias AuthenticationFlowServer.Repo

  describe "create/2" do
    test "responds with JSON for a Password Reset and sends an email", %{conn: conn} do
      with_mock SendgridMailer, [deliver_later: fn(:password_reset_created, _email, _token) -> :ok end] do
        email = "test@example.com"
        insert(:user, email: email)
        params = %{"email" => email}

        conn =
          conn
          |> accept_headers
          |> post(password_reset_path(conn, :create), params)

        password_reset = Repo.one(PasswordReset)

        assert json_response(conn, 201)
        assert called(
          SendgridMailer.deliver_later(:password_reset_created, email, password_reset.token)
        )
      end
    end

    test "responds with an error for invalid submissions", %{conn: conn} do
      email = "test@example.com"
      params = %{"email" => email}

      conn =
        conn
        |> accept_headers
        |> post(password_reset_path(conn, :create), params)

      assert %{"errors" => "Not found"} = json_response(conn, 404)
    end
  end
end
