defmodule AuthenticationFlowServerWeb.ReviewController do
  use AuthenticationFlowServerWeb, :controller
  use Guardian.Phoenix.Controller
  import Ecto.Query
  alias AuthenticationFlowServer.{Repo, MovieReviews, MovieReviews.Movie, MovieReviews.Review}
  plug Guardian.Plug.EnsureAuthenticated
  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"review" => params}, current_user, _claims) do
    with %Movie{} <- Repo.get(Movie, params["movie_id"]),
         review_params <- Map.put(params, "user_id", current_user.id),
         {:ok, review} <- MovieReviews.create_review(review_params)
    do
      conn
      |> assign(:review, review)
      |> put_status(:created)
      |> render("review.json")
    else
      nil -> {:error, :not_found}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update(conn, %{"id" => id, "review" => review_params}, current_user, _claims) do
    with %Review{} = review <- Repo.get_by(Review, id: id, user_id: current_user.id),
         {:ok, review} <- MovieReviews.update_review(review, review_params)
    do
      conn
      |> assign(:review, review)
      |> render("review.json")
    else
      nil -> {:error, :not_found}
    end
  end

  def index(conn, _params, current_user, _claims) do
    reviews =
      Review
      |> where(user_id: ^current_user.id)
      |> Repo.all

    conn
    |> assign(:reviews, reviews)
    |> render("index.json")
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    with %Review{} = review <- Repo.get_by(Review, id: id, user_id: current_user.id) do
      conn
      |> assign(:review, review)
      |> render("review.json")
    else
      nil -> {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    with %Review{} = review <- Repo.get_by(Review, id: id, user_id: current_user.id),
         {:ok, %Review{id: review_id}} <- MovieReviews.delete_review(review)
    do
      conn
      |> put_resp_header("location", "#{review_id}")
      |> put_resp_content_type("application/json")
      |> send_resp(:no_content, "{}")
    else
      nil -> {:error, :not_found}
    end
  end
end
