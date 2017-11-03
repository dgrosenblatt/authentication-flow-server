defmodule AuthenticationFlowServerWeb.ReviewControllerTest do
  use AuthenticationFlowServerWeb.ConnCase

  describe "create/4" do
    test "responds with JSON for a review with valid params", %{conn: conn} do
      user = insert(:user)
      movie = insert(:movie)

      params = %{"review" => %{
        "movie_id" => movie.id,
        "body" => "It was really good.",
        "rating" => 10}}

      conn =
        conn
        |> authorization_headers(user)
        |> post(review_path(conn, :create), params)

      assert %{
        "review" => %{
          "user_id" => _,
          "movie_id" => _,
          "body" => _,
          "rating" => _
        }
      } = json_response(conn, 201)
    end

    test "responds with an error for invalid submissions", %{conn: conn} do
      user = insert(:user)
      movie = insert(:movie)
      params = %{"review" => %{"movie_id" => movie.id, "body" => "", "rating" => ""}}

      conn =
        conn
        |> authorization_headers(user)
        |> post(review_path(conn, :create), params)

      assert %{"errors" => _} = json_response(conn, 422)
    end

    test "responds with a 401 without a valid token", %{conn: conn} do
      conn =
        conn
        |> accept_headers
        |> post(review_path(conn, :create), %{})
      assert %{"errors" => ["Unauthenticated"]} == json_response(conn, 401)
    end
  end
end
