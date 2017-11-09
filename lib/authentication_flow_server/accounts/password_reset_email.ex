defmodule AuthenticationFlowServer.Accounts.PasswordResetEmail do
  use Bamboo.Phoenix, view: AuthenticationFlowServerWeb.EmailView
  import Bamboo.Email
  alias AuthenticationFlowServer.Accounts.PasswordReset

  @sender_email Application.get_env(:authentication_flow_server, :sender_email)

  def create_email(%PasswordReset{token: token}, email_address) do
    new_email()
    |> to(email_address)
    |> from(@sender_email)
    |> subject("Reset Your Password")
    |> assign(:token, token)
    |> render("create_password_reset.html")
  end
end
