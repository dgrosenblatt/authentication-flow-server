defmodule AuthenticationFlowServerWeb.S3ObjectController do
  use AuthenticationFlowServerWeb, :controller
  use Guardian.Phoenix.Controller
  alias AuthenticationFlowServer.S3Object

  plug Guardian.Plug.EnsureAuthenticated
  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, _params, _current_user, _claims) do
    with {:ok, key} <- S3Object.create_object(),
         {:ok, url} <- S3Object.presigned_put(key)
    do
      conn
      |> assign(:key, key)
      |> assign(:presigned_put_url, url)
      |> put_status(:created)
      |> render("s3_object.json")
    end
  end
end
