defmodule AuthenticationFlowServerWeb.ImageView do
  use AuthenticationFlowServerWeb, :view
  alias AuthenticationFlowServer.S3Object

  def render("create.json", %{image: image}) do
    %{image: render_one(image, __MODULE__, "image.json")}
  end

  def render("index.json", %{images: images}) do
    %{images: render_many(images, __MODULE__, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{id: image.id,
      updated_at: image.updated_at,
      inserted_at: image.inserted_at,
      s3_object_key: image.s3_object_key,
      url: s3_url(image.s3_object_key)}
  end

  defp s3_url(s3_object_key) do
    case S3Object.presigned_get(s3_object_key) do
      {:ok, url} -> url
      {:error, _} -> nil
    end
  end
end
