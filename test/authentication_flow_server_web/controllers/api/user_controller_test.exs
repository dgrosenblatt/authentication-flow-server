defmodule AuthenticationFlowServerWeb.UserControllerTest do
  use AuthenticationFlowServerWeb.ConnCase

  describe "create/2" do
    test "responds with JSON for a user and a JWT", %{conn: conn} do
      params = %{"user" => %{ "email" => "ex@mp.le", "password" => "pw"}}
      conn = post(conn, user_path(conn, :create), params)

      assert %{
        "user" => %{"email" => "ex@mp.le"},
        "token" => _
      } = json_response(conn, 201)
    end

    test "responds with an error for invalid submissions", %{conn: conn} do
      params = %{"user" => %{ "email" => "", "password" => ""}}
      conn = post(conn, user_path(conn, :create), params)
      assert %{"errors" => "Email can't be blank" } = json_response(conn, 422)
    end
  end
end
