defmodule AuthenticationFlowServerWeb.ReviewController do
  use AuthenticationFlowServerWeb, :controller
  use Guardian.Phoenix.Controller
  alias AuthenticationFlowServer.MovieReviews

  plug Guardian.Plug.EnsureAuthenticated
  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"review" => review_params}, current_user, _claims) do
    with user_review_params <- Map.put(review_params, "user_id", current_user.id),
         {:ok, review} <- MovieReviews.create_review(user_review_params),
         preloaded_review <- MovieReviews.preload_review(review)
    do
      conn
      |> assign(:review, preloaded_review)
      |> put_status(:created)
      |> render("create.json")
    end
  end

  def update(conn, %{"id" => id, "review" => review_params}, current_user, _claims) do
    with {:ok, review} <- MovieReviews.get_review_by_id_for_user(id, current_user),
         {:ok, updated_review} <- MovieReviews.update_review(review, review_params),
         preloaded_review <- MovieReviews.preload_review(updated_review)
    do
      conn
      |> assign(:review, preloaded_review)
      |> render("update.json")
    end
  end

  def index(conn, _params, current_user, _claims) do
    reviews =
      current_user
      |> MovieReviews.all_reviews_for_user
      |> MovieReviews.preload_review

    conn
    |> assign(:reviews, reviews)
    |> render("index.json")
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    with {:ok, review} <- MovieReviews.get_review_by_id_for_user(id, current_user),
         preloaded_review <- MovieReviews.preload_review(review)
    do
      conn
      |> assign(:review, preloaded_review)
      |> render("show.json")
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    with {:ok, review} <- MovieReviews.get_review_by_id_for_user(id, current_user),
         {:ok, %{id: review_id}} <- MovieReviews.delete_review(review)
    do
      conn
      |> put_resp_header("location", "#{review_id}")
      |> put_resp_content_type("application/json")
      |> send_resp(:no_content, "{}")
    end
  end
end
