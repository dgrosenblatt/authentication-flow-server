defmodule AuthenticationFlowServerWeb.PasswordResetController do
  use AuthenticationFlowServerWeb, :controller
  alias AuthenticationFlowServer.{Accounts, Mail.SendgridMailer}

  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"email" => email}) do
    with {:ok, attrs} <- Accounts.build_password_reset(email),
         {:ok, password_reset} <- Accounts.create_password_reset(attrs)
    do
      SendgridMailer.deliver_later(:password_reset_created, email, password_reset.token)

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:created, "{}")
    end
  end
end
