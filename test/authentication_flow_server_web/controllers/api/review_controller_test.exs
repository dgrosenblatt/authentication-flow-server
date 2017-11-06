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

  describe "index/4" do
    test "responds with JSON for all reviews the current user has created", %{conn: conn} do
      user = insert(:user)
      insert_list(3, :review, user: user)

      conn =
        conn
        |> authorization_headers(user)
        |> get(review_path(conn, :index))

      assert json_response(conn, 200)
    end

    test "responds with a 401 without a valid token", %{conn: conn} do
      conn =
        conn
        |> accept_headers
        |> get(review_path(conn, :index))
      assert %{"errors" => ["Unauthenticated"]} == json_response(conn, 401)
    end
  end
end
