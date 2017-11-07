defmodule AuthenticationFlowServerWeb.MovieControllerTest do
  use AuthenticationFlowServerWeb.ConnCase

  describe "index/4" do
    test "responds with JSON for a movie and nested associations when v1", %{conn: conn} do
      user = insert(:user)
      movie = insert(:movie)
      insert(:role, movie: movie)
      insert(:review, user: user, movie: movie)

      conn =
        conn
        |> authorization_headers(user)
        |> get("v1/movies")

      assert %{"movies" => [
        %{"name" => _,
          "release_date" => _,
          "actors" => [%{"name" => _}],
          "reviews" => [%{"rating" => _, "body" => _}],
          "director" => %{"name" => _},
        }
      ]} = json_response(conn, 200)
    end

    test "responds with JSON for a movie and side-loaded associations when v2", %{conn: conn} do
      user = insert(:user)
      movie = insert(:movie)
      insert(:role, movie: movie)
      insert(:review, user: user, movie: movie)

      conn =
        conn
        |> authorization_headers(user)
        |> get("v2/movies")

      assert %{
        "movies" => [%{"name" => _, "release_date" => _, "director_id" => _, "actor_ids" => _, "review_ids" => _}],
        "directors" => [%{"name" => _}],
        "actors" => [%{"name" => _}],
        "reviews" => [%{"rating" => _, "body" => _}],
        "users" => [%{"email" => _}]
      } = json_response(conn, 200)
    end

    test "responds with a 401 without a valid token", %{conn: conn} do
      conn =
        conn
        |> accept_headers
        |> get("v1/movies")
      assert %{"errors" => ["Unauthenticated"]} == json_response(conn, 401)
    end
  end
end
