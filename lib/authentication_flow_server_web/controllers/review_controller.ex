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

  def index(conn, _params, current_user, _claims) do
    reviews =
      Review
      |> where(user_id: ^current_user.id)
      |> Repo.all

    conn
    |> assign(:reviews, reviews)
    |> render("index.json")
  end
end
