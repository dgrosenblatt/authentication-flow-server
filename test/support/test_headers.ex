defmodule AuthenticationFlowServerWeb.TestHeaders do
  def accept_headers(conn) do
    conn
    |> Plug.Conn.put_req_header("accept", "application/json")
    |> Plug.Conn.put_req_header("content-type", "application/json")
  end

  def authorization_headers(conn, user) do
    {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :auth_token)

    conn
    |> accept_headers
    |> Plug.Conn.put_req_header("authorization", "bearer " <> jwt)
  end
end
