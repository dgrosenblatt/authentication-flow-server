defmodule AuthenticationFlowServerWeb.RedeemPasswordResetControllerTest do
  use AuthenticationFlowServerWeb.ConnCase
  alias Calendar.DateTime

  describe "update/2" do
    test "responds with JSON for a user and a JWT", %{conn: conn} do
      user = insert(:user, email: "ex@mp.le")
      password_reset = insert(:password_reset, user: user)
      params = %{password: "new password"}
      conn =
        conn
        |> accept_headers
        |> patch(redeem_password_reset_path(conn, :update, password_reset.token), params)

      assert %{
        "user" => %{"email" => "ex@mp.le"},
        "token" => _
      } = json_response(conn, 200)
    end

    test "responds with an error when the token is not associated with a user", %{conn: conn} do
      params = %{password: "new password"}
      conn =
        conn
        |> accept_headers
        |> patch(redeem_password_reset_path(conn, :update, "faketoken"), params)

      assert %{"errors" => "Not found"} = json_response(conn, 404)
    end

    test "responds with an error when the token is expired", %{conn: conn} do
      user = insert(:user, email: "ex@mp.le")
      password_reset =
        insert(:password_reset, user: user, expired_at: DateTime.subtract!(DateTime.now_utc(), 300))
      params = %{password: "new password"}

      conn =
        conn
        |> accept_headers
        |> patch(redeem_password_reset_path(conn, :update, password_reset.token), params)

      assert %{"errors" => "Token has expired"} = json_response(conn, 422)
    end

    test "responds with an error when the token is already redeemed", %{conn: conn} do
      user = insert(:user, email: "ex@mp.le")
      password_reset =
        insert(:password_reset, user: user, redeemed_at: DateTime.now_utc())
      params = %{password: "new password"}

      conn =
        conn
        |> accept_headers
        |> patch(redeem_password_reset_path(conn, :update, password_reset.token), params)

      assert %{"errors" => "Token was already redeemed"} = json_response(conn, 422)
    end
  end
end
