defmodule AuthenticationFlowServerWeb.GoogleAuthenticationController do
  use AuthenticationFlowServerWeb, :controller
  alias AuthenticationFlowServer.{Accounts, Accounts.GoogleSignIn}

  action_fallback AuthenticationFlowServerWeb.ErrorController

  def create(conn, %{"google_token" => google_token}) do
    with {:ok, %{"email" => email, "sub" => _g_id}} <- GoogleSignIn.perform(google_token),
         {:ok, user} <- Accounts.find_or_create_user_by_email(email),
         conn <- Guardian.Plug.api_sign_in(conn, user),
         token <- Guardian.Plug.current_token(conn) do

      conn
      |> assign(:token, token)
      |> assign(:user, user)
      |> put_status(:created)
      |> render("create.json")
    end
  end
end
