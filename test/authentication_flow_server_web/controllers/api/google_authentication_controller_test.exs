defmodule AuthenticationFlowServerWeb.GoogleAuthenticationControllerTest do
  use AuthenticationFlowServerWeb.ConnCase
  import Mock
  alias AuthenticationFlowServer.Accounts.GoogleSignIn

  describe "create/2" do
    test "with an existing email responds with JSON for a user and a JWT", %{conn: conn} do
      with_mock GoogleSignIn, [perform: fn(_token) -> {:ok, %{"email" => "ex@mp.le", "sub" => "123"}} end] do
        insert(:user, email: "ex@mp.le", encrypted_password: "")
        params = %{"google_token" => "abc123"}
        conn = post(conn, google_authentication_path(conn, :create), params)

        assert %{
          "user" => %{"email" => "ex@mp.le"},
          "token" => token
        } = json_response(conn, 201)
        assert !is_nil(token)
      end
    end

    test "with an unknown email responds with JSON for a user and a JWT", %{conn: conn} do
      with_mock GoogleSignIn, [perform: fn(_token) -> {:ok, %{"email" => "ex@mp.le", "sub" => "123"}} end] do
        params = %{"google_token" => "abc123"}
        conn = post(conn, google_authentication_path(conn, :create), params)

        assert %{
          "user" => %{"email" => "ex@mp.le"},
          "token" => token
        } = json_response(conn, 201)
        assert !is_nil(token)
      end
    end
  end
end
