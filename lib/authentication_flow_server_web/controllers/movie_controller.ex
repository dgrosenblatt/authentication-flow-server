defmodule AuthenticationFlowServerWeb.MovieController do
  use AuthenticationFlowServerWeb, :controller
  use Guardian.Phoenix.Controller
  import Ecto.Query
  alias AuthenticationFlowServer.{MovieReviews.Movie, Repo}
  plug Guardian.Plug.EnsureAuthenticated

  def index(conn, _params, _current_user, _claims) do
    movies = Repo.all(from m in Movie, preload: [:actors, :director, reviews: :user])

    conn
      |> assign(:movies, movies)
      |> render("index.json")
  end
end
