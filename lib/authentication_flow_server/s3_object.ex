defmodule AuthenticationFlowServer.S3Object do
  @moduledoc """
  Functions for managing an Amazon Web Services S3 bucket
  """
  alias ExAws.S3

  @bucket Application.get_env(:ex_aws, :s3_bucket)
  @config ExAws.Config.new(:s3)

  @doc """
  Creates an object in an S3 bucket with a random key
  """
  def create_object() do
    key = Ecto.UUID.generate
    request_params = S3.put_object(@bucket, key, nil)

    case ExAws.request(request_params) do
      {:ok, _} -> {:ok, key}
      {:error, _} -> {:error, :aws_error}
    end
  end

  def presigned_put(object_key),
    do: S3.presigned_url(@config, :put, @bucket, object_key)
end
