defmodule AuthenticationFlowServer.Accounts.GoogleSignIn do
  @moduledoc """
  Service Object for validating a Google Token. This checks to ensure that a given token was:
  1. Signed by one of Google's current certificates
  2. Has not expired
  3. Came from Google
  4. Came from the client that this server expects.
  """

  import Joken
  alias AuthenticationFlowServer.Accounts.{CertificatesProvider, TokenVerificationError}

  @iss_options Application.get_env(:authentication_flow_server, :iss_options)
  @rs256_base Application.get_env(:authentication_flow_server, :rs256_base)
  @client_ids Application.get_env(:authentication_flow_server, :client_ids)

  def perform(google_token) do
    token =
      google_token
      |> signed_by_a_current_google_certificate
      |> has_not_expired
      |> issuer_is_google
      |> audience_is_valid_client

    {:ok, token.claims}
  end

  defp signed_by_a_current_google_certificate(google_token) do
    fetch_google_certificates()
    |> select_google_certificate(google_token)
    |> verify_token(google_token)
  end

  defp verify_token(public_key, google_token) when is_map(public_key) do
    token =
      google_token
      |> token
      |> with_signer(rs256(public_key))
      |> verify

    cond do
      token.errors != [] || token.error != nil ->
        error("Could not verify Google Token with Google Certificate")
      true ->
        token
    end
  end

  defp verify_token(_public_key, _google_token) do
    error("Could not verify Google Token with Google Certificate")
  end

  defp construct_public_key(selected_google_cerificate) do
    Map.merge(selected_google_cerificate, @rs256_base)
  end

  defp select_google_certificate(google_certificates, google_token) do
    cert = Enum.find(google_certificates, fn(cert) ->
      cert["kid"] == kid(google_token)
    end)

    case cert do
      nil -> error("kid does not match that of any active Google certificate")
      %{} -> construct_public_key(cert)
    end
  end

  defp kid(google_token) do
    try do
      Joken.peek_header(token(google_token))["kid"]
    rescue
      ArgumentError -> error("header does not include kid")
    end
  end

  defp fetch_google_certificates do
    {:ok, certificates} = CertificatesProvider.fetch()

    certificates
  end

  defp has_not_expired(google_token) do
    (google_token.claims["exp"] > now())
    |> check_claim("expiration has passed")
    google_token
  end

  defp issuer_is_google(google_token) do
    Enum.member?(@iss_options, google_token.claims["iss"])
    |> check_claim("issuer does not match")

    google_token
  end

  defp audience_is_valid_client(google_token) do
    Enum.member?(@client_ids, google_token.claims["aud"])
    |> check_claim("client id is not a valid audience")

    google_token
  end

  defp check_claim(claim, error_message) do
    unless claim do
      error(error_message)
    end
  end

  defp now do
    DateTime.utc_now()
    |> DateTime.to_unix
  end

  defp error(message) do
    raise TokenVerificationError, "Invalid Google JWT: " <> message
  end
end
