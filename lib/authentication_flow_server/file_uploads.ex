defmodule AuthenticationFlowServer.FileUploads do
  alias AuthenticationFlowServer.{Repo, FileUploads.Image}

  def create_image(image_params) do
    %Image{}
    |> Image.changeset(image_params)
    |> Repo.insert
  end

  def all_images() do
    Repo.all(Image)
  end
end
