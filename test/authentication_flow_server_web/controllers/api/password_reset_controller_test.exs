defmodule AuthenticationFlowServerWeb.PasswordResetControllerTest do
  use AuthenticationFlowServerWeb.ConnCase

  describe "create/2" do
    test "responds with JSON for a Password Reset", %{conn: conn} do
      email = "test@example.com"
      insert(:user, email: email)
      params = %{"email" => email}

      conn =
        conn
        |> accept_headers
        |> post(password_reset_path(conn, :create), params)

      assert json_response(conn, 201)
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
