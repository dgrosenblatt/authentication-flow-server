defmodule AuthenticationFlowServerWeb.AuthenticationControllerTest do
  use AuthenticationFlowServerWeb.ConnCase

  @password "password1"
  @encrypted_password Comeonin.Bcrypt.hashpwsalt(@password)

  describe "create/2" do
    test "with valid email and password responds with JSON for a user and a JWT", %{conn: conn} do
      email = "ex@mp.le"
      insert(:user, email: email, encrypted_password: @encrypted_password)
      params = %{"user" => %{ "email" => email, "password" => @password}}
      conn = post(conn, authentication_path(conn, :create), params)

      assert %{
        "user" => %{"email" => "ex@mp.le"},
        "token" => token
      } = json_response(conn, 201)
      assert !is_nil(token)
    end

    test "with invalid credentials responds with a 401 Error", %{conn: conn} do
      params = %{"user" => %{ "email" => "ex@mp.le", "password" => "wrong_password"}}
      conn = post(conn, authentication_path(conn, :create), params)
      assert %{"errors" => "Unauthorized"} = json_response(conn, 401)
    end
  end
end
