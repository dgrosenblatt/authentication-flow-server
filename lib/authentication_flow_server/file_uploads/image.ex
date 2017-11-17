defmodule AuthenticationFlowServer.FileUploads.Image do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthenticationFlowServer.FileUploads.Image


  schema "images" do
    field :s3_object_key, :string

    timestamps()
  end

  def changeset(%Image{} = image, attrs) do
    image
    |> cast(attrs, [:s3_object_key])
    |> validate_required([:s3_object_key])
  end
end
