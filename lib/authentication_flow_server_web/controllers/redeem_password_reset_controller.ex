defmodule AuthenticationFlowServerWeb.RedeemPasswordResetController do
  use AuthenticationFlowServerWeb, :controller
  alias AuthenticationFlowServer.Accounts

  action_fallback AuthenticationFlowServerWeb.ErrorController

  def update(conn, %{"token" => token, "password" => password}) do
    with {:ok, user} <- Accounts.reset_user_password(token, password),
         conn <- Guardian.Plug.api_sign_in(conn, user),
         token <- Guardian.Plug.current_token(conn)
    do
      conn
      |> assign(:user, user)
      |> assign(:token, token)
      |> render("user.json")
    end
  end
end
