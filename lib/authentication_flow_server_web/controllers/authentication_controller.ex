defmodule AuthenticationFlowServerWeb.AuthenticationController do
  use AuthenticationFlowServerWeb, :controller
  alias AuthenticationFlowServer.Accounts
  alias AuthenticationFlowServerWeb.UserView

  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.authenticate_email_password(user_params),
         conn <- Guardian.Plug.api_sign_in(conn, user),
         token <- Guardian.Plug.current_token(conn) do

      conn
      |> assign(:token, token)
      |> assign(:user, user)
      |> put_status(:created)
      |> render(UserView, "create.json")
    end
  end
end
