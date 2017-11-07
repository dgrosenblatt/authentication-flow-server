defmodule AuthenticationFlowServerWeb.ReviewControllerTest do
  use AuthenticationFlowServerWeb.ConnCase
  alias AuthenticationFlowServer.{MovieReviews.Review, Repo}

  describe "create/4" do
    test "responds with JSON for a review with valid params", %{conn: conn} do
      user = insert(:user)
      movie = insert(:movie)

      params = %{"review" => %{
        "movie_id" => movie.id,
        "body" => "It was really good.",
        "rating" => 10}
      }

      conn =
        conn
        |> authorization_headers(user)
        |> post(review_path(conn, :create), params)

      assert %{"review" => review_json} = json_response(conn, 201)
      assert_json_paths_for_review(review_json)
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
      _other_review = insert(:review)

      conn =
        conn
        |> authorization_headers(user)
        |> get(review_path(conn, :index))

      assert %{"reviews" => reviews_json} = json_response(conn, 200)
      assert Enum.count(reviews_json) == 3

      reviews_json
      |> List.first
      |> assert_json_paths_for_review
    end

    test "responds with a 401 without a valid token", %{conn: conn} do
      conn =
        conn
        |> accept_headers
        |> get(review_path(conn, :index))
      assert %{"errors" => ["Unauthenticated"]} == json_response(conn, 401)
    end
  end

  describe "update/4" do
    test "responds with JSON for a review", %{conn: conn} do
      user = insert(:user)
      review = insert(:review, user: user)
      params = %{"review" => %{
        "body" => "It actually wasn't that good", "rating" => 1}
      }

      conn =
        conn
        |> authorization_headers(user)
        |> patch(review_path(conn, :update, review), params)

      assert %{"review" => review_json} = json_response(conn, 200)
      assert_json_paths_for_review(review_json)
    end

    test "responds with 403 Forbidden if the user does not own the review", %{conn: conn} do
      user = insert(:user)
      review = insert(:review)

      conn =
        conn
        |> authorization_headers(user)
        |> patch(review_path(conn, :update, review), %{"review" => %{}})

      assert %{"errors" => "Forbidden"} == json_response(conn, 403)
    end

    test "responds with 401 without a valid token", %{conn: conn} do
      conn =
        conn
        |> accept_headers
        |> patch(review_path(conn, :update, 1))
      assert json_response(conn, 401)
    end
  end

  describe "show/4" do
    test "responds with JSON for a review", %{conn: conn} do
      user = insert(:user)
      review = insert(:review, user: user)

      conn =
        conn
        |> authorization_headers(user)
        |> get(review_path(conn, :show, review))

      assert %{"review" => review_json} = json_response(conn, 200)
      assert_json_paths_for_review(review_json)
    end

    test "responds with 403 Forbidden if the user does not own the review", %{conn: conn} do
      user = insert(:user)
      review = insert(:review)

      conn =
        conn
        |> authorization_headers(user)
        |> get(review_path(conn, :show, review))

      assert %{"errors" => "Forbidden"} == json_response(conn, 403)
    end

    test "responds with 401 without a valid token", %{conn: conn} do
      conn =
        conn
        |> accept_headers
        |> get(review_path(conn, :show, 1))
      assert json_response(conn, 401)
    end
  end

  describe "delete/4" do
    test "deletes a review and responds with 204 No Content", %{conn: conn} do
      user = insert(:user)
      review = insert(:review, user: user)

      conn =
        conn
        |> authorization_headers(user)
        |> delete(review_path(conn, :delete, review))

      assert json_response(conn, 204)
      review_count = Repo.aggregate(Review, :count, :id)
      assert review_count == 0
    end

    test "responds with 403 Forbidden if the user does not own the review", %{conn: conn} do
      user = insert(:user)
      review = insert(:review)

      conn =
        conn
        |> authorization_headers(user)
        |> delete(review_path(conn, :delete, review))

      assert %{"errors" => "Forbidden"} == json_response(conn, 403)
    end

    test "responds with 401 without a valid token", %{conn: conn} do
      conn =
        conn
        |> accept_headers
        |> delete(review_path(conn, :delete, 1))
      assert json_response(conn, 401)
    end
  end

  defp assert_json_paths_for_review(review) do
    assert %{
      "user_id" => _,
      "movie_id" => _,
      "body" => _,
      "rating" => _
    } = review
  end
end
