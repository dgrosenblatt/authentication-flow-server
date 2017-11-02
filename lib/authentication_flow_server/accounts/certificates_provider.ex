defmodule AuthenticationFlowServer.Accounts.CertificatesProvider do
  alias AuthenticationFlowServer.Accounts.CertificateCache
  @moduledoc """
  Service Object for getting the current google certificates.
  """

  @google_certifications_url Application.get_env(:google_sign_in, :certifications_url)

  def fetch do
    CertificateCache.fetch(today(), fn -> fetch_certificates_from_web() end)
  end

  defp fetch_certificates_from_web do
    case HTTPoison.get(@google_certifications_url) do
      {:ok, response} -> decode_response(response)
      _ -> {:error, ["Could not reach google servers to authenticate"]}
    end
  end

  defp decode_response(response) do
    case Poison.decode(response.body) do
      {:ok, body} -> {:ok, body["keys"]}
      :error -> {:error, ["Poison could not parse body"]}
    end
  end

  defp today do
    DateTime.utc_now
    |> DateTime.to_date
    |> Date.to_iso8601
  end
end
