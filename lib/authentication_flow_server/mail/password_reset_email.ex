defmodule AuthenticationFlowServer.Mail.PasswordResetEmail do
  @moduledoc """
  Functions for generating emails related to PasswordResets
  """

  alias AuthenticationFlowServer.Mail.Email

  @sender_email Application.get_env(:authentication_flow_server, :sender_email)
  @ios_app_url_identifier Application.get_env(:authentication_flow_server, :ios_app_url_identifier)

  def created_email(recipient_email, token) do
    body = create_password_reset_body(token)

    %Email{
      to: recipient_email,
      from: @sender_email,
      subject: "Reset Your Password",
      body: body
    }
  end

  defp create_password_reset_body(token) do
    """
    Hello,
    You recently requested a password reset. Please click the following link \
    to open the app and reset your password:
    #{redeem_password_reset_url(token)} .
    Please note this link will expire in one hour.
    """
  end

  defp redeem_password_reset_url(token) do
    %URI{
      scheme: @ios_app_url_identifier,
      query: "token=#{token}",
      path: "//password_resets"}
    |> URI.to_string
  end
end
