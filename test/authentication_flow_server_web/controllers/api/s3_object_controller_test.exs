defmodule AuthenticationFlowServerWeb.S3ObjectControllerTest do
  use AuthenticationFlowServerWeb.ConnCase
  import Mock

  describe "create/2" do
    test "responds with JSON for an S3 Object", %{conn: conn} do
      with_mock ExAws, [request: fn(_) -> {:ok, "randomkey"} end] do
        user = insert(:user)

        conn =
          conn
          |> authorization_headers(user)
          |> post(s3_object_path(conn, :create))

        assert %{"s3_object" => %{
          "key" => _,
          "presigned_put_url" => _
        }} = json_response(conn, 201)
      end
    end
  end
end
