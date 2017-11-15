defmodule AuthenticationFlowServerWeb.S3ObjectView do
  use AuthenticationFlowServerWeb, :view

  def render("s3_object.json", %{key: key, presigned_put_url: presigned_put_url}) do
    %{
      s3_object: %{
        key: key,
        presigned_put_url: presigned_put_url
      }
    }
  end
end
