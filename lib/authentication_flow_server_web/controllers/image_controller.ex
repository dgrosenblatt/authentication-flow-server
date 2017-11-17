defmodule AuthenticationFlowServerWeb.ImageController do
  use AuthenticationFlowServerWeb, :controller
  use Guardian.Phoenix.Controller
  alias AuthenticationFlowServer.FileUploads

  plug Guardian.Plug.EnsureAuthenticated
  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"image" => image_params}, _current_user, _claims) do
    with {:ok, image} <- FileUploads.create_image(image_params) do
      conn
      |> assign(:image, image)
      |> put_status(:created)
      |> render("create.json")
    end
  end

  def index(conn, _params, _current_user, _claims) do
    images = FileUploads.all_images()

    conn
    |> assign(:images, images)
    |> render("index.json")
  end
end
