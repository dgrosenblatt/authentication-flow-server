defmodule AuthenticationFlowServerWeb.PasswordResetController do
  use AuthenticationFlowServerWeb, :controller
  alias AuthenticationFlowServer.{Accounts, Accounts.PasswordResetEmail, Mailer}

  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"email" => email}) do
    with {:ok, password_reset} <- Accounts.create_password_reset(email) do
      password_reset
      |> PasswordResetEmail.create_email(email)
      |> Mailer.deliver_later

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:created, "{}")
    end
  end
end
