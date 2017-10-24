defmodule AuthenticationFlowServerWeb.SignUpControllerTest do
  use AuthenticationFlowServerWeb.ConnCase

  describe "create/2" do
    test "responds with the same provided user data", %{conn: conn} do
      params = %{"user" => %{ "email" => "ex@mp.le", "password" => "pw"}}
      conn = post(conn, sign_up_path(conn, :create), params)
      assert json_response(conn, 201) == params
    end
  end
end
