defmodule AuthenticationFlowServerWeb.EmailView do
  use AuthenticationFlowServerWeb, :view

  @ios_app_url_identifier Application.get_env(:authentication_flow_server, :ios_app_url_identifier)

  def redeem_password_reset_url(token) do
    %URI{
      scheme: @ios_app_url_identifier,
      query: "token=#{token}",
      path: "password_resets"}
    |> URI.to_string
  end
end
