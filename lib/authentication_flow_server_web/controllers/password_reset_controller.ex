defmodule AuthenticationFlowServerWeb.PasswordResetController do
  use AuthenticationFlowServerWeb, :controller
  alias AuthenticationFlowServer.Accounts

  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"email" => email}) do
    with {:ok, _password_reset} <- Accounts.create_password_reset(email) do
      # and send an email to the email address
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(:created, "{}")
    end
  end
end
